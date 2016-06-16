//
//  NSObject+dealloc.m
//  XMNotification(安全通知=)====2016.05.31
//
//  Created by tianyu on 16/5/31.
//  Copyright © 2016年 Guoxiaoming. All rights reserved.
//

#import "NSObject+dealloc.h"
#import <objc/runtime.h>
#import "XMNotificationCenter.h"
#import "XMImplenmentation.h"

@implementation NSObject (dealloc)

static NSString* keyInfo = @"keyInfo";
static NSString* obseverKey = @"obseverKey";
static NSString* notifacationObjectKey = @"notifacationObjectKey";
static NSString* notifacationName = @"notifacationName";


- (void)XMDealloc
{
    NSLog(@"NSObject (dealloc)come here =====%@",self);
    
    //调用一个block，然后告诉要移除的监听器对象
    [XMNotificationCenter share].complection(self);
    NSMutableArray* impArray = [[XMNotificationCenter share].implentationArray mutableCopy];
    
    
    //记录进来的类
    NSString*classStr = nil;
    IMP imp  = nil;
    
    //数组中的监听器对象有多少个是同类，如Person
    int num = 0;
    
    NSString*obseverStr = nil;
    for (XMImplenmentation*imp in impArray) {
        obseverStr = [[XMNotificationCenter share] observerClassSubstringWith:imp.objectStr];
        if ([self isKindOfClass:NSClassFromString(obseverStr)]) {
            num++;
        }
    }
    
    
    
    for (XMImplenmentation*implentation in impArray) {
        
        //记录进来的类
        classStr = NSStringFromClass([self class]);
        
        if ([implentation.objectStr isEqualToString: [self description]]) {
            
            //每个监听器对象的dealloc的IMP
            imp = implentation.objectDeallocImp;
            Method method = class_getInstanceMethod([NSObject class], NSSelectorFromString(@"XMDealloc"));
            method_setImplementation(method, imp);
            
            //获得该调用者的类，取出对方的dealloc实现，设置XMDealloc的实现为调用者dealloc的实现，然后调用XMDealloc即可
            [self XMDealloc];
            
            //如果该类型的对象在数组中=1个，把该类的dealloc实现归位
            if(num == 1){
                Class c = NSClassFromString(classStr);
                Method method2 = class_getInstanceMethod(c, NSSelectorFromString(@"dealloc"));
                method_setImplementation(method2, imp);
            }
            
            //对象释放完毕后必须从数组中移除
            [[XMNotificationCenter share].implentationArray removeObject:implentation];
            
            break;
        }
    }
    
}



//此时的调用者self一定注意了
- (void)receiveNotificationResult:(id)sender
{
    
    NSNotification*notification = (NSNotification*)sender;
    NSString*name = notification.name;
    id object = notification.object;
    NSMutableDictionary*infoDic = [NSMutableDictionary new];
    
    NSLog(@"%@===receiveNotificationResult",name);
    
    if (!infoDic||!name) return;
    

    //1通过字典中的通知名字和监听器对象定位移除
    XMNotificationCenter*center = [XMNotificationCenter share];
    NSMutableArray*infos = center.dic[keyInfo];
    NSMutableArray*infosCopy = [infos mutableCopy];
    
   //耗时操作
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    
        for (NSMutableDictionary*info in infosCopy) {
            BOOL isSameObserver = [[self description]isEqualToString:info[obseverKey]];
            if ([info[notifacationName] isEqualToString:name]&&isSameObserver) {
                //数组中移除
                [infos removeObject:info];
                // 注销监听器对象
                [[NSNotificationCenter defaultCenter]removeObserver:self name:name object:object];
            }
        }
   
    
    NSMutableArray* impArray = [[XMNotificationCenter share].implentationArray mutableCopy];
    //记录进来的类
    NSString*classStr = nil;
    IMP imp  = nil;
    for (XMImplenmentation*implentation in impArray) {
        
        //记录进来的类
        classStr = NSStringFromClass([self class]);
        
        //同一个对象
        if ([implentation.objectStr isEqualToString: [self description]]&&[implentation.notificationName isEqualToString:name] ) {
            
            NSLog(@"object == %@ ----- self == %@",implentation.objectStr,[self description]);
            
            imp = implentation.receiveNotifacationImp;
            Method method = class_getInstanceMethod([NSObject class], NSSelectorFromString(@"receiveNotificationResult:"));
            method_setImplementation(method, imp);

            //2 调用selector方法
            [self receiveNotificationResult:sender];
            //把该类的收通知方法的实现归位
            Class c = NSClassFromString(classStr);
            Method method2 = class_getInstanceMethod(c, NSSelectorFromString(@"receiveNotificationOfPerson:"));
            method_setImplementation(method2, imp);
           
            //对象释放完毕后必须从数组中移除，数组中移除
            [[XMNotificationCenter share].implentationArray removeObject:implentation];
            
            break;
        }
    }
        
 });
    
}



@end

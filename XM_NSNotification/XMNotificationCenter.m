
//
//  XMNotificationCenter.m
//  XMNotification(安全通知)====2016.05.31
//
//  Created by tianyu on 16/5/31.
//  Copyright © 2016年 Guoxiaoming. All rights reserved.
//

#import "XMNotificationCenter.h"
#import <objc/runtime.h>
#import <UIKit/UIKit.h>
#import "NSObject+dealloc.h"


@interface XMNotificationCenter()
{
    NSMutableArray*_observers;
   
    XMImplenmentation* _implenmentation;

}

@property (nonatomic, copy)NSString* aName;
@property (nonatomic, strong)id anObject;
@property (nonatomic, strong)NSMutableDictionary*notifacationInfoDic;

/**  the point(IPM) to the XMDealloc method implenmentation */
@property (nonatomic, assign)IMP nsobjectXMDeallocImp;

/** the point(IMP) to callback of method implenmentation after receiving notification  */
@property (nonatomic, assign)IMP receiveNotifacationImp;

/** 存储注册过通知的类(只要有一次注册就被记录) */
@property (nonatomic, strong)NSMutableArray*classArray;

@end

@implementation XMNotificationCenter

static NSString* keyInfo = @"keyInfo";

static NSString* obseverKey = @"obseverKey";
static NSString* notifacationObjectKey = @"notifacationObjectKey";
static NSString* notifacationName = @"notifacationName";
static NSString* notifacationSelctor = @"notifacationSelctor";
//static NSString* notifacationBool = @"notifacationBool";


static id instance;

+ (instancetype)share
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        if (!instance) {
            instance = [[XMNotificationCenter alloc]init];
          
        }
    });
    
    return instance;
}

- (instancetype)init{
    if (self = [super init]) {
        _observers = [[NSMutableArray alloc]init];
        _nsobjectXMDeallocImp = class_getMethodImplementation([NSObject class], NSSelectorFromString(@"XMDealloc"));
        _receiveNotifacationImp = class_getMethodImplementation([NSObject class], NSSelectorFromString(@"receiveNotificationResult:"));
        _implentationArray = [[NSMutableArray alloc]init];
//        _classArray = [[NSMutableArray alloc]init];
    }
    return self;
}

- (void)builtWithNotificationCenter:(id)observer selector:(SEL)aSelector name:(NSString *)aName object:(id)anObject isRightNowRemove:(BOOL)isRightNowRemove
{
    
    if (!observer) return;
    self.aName = aName;
    self.anObject = anObject;
    
    //监听器对象
    [self.notifacationInfoDic setObject:[observer description] forKey:obseverKey];
    
    //通知名字
    if (aName) {
        [self.notifacationInfoDic setObject:aName forKey:notifacationName];
    }else{
        [self.notifacationInfoDic setObject:@"" forKey:notifacationName];
    }
    
    //通知对象
    if (anObject) {
        [self.notifacationInfoDic setObject:anObject forKey:notifacationObjectKey];
    }else{
        [self.notifacationInfoDic setObject:@"" forKey:notifacationObjectKey];
    }
    if (aSelector) {
        [self.notifacationInfoDic setObject:NSStringFromSelector(aSelector) forKey:notifacationSelctor];
    }else{
        [self.notifacationInfoDic setObject:@"" forKey:notifacationSelctor];
    }
    
//    [self.notifacationInfoDic setObject:isRightNowRemove?@YES:@NO forKey:notifacationBool];

    [self exchangeImplementationWithNotificationCenterWithObserver:observer andIsRightNowRemove:isRightNowRemove];
}



- (NSMutableDictionary *)dic
{
    if (_dic == nil) {
        _dic = [[NSMutableDictionary alloc]init];
        
    }
    return _dic;
}

/** 一条通知的部分相关信息 */
- (NSMutableDictionary *)notifacationInfoDic
{
    if (!_notifacationInfoDic) {
        _notifacationInfoDic = [[NSMutableDictionary alloc]init];
    }
    return _notifacationInfoDic;
}

/** 处理移除监听器对象的方法 */
- (void)exchangeImplementationWithNotificationCenterWithObserver:(id)observer andIsRightNowRemove:(BOOL)isRightNowRemove
{
    if (observer == nil) return;

    //用一个字典保存所有的通知消息
    if (!self.dic[keyInfo]) {
        NSMutableArray*notificationInfos = [[NSMutableArray alloc]init];
        self.dic[keyInfo] = notificationInfos;
    }
    
    //若数组里面有这条完全相同的注册信息，防止重复注册，直接返回
    if ([self.dic[keyInfo] containsObject: self.notifacationInfoDic]) return;
    
    //将通知信息添加到数组中
    [self.dic[keyInfo] addObject:[self.notifacationInfoDic copy]];//这个copy也要注意
    
    //注册通知
  [[NSNotificationCenter defaultCenter] addObserver:observer selector:NSSelectorFromString(self.notifacationInfoDic[notifacationSelctor]) name:self.aName object:self.anObject];
    
    if (isRightNowRemove) {//处理收到通知后立即移除监听器对象
        
        [self exchangeImplementationWithNotificationCenterWithaSelectorWithObserver:observer];
        
    }else{//监听器销毁前移除
        
        [self exchangeImplementationWithNotificationWithObserver:observer withModel:nil];
    }

}

/** 处理收到通知后立即移除的情况*/
- (void)exchangeImplementationWithNotificationCenterWithaSelectorWithObserver:(id)observer
{

   //将NSObject(dealloc)中receiveNotificationResult:的实现直接赋值给注册者
    Method method = class_getInstanceMethod([observer class], NSSelectorFromString(self.notifacationInfoDic[notifacationSelctor]));
    IMP receiveImp = method_getImplementation(method);
    
    //用模型保存
    //交换之前保存一份原dealloc实现
    XMImplenmentation*implentation = [[XMImplenmentation alloc]init];
    implentation.receiveNotifacationImp = receiveImp;
    implentation.objectStr = [observer description];
    implentation.notificationName = self.notifacationInfoDic[notifacationName];
//    implentation.removed = YES;
    method_setImplementation(method, _receiveNotifacationImp);
    
    //也要考虑监听器对象销毁的情况
    [self exchangeImplementationWithNotificationWithObserver:observer withModel:implentation];
  
}


- (void)exchangeImplementationWithNotificationWithObserver:(id)observer withModel:(XMImplenmentation*)implenmentation
{
    
    __weak typeof(self)weakSelf = self;
    self.complection = ^(id observer){

        //删除该监听对象的所有信息
        NSMutableArray*infos = [NSMutableArray arrayWithArray:[weakSelf.dic[keyInfo] copy]];
        
        for (NSMutableDictionary*dic in infos) {
            if ([dic[obseverKey] isEqualToString:[observer description]]) {
                //从数组中移除
                [weakSelf.dic[keyInfo] removeObject:dic];
                //移除通知中心注册过的监听器对象
                [[NSNotificationCenter defaultCenter]removeObserver:observer name:dic[notifacationName] object:dic[notifacationObjectKey]];
            }
        }
        
    };
    
    [self exchangeImplementationWithNotification:observer withModel:implenmentation];

}

- (void)exchangeImplementationWithNotification:(id)observer withModel:(XMImplenmentation*)implenmentation
{
 
    
    //获得监听器对象的dealloc方法的实现的指针
    IMP objectDeallocImp = class_getMethodImplementation([observer class], NSSelectorFromString(@"dealloc"));

    
    if (!implenmentation) {
        
        implenmentation = [[XMImplenmentation alloc]init];
        
        implenmentation.objectStr = [observer description];
//        implenmentation.removed = NO;
    }
    
    implenmentation.objectDeallocImp = objectDeallocImp;
    
    if (![_implentationArray containsObject:implenmentation]) {
     
    //用全局的字典记录关于实现的这个模型
    [_implentationArray addObject:implenmentation];
        
    }
    
    //相同的监听对象只交换一次
    NSInteger number = 0;
    for (NSMutableDictionary*info in self.dic[keyInfo]) {
        
        NSString*observerStr = info[obseverKey];
        
        if ([observerStr isEqualToString:[observer description]]) {
            
            number++;
            if (number>1) return;
        }
    }
    
    //获取该对象的内部方法
    Method method1 = class_getInstanceMethod([observer class], NSSelectorFromString(@"dealloc"));
    Method method2 = class_getInstanceMethod([NSObject class], NSSelectorFromString(@"XMDealloc"));
    
    method_setImplementation(method1, _nsobjectXMDeallocImp);
    method_setImplementation(method2, objectDeallocImp);
  
    NSLog(@"%@注册了通知,并交换了dealloc的实现 == %@",observer,NSStringFromClass([observer class]));
}

@end

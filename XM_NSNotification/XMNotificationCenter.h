//
//  XMNotificationCenter.h
//  XMNotification(安全通知)====2016.05.31
//
//  Created by tianyu on 16/5/31.
//  Copyright © 2016年 Guoxiaoming. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMImplenmentation.h"

typedef void(^completedBlock)(id observer);
@interface XMNotificationCenter : NSObject
@property (nonatomic, copy)completedBlock complection;//要删除数组中对应的信息

/**保存IMP(指向函数实现的指针)的模型*/
@property (nonatomic, strong) NSMutableArray*implentationArray;

@property (nonatomic, strong)NSMutableDictionary*dic;

+ (instancetype)share;
//- (void)builtWithNotificationCenter:(NSNotificationCenter*)notificationCenter :(id)observer selector:(SEL)aSelector name:(NSString *)aName object:(id)anObject;

/***/
//- (void)builtWithNotificationCenter:(id)observer selector:(SEL)aSelector name:(NSString *)aName object:(id)anObject;

/** 接受到通知后是否立即移除监听器 */
- (void)builtWithNotificationCenter:(id)observer selector:(SEL)aSelector name:(NSString *)aName object:(id)anObject isRightNowRemove:(BOOL)isRightNowRemove;

/** 截取类名字符串 */
- (NSString*)observerClassSubstringWith:(NSString*)description;
@end

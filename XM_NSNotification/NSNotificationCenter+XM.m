//
//  NSNotificationCenter+XM.m
//  XMNotification(安全通知=)====2016.05.31
//
//  Created by tianyu on 16/5/31.
//  Copyright © 2016年 Guoxiaoming. All rights reserved.
//

#import "NSNotificationCenter+XM.h"
#import "XMNotificationCenter.h"
#import <objc/runtime.h>

@implementation NSNotificationCenter (XM)

/** 默认情况下是等待对象销毁前移除 */
- (void)xm_addObserver:(id)observer selector:(SEL)aSelector name:(NSString *)aName object:(id)anObject
{

    [self xm_addObserver:observer selector:aSelector name:aName object:anObject isRightNowRemove:NO];
}

/** 接受到通知后是否立即移除监听器 */
- (void)xm_addObserver:(id)observer selector:(SEL)aSelector name:(NSString *)aName object:(id)anObject isRightNowRemove:(BOOL)isRightNowRemove
{

    [[XMNotificationCenter share]builtWithNotificationCenter:observer selector:aSelector name:aName object:anObject isRightNowRemove:isRightNowRemove];
}

//- (id<NSObject>)addObserverForName:(NSString *)name object:(id)obj queue:(NSOperationQueue *)queue usingBlock:(void (^)(NSNotification * _Nonnull))block
//{
//
//    return nil;
//}

@end

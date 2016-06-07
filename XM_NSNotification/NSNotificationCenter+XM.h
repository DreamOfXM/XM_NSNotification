//
//  NSNotificationCenter+XM.h
//  XMNotification(安全通知=)====2016.05.31
//
//  Created by tianyu on 16/5/31.
//  Copyright © 2016年 Guoxiaoming. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSNotificationCenter (XM)

- (void)xm_addObserver:(id)observer selector:(SEL)aSelector name:(NSString *)aName object:(id)anObject;

/** 接受到通知后是否立即移除监听器 */
- (void)xm_addObserver:(id)observer selector:(SEL)aSelector name:(NSString *)aName object:(id)anObject isRightNowRemove:(BOOL)isRightNowRemove;
@end

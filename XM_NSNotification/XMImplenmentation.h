//
//  XMImplenmentation.h
//  XM_NSNotification
//
//  Created by tianyu on 16/6/4.
//  Copyright © 2016年 Guoxiaoming. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMImplenmentation : NSObject

/** 监听对象dealloc实现的指针 */
@property (nonatomic, assign)IMP objectDeallocImp;

/**存储原通知的实现*/
@property (nonatomic, assign)IMP receiveNotifacationImp;

/**是否已经将注册中心的监听对象移除了*/
//@property (nonatomic,assign,getter=isRemoved)BOOL removed;

/** 记录对象(字符串) */
@property (nonatomic, copy)NSString* objectStr;

/** 通知的名字*/
@property (nonatomic, copy)NSString* notificationName;

@end

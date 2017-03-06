//
//  XMView.m
//  XM_NSNotification
//
//  Created by tianyu on 16/6/4.
//  Copyright © 2016年 Guoxiaoming. All rights reserved.
//

#import "XMView.h"
#import "NSNotificationCenter+XM.h"

@implementation XMView

- (instancetype)init
{
    if (self= [super init]) {
        
        [[NSNotificationCenter defaultCenter] xm_addObserver:self selector:@selector(receiveNotification:) name:@"redView" object:nil isRightNowRemove:YES];
    }
    return self;
    
}

- (void)receiveNotification:(id)sender
{

    NSLog(@"redview=====");

}


- (void)dealloc
{

    NSLog(@"redView crashed");

}
@end

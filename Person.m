

//
//  Person.m
//  XM_NSNotification
//
//  Created by tianyu on 16/6/2.
//  Copyright © 2016年 Guoxiaoming. All rights reserved.
//

#import "Person.h"
#import "NSNotificationCenter+XM.h"

@implementation Person

- (instancetype)init
{
    if (self= [super init]) {
        
        [[NSNotificationCenter defaultCenter]xm_addObserver:self selector:@selector(receiveNotificationOfPerson:) name:@"news" object:nil isRightNowRemove:YES];
    }
    return self;

}


- (void)receiveNotificationOfPerson:(id)sender
{

    
    NSLog(@"Person receive notification===name == %@",[(NSNotification*)sender name]);

}

- (void)dealloc
{

    NSLog(@"p crashed");

}

@end



@implementation Car

- (instancetype)init
{
    if (self= [super init]) {
        
        [[NSNotificationCenter defaultCenter]xm_addObserver:self selector:@selector(receiveNotification:) name:@"car" object:nil isRightNowRemove:YES];
    }
    return self;
    
}


- (void)receiveNotification:(id)sender
{
    
    
    NSLog(@"car receive notification ===name == %@",[(NSNotification*)sender name]);
    
}

- (void)dealloc
{
    
    NSLog(@"car crashed");
    
}



@end


@implementation Dog


- (instancetype)init
{
    if (self= [super init]) {
        
        [[NSNotificationCenter defaultCenter]xm_addObserver:self selector:@selector(receiveNotification:) name:@"Dog" object:nil isRightNowRemove:YES];
    }
    return self;
    
}


- (void)receiveNotification:(id)sender
{
    
    
    NSLog(@"Dog receive notification ===name == %@",[(NSNotification*)sender name]);
    
}

- (void)dealloc
{
    
    NSLog(@"Dog crashed");
    
}

@end


@implementation Pig

- (instancetype)init
{
    if (self= [super init]) {
        
        [[NSNotificationCenter defaultCenter]xm_addObserver:self selector:@selector(receiveNotification:) name:@"Pig" object:nil isRightNowRemove:YES];
    }
    return self;
    
}


- (void)receiveNotification:(id)sender
{
    
    
    NSLog(@"Pig receive notification ===name == %@",[(NSNotification*)sender name]);
    
}

- (void)dealloc
{
    
    NSLog(@"Pig crashed");
    
}


@end
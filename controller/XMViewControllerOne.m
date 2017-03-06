//
//  XMViewControllerOne.m
//  XM_NSNotification
//
//  Created by tianyu on 16/6/1.
//  Copyright © 2016年 Guoxiaoming. All rights reserved.
//

#import "XMViewControllerOne.h"

#import "NSNotificationCenter+XM.h"
#import "Person.h"
#import "XMView.h"

@interface XMViewControllerOne ()
{
    Person*_p1;
    Person*_p2;
    Car*_car;
    Dog*_dog;
    Pig*_pig;
}

@end

@implementation XMViewControllerOne
/** 待优化——> 应该以按钮的形式展示在界面上，方便大家测试相应的功能 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    UIButton* btn0 = [self creatAButtonWithNumber:0];
    [btn0 setTitle:@"注册控制器为监听器(make controller a observer)" forState:UIControlStateNormal];
     btn0.backgroundColor = [UIColor redColor];
    
    UIButton* btn1 = [self creatAButtonWithNumber:1];
    [btn1 setTitle:@"发送通知(post notification)" forState:UIControlStateNormal];
    btn1.backgroundColor = [UIColor redColor];
    
    
    UIButton* btn2 = [self creatAButtonWithNumber:2];
    [btn2 setTitle:@"注册其他对象为监听器(make otherObject a observer)" forState:UIControlStateNormal];
    btn2.backgroundColor = [UIColor yellowColor];
    
    UIButton* btn3 = [self creatAButtonWithNumber:3];
    [btn3 setTitle:@"发送通知(post notification)" forState:UIControlStateNormal];
    btn3.backgroundColor = [UIColor yellowColor];
    
    UILabel* label1 = [[UILabel alloc]initWithFrame:CGRectMake(0, btn0.frame.origin.y - 20, self.view.frame.size.width, 10)];
    label1.text = @"NO1";
    label1.textColor = [UIColor blueColor];
    label1.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label1];
    
    UILabel* label2 = [[UILabel alloc]initWithFrame:CGRectMake(0, btn2.frame.origin.y - 20, self.view.frame.size.width, 10)];
    label2.text = @"NO2";
    label2.textColor = [UIColor blueColor];
    label2.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label2];

    
}

- (UIButton*)creatAButtonWithNumber:(int)number
{
    UIButton*button = [[UIButton alloc]init];
    
    if (number > 1) {
        button.center = CGPointMake(self.view.frame.size.width/2, 120+60*number+60);
    }else{
        button.center = CGPointMake(self.view.frame.size.width/2, 120+60*number);
    }
    CGRect bounds = button.bounds;
    bounds.size = CGSizeMake(200, 40);
    button.bounds = bounds;
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [button.titleLabel setNumberOfLines:2];
    [button addTarget:self action:@selector(addAObserver:) forControlEvents:UIControlEventTouchDown];
    button.tag = number+1000;
    [self.view addSubview:button];

    return button;
}



- (void)addAObserver:(UIButton*)sender
{
    long num = sender.tag - 1000;
    
    switch (num) {
            case 0://注册控制器为监听器(make controller a observer)
            [self makeAControllerAObserver];
            break;
            
            case 1://post notification
            [self postNotificationNO1];
            break;
            
            case 2://注册其他对象为监听器(make otherObject a observer)
            [self makeOtherObjectAObserver];
            break;
            
            case 3://post notification
            [self postNotificationNO2];
            
        default:
            break;
    }
    

}

/*************************** NO1 **************************/
//1 observer is controller
- (void)makeAControllerAObserver
{
    //1.1remove observer before observer crash (defaullt)
    
    [[NSNotificationCenter defaultCenter] xm_addObserver:self selector:@selector(sina:) name:@"sina" object:nil];
    [[NSNotificationCenter defaultCenter] xm_addObserver:self selector:@selector(google:) name:@"google" object:nil];
    
    
    //1.2 remove observer after receiving notification right now
    
    [[NSNotificationCenter defaultCenter] xm_addObserver:self selector:@selector(haha:) name:@"haha" object:nil isRightNowRemove:YES];
    [[NSNotificationCenter defaultCenter] xm_addObserver:self selector:@selector(google:) name:@"google" object:nil isRightNowRemove:YES];

}


// receiver is controller
- (void)postNotificationNO1
{
    NSLog(@"controller post notifications");
    [[NSNotificationCenter defaultCenter]postNotificationName:@"haha" object:nil];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"sina" object:nil];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"google" object:nil];

}

/*************************** NO2 **************************/
- (void)makeOtherObjectAObserver
{
    
    //2 observer is other objects
    //2 监听器是其他对象
    _p1 =[Person new];
    _p2 =[Person new];
    _car = [Car new];
    _dog = [Dog new];
    _pig = [Pig new];
    self.view.backgroundColor = [UIColor whiteColor];
    
    XMView*view = [[XMView alloc]init];
    [self.view addSubview:view];


}

// receiver are other objects
- (void)postNotificationNO2
{
   [[NSNotificationCenter defaultCenter]postNotificationName:@"news" object:nil];
    
}

- (void)sina:(id)sender
{

    NSLog(@"sina====");

}

- (void)google:(id)sender
{
    
    NSLog(@"google====");
    
}
- (void)haha:(id)sender
{
    
    NSLog(@"haha====");
    
}
- (void)dealloc
{
    NSLog(@"controller crashed");

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
   

}

@end

//
//  ViewController.m
//  XM_NSNotification
//
//  Created by tianyu on 16/6/1.
//  Copyright © 2016年 Guoxiaoming. All rights reserved.
//

#import "ViewController.h"
#import "XMViewControllerOne.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    UILabel*clickview = [[UILabel alloc]init];
    clickview.center = CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height/2);
    CGRect bound = CGRectMake(0, 0, 60, 30);
    clickview.bounds = bound;
    clickview.backgroundColor = [UIColor redColor];
    clickview.text = @"Enter";
    clickview.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:clickview];
    
    
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    XMViewControllerOne*ct = [[XMViewControllerOne alloc]init];
    [self.navigationController pushViewController:ct animated:YES];


}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end

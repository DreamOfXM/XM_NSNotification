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

//
//  PNChartCtrl.m
//  Tool For OC
//
//  Created by 曹老师 on 2018/6/11.
//  Copyright © 2018年 曹老师. All rights reserved.
//

#import "PNChartCtrl.h"
#import "PCChartsTableViewController.h"

@interface PNChartCtrl ()

@end

@implementation PNChartCtrl



- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 60, 60);
    button.center = CGPointMake(kScreenWidth * 0.5, kScreenHeight * 0.5);
    [button setImage:[UIImage imageNamed:@"开始"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    
}


#pragma mark - 开始
- (void)buttonAction:(UIButton *)button {
    
    PCChartsTableViewController *ctrl = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"PCChartsTableViewController"];
    
    [self.navigationController pushViewController:ctrl animated:YES];
    
}



































@end

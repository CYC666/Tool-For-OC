//
//  ViewController.m
//  Tool For OC
//
//  Created by 曹老师 on 2018/4/17.
//  Copyright © 2018年 曹老师. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundColor:[UIColor orangeColor]];
    
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.view).offset(10);
        make.left.equalTo(self.view).offset(10);
        make.right.equalTo(self.view).offset(10);
        make.bottom.equalTo(self.view).offset(10);
        
    }];
    
    [button setClickBlock:^{
        
        FadeAlertView *showMessage = [[FadeAlertView alloc] init];
        [showMessage showAlertWith:@"真棒"];
        
    }];
    
    
    
    
    
    [self.view addSubview:button];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

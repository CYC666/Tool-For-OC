//
//  SVProgressHUDCtrl.m
//  Tool For OC
//
//  Created by 曹老师 on 2018/6/11.
//  Copyright © 2018年 曹老师. All rights reserved.
//

#import "SVProgressHUDCtrl.h"
#import <SVProgressHUD.h>


@interface SVProgressHUDCtrl ()

@end

@implementation SVProgressHUDCtrl


#pragma mark ========================================生命周期========================================
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UIButton *buttonA = [UIButton buttonWithType:UIButtonTypeCustom];
    [buttonA setTitle:@"常规风火轮" forState:UIControlStateNormal];
    [buttonA setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    buttonA.backgroundColor = Publie_Color_A;
    [buttonA addTarget:self action:@selector(buttonAButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonA];
    
    [buttonA mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.view.mas_top).mas_offset(Nav_Height + 20);
        make.left.mas_equalTo(self.view.mas_left).mas_offset(20);
        make.right.mas_equalTo(self.view.mas_right).mas_offset(-20);
        make.height.mas_equalTo(45);
        
    }];
    
    UIButton *buttonB = [UIButton buttonWithType:UIButtonTypeCustom];
    [buttonB setTitle:@"显示字样" forState:UIControlStateNormal];
    [buttonB setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    buttonB.backgroundColor = Publie_Color_A;
    [buttonB addTarget:self action:@selector(buttonBButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonB];
    
    [buttonB mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(buttonA.mas_bottom).mas_offset(20);
        make.left.mas_equalTo(self.view.mas_left).mas_offset(20);
        make.right.mas_equalTo(self.view.mas_right).mas_offset(-20);
        make.height.mas_equalTo(45);
        
    }];
    
    
    
    UIButton *buttonC = [UIButton buttonWithType:UIButtonTypeCustom];
    [buttonC setTitle:@"显示进度" forState:UIControlStateNormal];
    [buttonC setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    buttonC.backgroundColor = Publie_Color_A;
    [buttonC addTarget:self action:@selector(buttonCButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonC];
    
    [buttonC mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(buttonB.mas_bottom).mas_offset(20);
        make.left.mas_equalTo(self.view.mas_left).mas_offset(20);
        make.right.mas_equalTo(self.view.mas_right).mas_offset(-20);
        make.height.mas_equalTo(45);
        
    }];
    
    UIButton *buttonD = [UIButton buttonWithType:UIButtonTypeCustom];
    [buttonD setTitle:@"显示成功" forState:UIControlStateNormal];
    [buttonD setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    buttonD.backgroundColor = Publie_Color_A;
    [buttonD addTarget:self action:@selector(buttonDButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonD];
    
    [buttonD mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(buttonC.mas_bottom).mas_offset(20);
        make.left.mas_equalTo(self.view.mas_left).mas_offset(20);
        make.right.mas_equalTo(self.view.mas_right).mas_offset(-20);
        make.height.mas_equalTo(45);
        
    }];
    
    UIButton *buttonE = [UIButton buttonWithType:UIButtonTypeCustom];
    [buttonE setTitle:@"显示失败" forState:UIControlStateNormal];
    [buttonE setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    buttonE.backgroundColor = Publie_Color_A;
    [buttonE addTarget:self action:@selector(buttonEButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonE];
    
    [buttonE mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(buttonD.mas_bottom).mas_offset(20);
        make.left.mas_equalTo(self.view.mas_left).mas_offset(20);
        make.right.mas_equalTo(self.view.mas_right).mas_offset(-20);
        make.height.mas_equalTo(45);
        
    }];

}

#pragma mark ========================================动作响应=============================================

#pragma mark - 常规风火轮
- (void)buttonAButtonAction:(UIButton *)button {
    
    [SVProgressHUD show];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
    
}

#pragma mark - 显示字样
- (void)buttonBButtonAction:(UIButton *)button {
    
    [SVProgressHUD showWithStatus:@"在这显示字样"];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
    
}

#pragma mark - 显示进度
- (void)buttonCButtonAction:(UIButton *)button {
    
    [SVProgressHUD showProgress:0.8 status:@"加载中"];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
    
}

#pragma mark - 显示成功
- (void)buttonDButtonAction:(UIButton *)button {
    
    [SVProgressHUD showSuccessWithStatus:@"加载成功"];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
    
}

#pragma mark - 显示错误
- (void)buttonEButtonAction:(UIButton *)button {
    
    [SVProgressHUD showErrorWithStatus:@"加载失败"];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
    
}

#pragma mark ========================================网络请求=============================================


#pragma mark ========================================代理方法=============================================






































@end

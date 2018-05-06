//
//  YYTextCtrl.m
//  Tool For OC
//
//  Created by 曹老师 on 2018/5/6.
//  Copyright © 2018年 曹老师. All rights reserved.
//

#import "YYTextCtrl.h"
#import "YYTextExample.h"

@interface YYTextCtrl ()

@end

@implementation YYTextCtrl

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
    
    YYTextExample *vc = [YYTextExample new];
    [self.navigationController pushViewController:vc animated:YES];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

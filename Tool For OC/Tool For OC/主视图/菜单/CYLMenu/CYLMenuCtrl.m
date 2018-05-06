//
//  CYLMenuCtrl.m
//  Tool For OC
//
//  Created by 曹老师 on 2018/5/6.
//  Copyright © 2018年 曹老师. All rights reserved.
//

#import "CYLMenuCtrl.h"
#import <Masonry.h>
#import "CYLMainViewController.h"
#import "CYLFilterParamsTool.h"

@interface CYLMenuCtrl ()

@end

@implementation CYLMenuCtrl

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
        
    CYLMainViewController *ctrl = [[CYLMainViewController alloc] init];
    [self initFilterSetting:YES];
    [self.navigationController pushViewController:ctrl animated:YES];
    
}

- (void)initFilterSetting:(BOOL)restore {
    if (!restore) {
        CYLFilterParamsTool *filterParamsTool = [[CYLFilterParamsTool alloc] init];
        [NSKeyedArchiver archiveRootObject:filterParamsTool toFile:filterParamsTool.filename];
    }
}




@end

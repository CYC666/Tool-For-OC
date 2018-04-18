//
//  BaseController.m
//  Tool For OC
//
//  Created by 曹老师 on 2018/4/17.
//  Copyright © 2018年 曹老师. All rights reserved.
//

#import "BaseController.h"
#import "MMDrawerController.h"

@interface BaseController ()

@end

@implementation BaseController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.funcDic[@"name"];
    
    self.view.backgroundColor = Background_Color;
    
    // 导航栏右边的添加按钮
    UIButton *rightItem = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightItem setImage:[UIImage imageNamed:@"详情"]  forState:UIControlStateNormal];
    [rightItem setTintColor:[UIColor whiteColor]];
    rightItem.frame = CGRectMake(0, 0, 40, 40);
    [rightItem addTarget:self action:@selector(detialsAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithCustomView:rightItem];
    self.navigationItem.rightBarButtonItem = rightBarItem;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    MMDrawerController *drawCtrl= (MMDrawerController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    [drawCtrl setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
}

#pragma mark - 查看详情
- (void)detialsAction {
    
    NSString *path = self.funcDic[@"url"];
    
    if (path) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:path]];
    }
    
}

@end

//
//  MainController.m
//  Tool For OC
//
//  Created by 曹老师 on 2018/4/17.
//  Copyright © 2018年 曹老师. All rights reserved.
//

#import "MainController.h"
#import "MMDrawerController.h"

@interface MainController ()

@end

@implementation MainController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"功能列表";
    self.view.backgroundColor = Background_Color;
    
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    MMDrawerController *drawCtrl= (MMDrawerController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    [drawCtrl setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    MMDrawerController *drawCtrl= (MMDrawerController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    [drawCtrl setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
}



































@end

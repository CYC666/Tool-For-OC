//
//  LeftController.m
//  Tool For OC
//
//  Created by 曹老师 on 2018/4/17.
//  Copyright © 2018年 曹老师. All rights reserved.
//

#import "LeftController.h"
#import "LeftCell.h"
#import "MMDrawerController.h"

@interface LeftController () <UITableViewDelegate, UITableViewDataSource> {
    
    UITableView *_listTableView;
    
    NSArray *funcArray;
    NSArray *funcControllerArray;
    
}

@end

@implementation LeftController

#pragma mark ========================================生命周期========================================
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"应用";
    self.view.backgroundColor = White_Color;
    funcArray = @[@"字幕",
                  @"取色",
                  @"二维码",
                  @"照片",
                  @"笔记",
                  @"地铁厕所"];
    funcControllerArray = @[@"FontViewController",
                            @"SelectColorController",
                            @"二维码",
                            @"照片",
                            @"笔记",
                            @"地铁厕所"];
    
    
    // 创建视图
    [self creatSubViewsAction];
    
    
    
}


#pragma mark ========================================私有方法=============================================

#pragma mark - 创建视图
- (void)creatSubViewsAction {
    
    // 表视图
    _listTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, Nav_Height, LeftWidth, kScreenHeight - Nav_Height)
                                                  style:UITableViewStylePlain];
    _listTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _listTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    _listTableView.backgroundColor = [UIColor clearColor];
    _listTableView.pagingEnabled = YES;
    _listTableView.delegate = self;
    _listTableView.dataSource = self;
    [_listTableView registerNib:[UINib nibWithNibName:@"LeftCell" bundle:[NSBundle mainBundle]]
         forCellReuseIdentifier:@"LeftCell"];
    [self.view addSubview:_listTableView];
    
#ifdef __IPHONE_11_0
    if(@available(iOS 11.0, *)){
        _listTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
#else
    
#endif
    self.automaticallyAdjustsScrollViewInsets = NO;
    
}

#pragma mark ========================================动作响应=============================================


#pragma mark ========================================网络请求=============================================

#pragma mark ========================================代理方法=============================================

#pragma mark - 表视图代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return funcArray.count;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return kScreenHeight - Nav_Height;
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.01;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 0.01;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LeftCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LeftCell"
                                                            forIndexPath:indexPath];
    
    if (indexPath.row % 2) {
        cell.colorView.backgroundColor = White_Color;
        cell.nameLabel.textColor = Label_Color_A;
    } else {
        cell.colorView.backgroundColor = Label_Color_A;
        cell.nameLabel.textColor = White_Color;
    }
    
    cell.nameLabel.text = funcArray[indexPath.row];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UIViewController *ctrl = [[NSClassFromString(funcControllerArray[indexPath.row]) alloc] init];
    MMDrawerController *drawCtrl= (MMDrawerController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    
    [drawCtrl closeDrawerAnimated:YES completion:^(BOOL finished) {
        UINavigationController *center = (UINavigationController *)drawCtrl.centerViewController;
        [center pushViewController:ctrl animated:YES];
    }];
    
    
    
}


#pragma mark ========================================通知================================================






































@end

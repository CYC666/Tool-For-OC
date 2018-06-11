//
//  SWTableViewCellCtrl.m
//  Tool For OC
//
//  Created by 曹老师 on 2018/6/11.
//  Copyright © 2018年 曹老师. All rights reserved.
//

#import "SWTableViewCellCtrl.h"
#import "XIXIcell.h"
#import <SVProgressHUD.h>


@interface SWTableViewCellCtrl () <UITableViewDelegate, UITableViewDataSource, SWTableViewCellDelegate> {
    
    UITableView *_listTableView;
    
    
    
}

@end

@implementation SWTableViewCellCtrl

#pragma mark ========================================生命周期========================================
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor = Background_Color;
    // 创建视图
    [self creatSubViewsAction];
    
    
    
}


#pragma mark ========================================私有方法=============================================

#pragma mark - 创建视图
- (void)creatSubViewsAction {
    
    // 表视图
    _listTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - TabBar_Height)
                                                  style:UITableViewStylePlain];
    _listTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _listTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    _listTableView.backgroundColor = [UIColor clearColor];
    _listTableView.delegate = self;
    _listTableView.dataSource = self;
    [_listTableView registerNib:[UINib nibWithNibName:@"XIXIcell" bundle:[NSBundle mainBundle]]
         forCellReuseIdentifier:@"XIXIcell"];
    [self.view addSubview:_listTableView];
    
    if(@available(iOS 11.0, *)){
        _listTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
}

- (NSArray *)rightButtons {
    NSMutableArray *rightUtilityButtons = [NSMutableArray new];
    [rightUtilityButtons sw_addUtilityButtonWithColor:
     [UIColor colorWithRed:0.78f green:0.78f blue:0.8f alpha:1.0]
                                                title:@"More"];
    [rightUtilityButtons sw_addUtilityButtonWithColor:
     [UIColor colorWithRed:1.0f green:0.231f blue:0.188 alpha:1.0f]
                                                title:@"Delete"];
    
    return rightUtilityButtons;
}

- (NSArray *)leftButtons {
    NSMutableArray *leftUtilityButtons = [NSMutableArray new];
    
    [leftUtilityButtons sw_addUtilityButtonWithColor:
     [UIColor colorWithRed:0.07 green:0.75f blue:0.16f alpha:1.0]
                                                icon:[UIImage imageNamed:@"check.png"]];
    [leftUtilityButtons sw_addUtilityButtonWithColor:
     [UIColor colorWithRed:1.0f green:1.0f blue:0.35f alpha:1.0]
                                                icon:[UIImage imageNamed:@"clock.png"]];
    [leftUtilityButtons sw_addUtilityButtonWithColor:
     [UIColor colorWithRed:1.0f green:0.231f blue:0.188f alpha:1.0]
                                                icon:[UIImage imageNamed:@"cross.png"]];
    [leftUtilityButtons sw_addUtilityButtonWithColor:
     [UIColor colorWithRed:0.55f green:0.27f blue:0.07f alpha:1.0]
                                                icon:[UIImage imageNamed:@"list.png"]];
    
    return leftUtilityButtons;
}

#pragma mark ========================================动作响应=============================================


#pragma mark ========================================网络请求=============================================

#pragma mark ========================================代理方法=============================================

#pragma mark - 表视图代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 10;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 80;
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.01;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 0.01;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    XIXIcell *cell = [tableView dequeueReusableCellWithIdentifier:@"XIXIcell"
                                                            forIndexPath:indexPath];
    
    cell.leftUtilityButtons = [self leftButtons];
    cell.rightUtilityButtons = [self rightButtons];
    cell.delegate = self;
    
    cell.left.constant = (indexPath.row + 1) * 10;
    cell.right.constant = (indexPath.row + 1) * 10;
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    
}

#pragma mark - SWTableViewDelegate

- (void)swipeableTableViewCell:(SWTableViewCell *)cell scrollingToState:(SWCellState)state
{
    switch (state) {
        case 0:
            NSLog(@"utility buttons closed");
            break;
        case 1:
            NSLog(@"left utility buttons open");
            break;
        case 2:
            NSLog(@"right utility buttons open");
            break;
        default:
            break;
    }
}

- (void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerLeftUtilityButtonWithIndex:(NSInteger)index
{
    switch (index) {
        case 0:
            NSLog(@"left button 0 was pressed");
            break;
        case 1:
            NSLog(@"left button 1 was pressed");
            break;
        case 2:
            NSLog(@"left button 2 was pressed");
            break;
        case 3:
            NSLog(@"left btton 3 was pressed");
        default:
            break;
    }
}

- (void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)index
{
    switch (index) {
        case 0:
        {
            
            [SVProgressHUD showWithStatus:@"More more more"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
            });
            [cell hideUtilityButtonsAnimated:YES];
            
            break;
        }
        case 1:
        {
            
            break;
        }
        default:
            break;
    }
}

- (BOOL)swipeableTableViewCellShouldHideUtilityButtonsOnSwipe:(SWTableViewCell *)cell
{
    // allow just one cell's utility button to be open at once
    return YES;
}

- (BOOL)swipeableTableViewCell:(SWTableViewCell *)cell canSwipeToState:(SWCellState)state
{
    switch (state) {
        case 1:
            // set to NO to disable all left utility buttons appearing
            return YES;
            break;
        case 2:
            // set to NO to disable all right utility buttons appearing
            return YES;
            break;
        default:
            break;
    }
    
    return YES;
}


#pragma mark ========================================通知================================================





@end

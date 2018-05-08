//
//  AddNoteViewController.m
//  LittleAppOC
//
//  Created by 曹老师 on 2018/2/17.
//  Copyright © 2018年 CYC. All rights reserved.
//

#import "AddNoteViewController.h"

@interface AddNoteViewController () <UITextViewDelegate>

@end

@implementation AddNoteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.navigationItem.title = @"添加";
    
    _top.constant = Nav_Height + 10;
    
    // 导航栏右边的添加按钮
    UIButton *rightItem = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightItem setTitle:@"确定" forState:UIControlStateNormal];
    [rightItem setTintColor:[UIColor whiteColor]];
    rightItem.frame = CGRectMake(0, 0, 40, 22);
    [rightItem addTarget:self action:@selector(sureButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithCustomView:rightItem];
    self.navigationItem.rightBarButtonItem = rightBarItem;
    
    
    
}

#pragma mark - 下一步
- (IBAction)nextAction:(UITextField *)sender {
    
    [_contentView becomeFirstResponder];
    
}


#pragma mark - 确定
- (void)sureButtonAction:(UIButton *)button {
    
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    
    if ([_titleField.text isEqualToString:@""]) {
        FadeAlertView *showMessage = [[FadeAlertView alloc] init];
        [showMessage showAlertWith:@"标题不能为空"];
        return;
    }
    
    if ([_contentView.text isEqualToString:@""]) {
        FadeAlertView *showMessage = [[FadeAlertView alloc] init];
        [showMessage showAlertWith:@"内容不能为空"];
        return;
    }
    
    
    // 储存，返回
    NSMutableArray *list = [self loadListAction];
    [list addObject:@{@"title" : _titleField.text,
                      @"content" : _contentView.text
                      }];
    
    // 1、获取应用程序沙盒下的Documents目录（购物车列表）
    NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES).firstObject stringByAppendingPathComponent:@"NoteList.plist"];
    
    // 文件写入
    if ([list writeToFile:filePath atomically:YES]) {
        
        FadeAlertView *showMessage = [[FadeAlertView alloc] init];
        [showMessage showAlertWith:@"添加成功"];
        [self.navigationController popViewControllerAnimated:YES];
        
    } else {
        
        FadeAlertView *showMessage = [[FadeAlertView alloc] init];
        [showMessage showAlertWith:@"添加失败"];
        
    }
    
}

#pragma mark - 获取数据
- (NSMutableArray *)loadListAction {
    
    // 1、获取应用程序沙盒下的Documents目录（购物车列表）
    NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES).firstObject stringByAppendingPathComponent:@"NoteList.plist"];
    NSMutableArray *list = [[NSMutableArray alloc] initWithContentsOfFile:filePath];
    if (!list) {
        list = [NSMutableArray array];
    }
    
    return list;
}











@end

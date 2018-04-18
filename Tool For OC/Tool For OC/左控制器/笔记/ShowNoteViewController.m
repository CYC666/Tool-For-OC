//
//  ShowNoteViewController.m
//  LittleAppOC
//
//  Created by 曹老师 on 2018/2/17.
//  Copyright © 2018年 CYC. All rights reserved.
//

#import "ShowNoteViewController.h"
#import "NoteModel.h"
#import "MMDrawerController.h"

@interface ShowNoteViewController ()

@end

@implementation ShowNoteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"详情";
    
    _topConstraint.constant = Nav_Height + 20;
    _contentWidthConstraint.constant = kScreenWidth - 30;
    
    _titleLabel.text = _model.noteTitle;
    _contentLabel.text = _model.noteContent;
    
}

//（1）、视图将要出现的时候,禁用MMDrawCtrls
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    //获取根视图控制器
    MMDrawerController *drawCtrl= (MMDrawerController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    //设置一下打开的区域
    [drawCtrl setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
}
//（2）、视图将要消失的时候,还原一下
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    MMDrawerController *drawCtrl= (MMDrawerController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    //设置一下打开的区域
    [drawCtrl setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
}








@end

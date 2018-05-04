//
//  LanguageManagerCtrl.m
//  Tool For OC
//
//  Created by 曹老师 on 2018/4/27.
//  Copyright © 2018年 曹老师. All rights reserved.
//

#import "LanguageManagerCtrl.h"

@interface LanguageManagerCtrl () <UIPickerViewDelegate, UIPickerViewDataSource>

@end

@implementation LanguageManagerCtrl



#pragma mark ========================================生命周期========================================
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    _picker.delegate = self;
    _picker.dataSource = self;
    _top.constant = Nav_Height + 20;
    
    
    
    
    
    //注册通知，用于接收改变语言的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeLanguage) name:ChangeLanguageNotificationName object:nil];
    
    [self changeLanguage];
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    // 恢复中文
    [kLanguageManager setUserlanguage:@"zh-Hans-CN"];
    
    
}

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:ChangeLanguageNotificationName object:nil];
    
}


#pragma mark ========================================动作响应=============================================


#pragma mark ========================================网络请求=============================================


#pragma mark ========================================代理方法=============================================

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return 3;
}

- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    if (row == 0) {
        return @"中文";
    } else if (row == 1) {
        return @"英文";
    } else {
        return @"粤语";
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    //更新语言
    if (row == 0) {
        [kLanguageManager setUserlanguage:@"zh-Hans-CN"];
    } else if (row == 1) {
        [kLanguageManager setUserlanguage:@"en-CN"];
    } else {
        [kLanguageManager setUserlanguage:@"zh-Hant-CN"];
    }
    
}



#pragma mark ========================================通知=============================================
- (void)changeLanguage {
    
    _labelA.text = kLocalizedString(@"Delevan", @"德莱文");
    _labelB.text = kLocalizedString(@"Oh my God", @"我的天");
    _labelC.text = kLocalizedString(@"Delevan", @"德莱文");
    _labelD.text = kLocalizedString(@"Oh my God", @"我的天");
    
}




























@end

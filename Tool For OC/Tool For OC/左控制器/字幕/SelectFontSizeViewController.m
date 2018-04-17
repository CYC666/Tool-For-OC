//
//  SelectFontSizeViewController.m
//  LittleAppOC
//
//  Created by 曹奕程 on 2017/8/16.
//  Copyright © 2017年 CYC. All rights reserved.
//

#import "SelectFontSizeViewController.h"

@interface SelectFontSizeViewController () <UIPickerViewDelegate, UIPickerViewDataSource> {

    NSArray *_fontList;
    
    CGFloat _fontSize;
    
    NSString *_fontName;

}

@end

@implementation SelectFontSizeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.navigationItem.title = @"选择字体";
    
    // 默认
    _fontName = @"迷你简胖娃";
    _fontSize = kScreenWidth;
    _tipLabel.font = [UIFont fontWithName:_fontName size:_fontSize];
    
    
    // 字体列表
    _fontList = @[@"迷你简胖娃",
                  @"DFPWAWAW7-B5",
                  @"Zapfino",
                  @"Arial",
                  @"AmericanTypewriter",
                  @"AppleGothic",
                  @"Courier",
                  @"CourierNewPSMT",
                  @"Georgia",
                  @"Helvetica",
                  @"HelveticaNeue",
                  @"HiraKakuProN-W3",
                  @"TimesNewRomanPSMT",
                  @"TrebuchetMS",
                  @"Verdana"];

    // 设置滑动条
    _sizeSlider.maximumValue = kScreenWidth;
    _sizeSlider.minimumValue = 10.0f;
    _sizeSlider.value = kScreenWidth;
    
    // 设置字体选择器
    _fontPickerView.delegate = self;
    _fontPickerView.dataSource = self;
    
    
    // 导航栏右边的添加按钮
    UIButton *rightItem = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightItem setTitle:@"确定" forState:UIControlStateNormal];
    [rightItem setTintColor:[UIColor whiteColor]];
    rightItem.frame = CGRectMake(0, 0, 60, 22);
    [rightItem addTarget:self action:@selector(sureAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithCustomView:rightItem];
    self.navigationItem.rightBarButtonItem = rightBarItem;
    
    
 
    
    
    
    
    
    
    
    
}






#pragma mark - 修改大小
- (IBAction)changeSizeAction:(UISlider *)sender {
    
    _fontSize = sender.value;
    
    _tipLabel.font = [UIFont fontWithName:_fontName size:_fontSize];
    
    
}


#pragma mark - 确认
- (void)sureAction:(UIButton *)button {
    
    UIFont *font = [UIFont fontWithName:_fontName size:_fontSize];
    
    if ([_delegate respondsToSelector:@selector(didSelectFont:)]) {
        [_delegate didSelectFont:font];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma mark - 提示字体按钮，点击切换中英文
- (IBAction)changeChineseOrEnglish:(UIButton *)sender {
    
    if ([_tipLabel.text isEqualToString:@"思"]) {
        _tipLabel.text = @"S";
    } else {
        _tipLabel.text = @"思";
    }
    
}



#pragma mark - 字体选择器代理方法
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {

    return 1;

}


- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {

    return _fontList.count;

}

- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {

    NSString *title = _fontList[row];
    return title;

}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {

    _fontName = _fontList[row];
    
    _tipLabel.font = [UIFont fontWithName:_fontName size:_fontSize];

}


























@end

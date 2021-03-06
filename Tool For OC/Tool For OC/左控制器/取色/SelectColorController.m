//
//  SelectColorController.m
//  LittleAppOC
//
//  Created by yongda sha on 17/3/24.
//  Copyright © 2017年 CYC. All rights reserved.
//

#import "SelectColorController.h"

@interface SelectColorController ()

@end

@implementation SelectColorController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"取色板";
    _top.constant = Nav_Height + 10;
    
    
    // 给滑动条添加值改变响应
    [_redSlider addTarget:self action:@selector(redSilderChange:) forControlEvents:UIControlEventValueChanged];
    [_greenSlider addTarget:self action:@selector(greenSilderChange:) forControlEvents:UIControlEventValueChanged];
    [_blueSlider addTarget:self action:@selector(blueSilderChange:) forControlEvents:UIControlEventValueChanged];
    [_alphaSlider addTarget:self action:@selector(alphaSilderChange:) forControlEvents:UIControlEventValueChanged];
    
    // 给输入框添加值发生改变的响应
    [_redField addTarget:self action:@selector(fieldValueDidChange:) forControlEvents:UIControlEventValueChanged];
    [_greenField addTarget:self action:@selector(fieldValueDidChange:) forControlEvents:UIControlEventValueChanged];
    [_blueField addTarget:self action:@selector(fieldValueDidChange:) forControlEvents:UIControlEventValueChanged];
    [_alphaField addTarget:self action:@selector(fieldValueDidChange:) forControlEvents:UIControlEventValueChanged];
    
    // 下滑显示颜色区域可隐藏键盘
    UISwipeGestureRecognizer *downSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyBoardTap:)];
    downSwipe.direction = UISwipeGestureRecognizerDirectionDown;
    [_colorView addGestureRecognizer:downSwipe];
    
    // 导航栏右边的添加按钮
    UIButton *rightItem = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightItem setTitle:@"确定" forState:UIControlStateNormal];
    [rightItem setTintColor:[UIColor whiteColor]];
    rightItem.frame = CGRectMake(0, 0, 60, 22);
    [rightItem addTarget:self action:@selector(sureAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithCustomView:rightItem];
    self.navigationItem.rightBarButtonItem = rightBarItem;
    
    // 长按保存单色图片
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(saveImageAction:)];
    longPress.minimumPressDuration = 1;
    [_colorView addGestureRecognizer:longPress];
    
}

- (void)viewDidAppear:(BOOL)animated {

    [super viewDidAppear:animated];
    
    // 开启点击显示、隐藏导航栏
    self.navigationController.hidesBarsOnTap = YES;

}

- (void)viewWillDisappear:(BOOL)animated {

    [super viewWillDisappear:animated];
    
    // 关闭点击显示、隐藏导航栏
    self.navigationController.hidesBarsOnTap = NO;

}

#pragma mark - 保存单色背景图
- (void)saveImageAction:(UILongPressGestureRecognizer *)press {
    
    if (press.state == UIGestureRecognizerStateBegan) {
        
        // 弹框提示是否执行
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil
                                                                       message:@"是否将此颜色存为图片？"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"取消"
                                                  style:UIAlertActionStyleDefault
                                                handler:^(UIAlertAction * _Nonnull action) {
                                                    
                                                }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定"
                                                  style:UIAlertActionStyleDefault
                                                handler:^(UIAlertAction * _Nonnull action) {
                                                    
                                                    // 生成单色图片
                                                    CGRect rect = CGRectMake(0, 0, kScreenWidth, kScreenHeight);  //图片尺寸
                                                    UIGraphicsBeginImageContext(rect.size); //填充画笔
                                                    CGContextRef context = UIGraphicsGetCurrentContext(); //根据所传颜色绘制
                                                    CGContextSetFillColorWithColor(context, CRGB(_redField.text.floatValue, _greenField.text.floatValue, _greenField.text.floatValue, _alphaField.text.floatValue).CGColor);
                                                    CGContextFillRect(context, rect); //联系显示区域
                                                    UIImage * image = UIGraphicsGetImageFromCurrentImageContext(); // 得到图片信息
                                                    UIGraphicsEndImageContext(); //消除画笔
                                                    
                                                    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
                                                    
                                                    FadeAlertView *showMessage = [[FadeAlertView alloc] init];
                                                    [showMessage showAlertWith:@"已经将图片保存到相册中"];
                                                    
                                                }]];
        
        [self presentViewController:alert animated:YES completion:nil];
        
    }
    
}


#pragma mark - 确定
- (void)sureAction:(UIButton *)button {
    
    UIColor *selectColor = self.colorView.backgroundColor;
    
    if ([_delegate respondsToSelector:@selector(didSelectColorAction:)]) {
        [_delegate didSelectColorAction:selectColor];
    }
    
    if (_colorBlock) {
        _colorBlock(selectColor);
    }
    
    [self.navigationController popViewControllerAnimated:YES];
    
}



#pragma mark - 滑动条值改变
// 红
- (void)redSilderChange:(UISlider *)slider {

    _redField.text = [NSString stringWithFormat:@"%.0f", slider.value];
    
    self.colorView.backgroundColor = CRGB([_redField.text floatValue], [_greenField.text floatValue], [_blueField.text floatValue], [_alphaField.text floatValue]);

}
// 绿
- (void)greenSilderChange:(UISlider *)slider {
    
    _greenField.text = [NSString stringWithFormat:@"%.0f", slider.value];
    
    self.colorView.backgroundColor = CRGB([_redField.text floatValue], [_greenField.text floatValue], [_blueField.text floatValue], [_alphaField.text floatValue]);
    
}
// 蓝
- (void)blueSilderChange:(UISlider *)slider {
    
    _blueField.text = [NSString stringWithFormat:@"%.0f", slider.value];
    
    self.colorView.backgroundColor = CRGB([_redField.text floatValue], [_greenField.text floatValue], [_blueField.text floatValue], [_alphaField.text floatValue]);
    
}
// alpha
- (void)alphaSilderChange:(UISlider *)slider {
    
    _alphaField.text = [NSString stringWithFormat:@"%.1f", slider.value];
    
    self.colorView.backgroundColor = CRGB([_redField.text floatValue], [_greenField.text floatValue], [_blueField.text floatValue], [_alphaField.text floatValue]);
    
}


#pragma mark - 输入框代理方法
- (void)fieldValueDidChange:(UITextField *)textField {
    

    if ([textField isEqual:_redField]) {
        _redSlider.value = [textField.text floatValue];
        
    } else if ([textField isEqual:_greenField]) {
        _greenSlider.value = [textField.text floatValue];
        
    } else if ([textField isEqual:_blueField]) {
        _blueSlider.value = [textField.text floatValue];
        
    } else if ([textField isEqual:_alphaField]) {
        _alphaSlider.value = [textField.text floatValue];
        
    }
    
    self.colorView.backgroundColor = CRGB([_redField.text floatValue], [_greenField.text floatValue], [_blueField.text floatValue], [_alphaField.text floatValue]);

}



#pragma mark - 手势响应
- (void)hideKeyBoardTap:(UISwipeGestureRecognizer *)swipe {
    
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];

}



























@end

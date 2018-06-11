//
//  CodeViewController.m
//  LittleAppOC
//
//  Created by 曹奕程 on 2017/8/21.
//  Copyright © 2017年 CYC. All rights reserved.
//

#import "CodeViewController.h"
#import <CoreImage/CoreImage.h>
#import "SweepCodeViewController.h"

@interface CodeViewController () <UITextFieldDelegate, SweepCodeViewControllerDlegate> {

}

@end

@implementation CodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"生成二维码";
    
    _top.constant = Nav_Height + 10;
    
    _inputField.delegate = self;

    _iconImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(saveAction:)];
    [_iconImageView addGestureRecognizer:tap];
    
//    // 导航栏右边的添加按钮
//    UIButton *rightItem = [UIButton buttonWithType:UIButtonTypeCustom];
//    [rightItem setImage:[UIImage imageNamed:@"扫一扫"]  forState:UIControlStateNormal];
//    [rightItem setTintColor:[UIColor whiteColor]];
//    rightItem.frame = CGRectMake(0, 0, 25, 25);
//    [rightItem addTarget:self action:@selector(codeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithCustomView:rightItem];
//    self.navigationItem.rightBarButtonItem = rightBarItem;
    
}

#pragma mark - 扫一扫
- (void)codeButtonAction:(UIButton *)button {
    
    SweepCodeViewController *ctrl = [[SweepCodeViewController alloc] init];
    ctrl.delegate = self;
    [self.navigationController pushViewController:ctrl animated:YES];
    
}

#pragma mark - 保存二维码
- (void)saveAction:(UITapGestureRecognizer *)tap {
    
    [UIView animateWithDuration:.1 animations:^{
        _iconImageView.transform = CGAffineTransformMakeScale(0.9, 0.9);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:.2 animations:^{
            _iconImageView.transform = CGAffineTransformMakeScale(1, 1);
        } completion:^(BOOL finished) {
            
            if (_iconImageView.image) {
                // 弹框提示是否执行
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil
                                                                               message:@"保存此二维码？"
                                                                        preferredStyle:UIAlertControllerStyleAlert];
                
                [alert addAction:[UIAlertAction actionWithTitle:@"取消"
                                                          style:UIAlertActionStyleDefault
                                                        handler:^(UIAlertAction * _Nonnull action) {
                                                            
                                                        }]];
                [alert addAction:[UIAlertAction actionWithTitle:@"确定"
                                                          style:UIAlertActionStyleDefault
                                                        handler:^(UIAlertAction * _Nonnull action) {
                                                            
                                                            UIImageWriteToSavedPhotosAlbum(_iconImageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
                                                            
                                                        }]];
                
                [self presentViewController:alert animated:YES completion:nil];
            }
            
        }];
    }];
    
    
    
    
    
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    
    if (!error) {
        FadeAlertView *showMessage = [[FadeAlertView alloc] init];
        [showMessage showAlertWith:@"已成功保存到您的相册"];
    }
    
}


#pragma mark - 输入完毕，准备生产二维码
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];

    if ([textField.text isEqualToString:@""]) {
        
        FadeAlertView *showMessage = [[FadeAlertView alloc] init];
        [showMessage showAlertWith:@"请输入内容"];
        
    } else {

        // 普通二维码
        // 1.创建滤镜对象
        CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
        
        // 2.恢复默认设置
        [filter setDefaults];
        
        // 3.设置数据
        NSString *info = textField.text;
        NSData *infoData = [info dataUsingEncoding:NSUTF8StringEncoding];
        [filter setValue:infoData forKey:@"inputMessage"];
        // 4.生成二维码
        CIImage *outputImage = [filter outputImage];
        _iconImageView.image = [self createNonInterpolatedUIIamgeFormCIImage:outputImage withSize:kScreenWidth - 40];
    
    }
    
    
    
    return YES;

}

#pragma mark - 生成普通二维码
- (UIImage *)createNonInterpolatedUIIamgeFormCIImage:(CIImage *)image withSize:(CGFloat)size
{
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size / CGRectGetWidth(extent), size / CGRectGetHeight(extent));
    
    // 1.创建bitmap
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceCMYK();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
    // 2.保存bitmap
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
}




#pragma mark - 扫描回传的值
- (void)SweepCodeViewControllerResult:(NSString *)result {
    
    if (result) {
        _inputField.text = result;
    }
    
    
    
}





























@end

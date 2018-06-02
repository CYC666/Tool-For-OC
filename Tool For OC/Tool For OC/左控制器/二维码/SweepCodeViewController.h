//
//  SweepCodeViewController.h
//  Tool For OC
//
//  Created by 曹老师 on 2018/6/2.
//  Copyright © 2018年 曹老师. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@protocol SweepCodeViewControllerDlegate
-(void)SweepCodeViewControllerResult:(NSString *)result;
@end

@interface SweepCodeViewController : UIViewController <AVCaptureMetadataOutputObjectsDelegate,UINavigationControllerDelegate>

//冲击波图片image
@property (weak, nonatomic) IBOutlet UIImageView *scanLineImageView;
//扫描区域下部的label提示
@property (weak, nonatomic) IBOutlet UILabel *customLabel;
//扫描区域的父view
@property (weak, nonatomic) IBOutlet UIView *customContainerView;
//冲击波图片和父view顶部的高度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *containerHeightConstraint;
//扫描区域的父view的高度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scanLineTopConstraint;

@property ( strong , nonatomic ) AVCaptureDevice * device;
@property ( strong , nonatomic ) AVCaptureDeviceInput * input;
@property ( strong , nonatomic ) AVCaptureMetadataOutput * output;
@property ( strong , nonatomic ) AVCaptureSession * session;
@property ( strong , nonatomic ) AVCaptureVideoPreviewLayer * previewLayer;

// 代理
@property (weak, nonatomic) id<SweepCodeViewControllerDlegate> delegate;

/*** 专门用于保存描边的图层 ***/
@property (nonatomic,strong) CALayer *containerLayer;










@end

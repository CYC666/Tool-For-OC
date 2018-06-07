//
//  SweepCodeViewController.m
//  Tool For OC
//
//  Created by 曹老师 on 2018/6/2.
//  Copyright © 2018年 曹老师. All rights reserved.
//

#import "SweepCodeViewController.h"
#import <AudioToolbox/AudioToolbox.h>

@interface SweepCodeViewController () {
    
}
@end

@implementation SweepCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    _customLabel.text = @"";
    self.view.backgroundColor = [UIColor clearColor];
    
    // 3.开始扫描二维码
    [self startScan];
    
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    //开启session
    [self.session startRunning];
    
    // 界面显示,开始动画
    [self startAnimation];
}

//注意，在界面消失的时候关闭session
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    
    //关闭session
    [self.session stopRunning];
    
    // 清除之前的描边
    [self clearLayers];
}





#pragma mark -------- 懒加载---------
- (AVCaptureDevice *)device
{
    if (_device == nil) {
        _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    }
    return _device;
}

- (AVCaptureDeviceInput *)input
{
    if (_input == nil) {
        _input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
    }
    return _input;
}

- (AVCaptureSession *)session
{
    if (_session == nil) {
        _session = [[AVCaptureSession alloc] init];
    }
    return _session;
}

- (AVCaptureVideoPreviewLayer *)previewLayer
{
    if (_previewLayer == nil) {
        _previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
    }
    return _previewLayer;
}

// 设置输出对象解析数据时感兴趣的范围
// 默认值是 CGRect(x: 0, y: 0, width: 1, height: 1)
// 通过对这个值的观察, 我们发现传入的是比例
// 注意: 参照是以横屏的左上角作为, 而不是以竖屏
//        out.rectOfInterest = CGRect(x: 0, y: 0, width: 0.5, height: 0.5)
- (AVCaptureMetadataOutput *)output
{
    if (_output == nil) {
        _output = [[AVCaptureMetadataOutput alloc] init];
        
        // 1.获取屏幕的frame
        CGRect viewRect = self.view.frame;
        // 2.获取扫描容器的frame
        CGRect containerRect = self.customContainerView.frame;
        
        CGFloat x = containerRect.origin.y / viewRect.size.height;
        CGFloat y = containerRect.origin.x / viewRect.size.width;
        CGFloat width = containerRect.size.height / viewRect.size.height;
        CGFloat height = containerRect.size.width / viewRect.size.width;
        
        // CGRect outRect = CGRectMake(x, y, width, height);
        // [_output rectForMetadataOutputRectOfInterest:outRect];
        _output.rectOfInterest = CGRectMake(x, y, width, height);
    }
    return _output;
}

- (CALayer *)containerLayer
{
    if (_containerLayer == nil) {
        _containerLayer = [[CALayer alloc] init];
    }
    return _containerLayer;
}


#pragma mark - 开始扫描
- (void)startScan
{
    // 1.判断输入能否添加到会话中
    if (![self.session canAddInput:self.input]) return;
    [self.session addInput:self.input];

    
    // 2.判断输出能够添加到会话中
    if (![self.session canAddOutput:self.output]) return;
    [self.session addOutput:self.output];

    
    // 4.设置输出能够解析的数据类型
    // 注意点: 设置数据类型一定要在输出对象添加到会话之后才能设置
    self.output.metadataObjectTypes = self.output.availableMetadataObjectTypes;
    
    
    // 5.设置监听监听输出解析到的数据
    [self.output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    // 6.添加预览图层
    [self.view.layer insertSublayer:self.previewLayer atIndex:0];
    self.previewLayer.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    
    // 7.添加容器图层
    [self.view.layer addSublayer:self.containerLayer];
    self.containerLayer.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    
    // 8.开始扫描
    [self.session startRunning];
}


#pragma mark - AVCaptureMetadataOutputObjectsDelegate 委托协议
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    
    
    
    if (metadataObjects.count > 0) {
        // id 类型不能点语法,所以要先去取出数组中对象
        AVMetadataMachineReadableCodeObject *object = [metadataObjects lastObject];
        
        //播放音频
        [self playWithEffect:@"扫一扫.wav"];
        
        if (object == nil) return;
        
        
        //获取到数据后，延时0.5秒再跳转到页面
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            //获取的字符串
            NSString *urlString = object.stringValue;
            
            // 把值传回去
            [_delegate SweepCodeViewControllerResult:urlString];
            
            [self.session stopRunning];
            
            [self.navigationController popToViewController:self.navigationController.viewControllers[1] animated:YES];
            
        });
        

        
        
        
//        // 清除之前的描边
//        [self clearLayers];
        
//        // 对扫描到的二维码进行描边
//        AVMetadataMachineReadableCodeObject *obj = (AVMetadataMachineReadableCodeObject *)[self.previewLayer transformedMetadataObjectForMetadataObject:object];
        
//        // 绘制描边
//        [self drawLine:obj];
    } else {
//        // 清除之前的描边
//        [self clearLayers];
    }
    
}

#pragma mark - 播放声音
- (void)playWithEffect:(NSString *)fileName
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:fileName ofType:nil];
    
    NSURL *url = [NSURL fileURLWithPath:filePath];
    
    //SystemSoundID其实是一个uint32的整型
    SystemSoundID soundID = 0;
    
    //1. 获取音效的ID
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)url, &soundID);
    
    //2. 注册回调函数
    AudioServicesAddSystemSoundCompletion(soundID, NULL, NULL, nil, NULL);
    
    //3. 播放音效
    AudioServicesPlaySystemSound(soundID);
    
    AudioServicesPlayAlertSound(soundID);
    //带有震动效果
}

#pragma mark - 私有方法
//利用贝塞尔曲线绘制描边
- (void)drawLine:(AVMetadataMachineReadableCodeObject *)objc
{
    NSArray *array = objc.corners;
    
    if (array == nil || array.count == 0) {
        NSLog(@"描边有异常");
    } else {
        
        // 1.创建形状图层, 用于保存绘制的矩形
        CAShapeLayer *layer = [[CAShapeLayer alloc] init];
        
        // 设置线宽
        layer.lineWidth = 2;
        layer.strokeColor = [UIColor greenColor].CGColor;
        layer.fillColor = [UIColor clearColor].CGColor;
        
        // 2.创建UIBezierPath, 绘制矩形
        UIBezierPath *path = [[UIBezierPath alloc] init];
        CGPoint point = CGPointZero;
        int index = 0;
        
        CFDictionaryRef dict = (__bridge CFDictionaryRef)(array[index++]);
        // 把点转换为不可变字典
        // 把字典转换为点，存在point里，成功返回true 其他false
        CGPointMakeWithDictionaryRepresentation(dict, &point);
        
        [path moveToPoint:point];
        
        // 2.2连接其它线段
        for (int i = 1; i<array.count; i++) {
            CGPointMakeWithDictionaryRepresentation((__bridge CFDictionaryRef)array[i], &point);
            [path addLineToPoint:point];
        }
        // 2.3关闭路径
        [path closePath];
        
        layer.path = path.CGPath;
        // 3.将用于保存矩形的图层添加到界面上
        [self.containerLayer addSublayer:layer];
    }
    
}

// 清除描边
- (void)clearLayers
{
    if (self.containerLayer.sublayers)
    {
        for (CALayer *subLayer in self.containerLayer.sublayers)
        {
            [subLayer removeFromSuperlayer];
        }
    }
}



// 开启冲击波动画
- (void)startAnimation
{
    // 1.设置冲击波底部和容器视图顶部对齐
    self.scanLineTopConstraint.constant = - self.containerHeightConstraint.constant;
    // 刷新UI
    [self.view layoutIfNeeded];
    
    // 2.执行扫描动画
    [UIView animateWithDuration:1.0 animations:^{
        // 无线重复动画
        [UIView setAnimationRepeatCount:MAXFLOAT];
        self.scanLineTopConstraint.constant = self.containerHeightConstraint.constant;
        // 刷新UI
        [self.view layoutIfNeeded];
    } completion:nil];
}



@end

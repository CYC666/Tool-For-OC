//
//  JudgeFaceCtrl.m
//  Tool For OC
//
//  Created by 曹老师 on 2018/5/9.
//  Copyright © 2018年 曹老师. All rights reserved.
//

#import "JudgeFaceCtrl.h"
#import "FaceStreamDetectorViewController.h"
#import "DemoPreDefine.h"
#import "iflyMSC/IFlyFaceSDK.h"


@interface JudgeFaceCtrl ()<FaceDetectorDelegate>
{
    UIImageView *imgView;
}
@end

@implementation JudgeFaceCtrl

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self buttonWithTitle:@"人脸识别" frame:CGRectMake((kScreenWidth - 150)*0.5, Nav_Height + 20, 150, 30) action:@selector(pushToFaceStreamDetectorVC) AddView:self.view];
    
    imgView = [[UIImageView alloc]initWithFrame:CGRectMake(50, 150, self.view.frame.size.width-100, 300)];
    imgView.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:imgView];
    
    [self makeConfiguration];
    
}

-(void)makeConfiguration
{
    //设置log等级，此处log为默认在app沙盒目录下的msc.log文件
    [IFlySetting setLogFile:LVL_ALL];
    
    //输出在console的log开关
    [IFlySetting showLogcat:YES];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachePath = [paths objectAtIndex:0];
    //设置msc.log的保存路径
    [IFlySetting setLogFilePath:cachePath];
    
    //创建语音配置,appid必须要传入，仅执行一次则可
    NSString *initString = [[NSString alloc] initWithFormat:@"appid=%@,",USER_APPID];
    
    //所有服务启动前，需要确保执行createUtility
    [IFlySpeechUtility createUtility:initString];
}

-(void)sendFaceImage:(UIImage *)faceImage {
    
    imgView.frame = CGRectMake(50, 150, self.view.frame.size.width-100, (self.view.frame.size.width-100)/faceImage.size.width*faceImage.size.height);
    imgView.image = faceImage;
}

- (void)sendFaceImageError {
    
    
    
}

-(void)pushToFaceStreamDetectorVC {
    
    FaceStreamDetectorViewController *faceVC = [[FaceStreamDetectorViewController alloc]init];
    faceVC.faceDelegate = self;
    [self.navigationController pushViewController:faceVC animated:YES];
}

#pragma mark --- 创建button公共方法
/**使用示例:[self buttonWithTitle:@"点 击" frame:CGRectMake((self.view.frame.size.width - 150)/2, (self.view.frame.size.height - 40)/3, 150, 40) action:@selector(didClickButton) AddView:self.view];*/
-(UIButton *)buttonWithTitle:(NSString *)title frame:(CGRect)frame action:(SEL)action AddView:(id)view
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = frame;
    button.backgroundColor = [UIColor colorWithRed:0.601 green:0.596 blue:0.906 alpha:1.000];
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:self action:action forControlEvents:UIControlEventTouchDown];
    [view addSubview:button];
    return button;
}

@end

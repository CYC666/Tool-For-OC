//
//  YQPanoramaViewCtrl.m
//  Tool For OC
//
//  Created by 曹老师 on 2018/4/18.
//  Copyright © 2018年 曹老师. All rights reserved.
//

#import "YQPanoramaViewCtrl.h"
#import "YQPanoramaView.h"

@interface YQPanoramaViewCtrl ()

@property (nonatomic,strong) YQPanoramaView *panaromview;

@end

@implementation YQPanoramaViewCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始化
    self.panaromview = [[YQPanoramaView alloc]initWithFrame:CGRectMake(0, Nav_Height, self.view.frame.size.width, self.view.frame.size.height-Nav_Height)];
    
    //设图片
    self.panaromview.image = [UIImage imageNamed:@"WechatIMG72.jpeg"];
    
    //显示
    [self.view addSubview:self.panaromview];
    
    //完事了
}

@end

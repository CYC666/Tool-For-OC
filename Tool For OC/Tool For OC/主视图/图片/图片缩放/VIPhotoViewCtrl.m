//
//  VIPhotoViewCtrl.m
//  Tool For OC
//
//  Created by 曹老师 on 2018/4/19.
//  Copyright © 2018年 曹老师. All rights reserved.
//

#import "VIPhotoViewCtrl.h"
#import "VIPhotoView.h"

@interface VIPhotoViewCtrl ()

@property (nonatomic, strong) VIPhotoView *photoView;


@end

@implementation VIPhotoViewCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UIImage *image = [UIImage imageNamed:@"test.JPG"];
    
    self.photoView = [[VIPhotoView alloc] initWithFrame:CGRectMake(10, Nav_Height + 10, kScreenWidth - 20, (kScreenWidth - 20)* 0.6)];
    self.photoView.layer.borderWidth = 1;
    self.photoView.layer.borderColor = [UIColor blackColor].CGColor;
    self.photoView.contentMode = VIPhotoViewContentModeScaleAspectFit;
    self.photoView.image = image;
    self.photoView.autoresizingMask = (1 << 6) -1;
    self.photoView.contentMode = VIPhotoViewContentModeScaleAspectFit;
    
    [self.view addSubview:self.photoView];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

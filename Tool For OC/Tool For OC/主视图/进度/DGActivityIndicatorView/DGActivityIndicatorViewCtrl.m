//
//  DGActivityIndicatorViewCtrl.m
//  Tool For OC
//
//  Created by 曹老师 on 2018/5/6.
//  Copyright © 2018年 曹老师. All rights reserved.
//

#import "DGActivityIndicatorViewCtrl.h"
#import "DGActivityIndicatorView.h"

@implementation DGActivityIndicatorViewCtrl

#pragma mark -

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:237/255.0f green:85/255.0f blue:101/255.0f alpha:1.0f];
    
    NSArray *activityTypes = @[@(DGActivityIndicatorAnimationTypeNineDots),
                               @(DGActivityIndicatorAnimationTypeTriplePulse),
                               @(DGActivityIndicatorAnimationTypeFiveDots),
                               @(DGActivityIndicatorAnimationTypeRotatingSquares),
                               @(DGActivityIndicatorAnimationTypeDoubleBounce),
                               @(DGActivityIndicatorAnimationTypeTwoDots),
                               @(DGActivityIndicatorAnimationTypeThreeDots),
                               @(DGActivityIndicatorAnimationTypeBallPulse),
                               @(DGActivityIndicatorAnimationTypeBallClipRotate),
                               @(DGActivityIndicatorAnimationTypeBallClipRotatePulse),
                               @(DGActivityIndicatorAnimationTypeBallClipRotateMultiple),
                               @(DGActivityIndicatorAnimationTypeBallRotate),
                               @(DGActivityIndicatorAnimationTypeBallZigZag),
                               @(DGActivityIndicatorAnimationTypeBallZigZagDeflect),
                               @(DGActivityIndicatorAnimationTypeBallTrianglePath),
                               @(DGActivityIndicatorAnimationTypeBallScale),
                               @(DGActivityIndicatorAnimationTypeLineScale),
                               @(DGActivityIndicatorAnimationTypeLineScaleParty),
                               @(DGActivityIndicatorAnimationTypeBallScaleMultiple),
                               @(DGActivityIndicatorAnimationTypeBallPulseSync),
                               @(DGActivityIndicatorAnimationTypeBallBeat),
                               @(DGActivityIndicatorAnimationTypeLineScalePulseOut),
                               @(DGActivityIndicatorAnimationTypeLineScalePulseOutRapid),
                               @(DGActivityIndicatorAnimationTypeBallScaleRipple),
                               @(DGActivityIndicatorAnimationTypeBallScaleRippleMultiple),
                               @(DGActivityIndicatorAnimationTypeTriangleSkewSpin),
                               @(DGActivityIndicatorAnimationTypeBallGridBeat),
                               @(DGActivityIndicatorAnimationTypeBallGridPulse),
                               @(DGActivityIndicatorAnimationTypeRotatingSandglass),
                               @(DGActivityIndicatorAnimationTypeRotatingTrigons),
                               @(DGActivityIndicatorAnimationTypeTripleRings),
                               @(DGActivityIndicatorAnimationTypeCookieTerminator),
                               @(DGActivityIndicatorAnimationTypeBallSpinFadeLoader)];
    
    for (int i = 0; i < activityTypes.count; i++) {
        DGActivityIndicatorView *activityIndicatorView = [[DGActivityIndicatorView alloc] initWithType:(DGActivityIndicatorAnimationType)[activityTypes[i] integerValue] tintColor:[UIColor whiteColor]];
        CGFloat width = self.view.bounds.size.width / 5.0f;
        CGFloat height = self.view.bounds.size.height / 7.0f;
        
        activityIndicatorView.frame = CGRectMake(width * (i % 7), height * (int)(i / 7), width, height);
        [self.view addSubview:activityIndicatorView];
        [activityIndicatorView startAnimating];
    }
}

@end

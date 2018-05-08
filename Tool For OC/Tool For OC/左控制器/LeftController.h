//
//  LeftController.h
//  Tool For OC
//
//  Created by 曹老师 on 2018/4/17.
//  Copyright © 2018年 曹老师. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LeftControllerDlegate
// 点击单元格
-(void)LeftControllerIndexChange:(NSString *)ctrl;
@end


@interface LeftController : UIViewController

// 代理
@property (weak, nonatomic) id<LeftControllerDlegate> delegate;

@end

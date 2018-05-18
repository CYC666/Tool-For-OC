//
//  UIButton+click.h
//  Tool For OC
//
//  Created by 曹老师 on 2018/5/14.
//  Copyright © 2018年 曹老师. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (click)

@property (nonatomic, strong) void (^clickBlock) (void);
- (void) setOnclick:(void (^)(void))block;
//- (void) clickBtn : (UIButton*) sender;
//- (void) setTarget : action:(SEL)action;

@end

//
//  UIButton+click.m
//  Tool For OC
//
//  Created by 曹老师 on 2018/5/14.
//  Copyright © 2018年 曹老师. All rights reserved.
//

#import "UIButton+click.h"
#import <objc/runtime.h>

@implementation UIButton(click)

static void *clickKey = &clickKey;
- (void)setClickBlock:(void (^)(void))clickBlock{
    objc_setAssociatedObject(self, & clickKey, clickBlock, OBJC_ASSOCIATION_COPY);
}

- (void (^)(void))clickBlock{
    return objc_getAssociatedObject(self, &clickKey);
}

-(void)setOnclick:(void (^)(void))block{
    self.clickBlock = block;
    [self addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)clickBtn:(UIButton*) sender{
    self.clickBlock();
}
@end

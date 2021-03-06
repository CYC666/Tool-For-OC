//
//  ChatItem.h
//  UInet Bubble
//
//  Created by qianfeng on 14-7-23.
//  Copyright (c) 2014年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


typedef enum{
    textStates,
    picStates,
    videoStates,
    
}newsStates;

@interface ChatItem : NSObject


@property(nonatomic,assign)BOOL isSelf;//判断是接受，还是发的
@property(nonatomic,assign)newsStates states;
@property(nonatomic,strong)NSString * content;

@property(nonatomic, strong)UIImage * picImage;


@property(nonatomic, strong)NSData * recordData;

// 数据内容

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com

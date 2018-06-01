//
//  CalcularViewController.h
//  Tool For OC
//
//  Created by 曹老师 on 2018/6/1.
//  Copyright © 2018年 曹老师. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CalcularViewController : UIViewController



//@property (copy, nonatomic) NSString *numberA;      // 储存A
//@property (assign, nonatomic) BOOL isA;             // 是否已经储存A
//@property (copy, nonatomic) NSString *type;         // 算法
//@property (assign, nonatomic) BOOL isResult;        // 是否刚进行了一次计算



@property (weak, nonatomic) IBOutlet UILabel *resultLabel;  // 显示

@property (copy, nonatomic) NSString *A;                    // A值
@property (copy, nonatomic) NSString *FUN;                  // 算法
@property (copy, nonatomic) NSString *B;                    // B值
@property (copy, nonatomic) NSString *RESULT;               // 结果

@property (assign, nonatomic) BOOL CLEAR;                   // 是否重新赋值



@end

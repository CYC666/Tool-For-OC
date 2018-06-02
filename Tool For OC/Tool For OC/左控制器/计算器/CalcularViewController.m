//
//  CalcularViewController.m
//  Tool For OC
//
//  Created by 曹老师 on 2018/6/1.
//  Copyright © 2018年 曹老师. All rights reserved.
//

#import "CalcularViewController.h"

@interface CalcularViewController ()

@end

@implementation CalcularViewController


#pragma mark ========================================生命周期========================================
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 初始化
    [self AC:nil];
    
    _resultLabel.adjustsFontSizeToFitWidth = YES;
    
    // 添加右滑手势，删除字节
    UISwipeGestureRecognizer *rightSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeAction:)];
    rightSwipe.direction = UISwipeGestureRecognizerDirectionRight;
    rightSwipe.numberOfTouchesRequired = 1;
    [_resultLabel addGestureRecognizer:rightSwipe];
    _resultLabel.userInteractionEnabled = YES;
}


- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];

    [self.navigationController setNavigationBarHidden:YES animated:YES];


}

#pragma mark ========================================动作响应=============================================

#pragma mark - 右滑删除字节
- (void)swipeAction:(UISwipeGestureRecognizer *)swipe {
    
    if (swipe.state == UIGestureRecognizerStateEnded) {
        
        if (![_resultLabel.text isEqualToString:@"0"]) {
            
            // 非0操作
            if (_resultLabel.text.length == 1) {
                
                // 只有一个字节，那么久变0
                _resultLabel.text = @"0";
                
            } else {
                
                // 去除最后一个字节
                _resultLabel.text = [_resultLabel.text substringToIndex:_resultLabel.text.length-1];
                
            }
            
        }
        
    }
    
}

// 清零
- (IBAction)AC:(UIButton *)sender {
    
    
    _resultLabel.text = @"0";
    
    _A = @"";
    _FUN = @"";
    _B = @"";
    _RESULT = @"";
    
}

#pragma mark - 只对结果操作
// 正负
- (IBAction)FB:(UIButton *)sender {
    
    if (_resultLabel.text.floatValue > 0) {
        
        // 添加 -
        _resultLabel.text = [NSString stringWithFormat:@"-%@", _resultLabel.text];
    } else {
        
        // 去除 -
        _resultLabel.text = [_resultLabel.text stringByReplacingOccurrencesOfString:@"-" withString:@""];
        
    }
    
}

// 百分比
- (IBAction)per:(UIButton *)sender {
    
    if (![_resultLabel.text isEqualToString:@"0"]) {
        
        if ([_resultLabel.text rangeOfString:@"."].location != NSNotFound) {
            
            // 已经是小数，不要再搞啦
            return;
        }
        
        _resultLabel.text = [NSString stringWithFormat:@"%.2f", _resultLabel.text.floatValue / 100.0];
        
    }
    
}

#pragma mark - 算法
// 除
- (IBAction)DIV:(UIButton *)sender {
    
    _FUN = @"/";
    _A = _resultLabel.text;
    _CLEAR = YES;
    
}

// 乘
- (IBAction)MUL:(UIButton *)sender {
    
    _FUN = @"*";
    _A = _resultLabel.text;
    _CLEAR = YES;
    
}

// 减
- (IBAction)SUB:(UIButton *)sender {
    
    _FUN = @"-";
    _A = _resultLabel.text;
    _CLEAR = YES;
    
}

// 加
- (IBAction)ADD:(UIButton *)sender {
    
    _FUN = @"+";
    _A = _resultLabel.text;
    _CLEAR = YES;
    
}


#pragma mark - 赋值
// 9
- (IBAction)NINE:(UIButton *)sender {
    
    if (_CLEAR) {
        
        // 重新赋值
        _resultLabel.text = @"";
        _CLEAR = NO;
        
    }
    
    
    
    if ([_resultLabel.text isEqualToString:@"0"]) {
        _resultLabel.text = @"9";
    } else {
        _resultLabel.text = [NSString stringWithFormat:@"%@9", _resultLabel.text];
    }
    
}

// 8
- (IBAction)EIGHT:(UIButton *)sender {
    
    if (_CLEAR) {
        
        // 重新赋值
        _resultLabel.text = @"";
        _CLEAR = NO;
        
    }
    
    if ([_resultLabel.text isEqualToString:@"0"]) {
        _resultLabel.text = @"8";
    } else {
        _resultLabel.text = [NSString stringWithFormat:@"%@8", _resultLabel.text];
    }
    
}

// 7
- (IBAction)SEVEN:(UIButton *)sender {
    
    
    if (_CLEAR) {
        
        // 重新赋值
        _resultLabel.text = @"";
        _CLEAR = NO;
        
    }
    
    if ([_resultLabel.text isEqualToString:@"0"]) {
        _resultLabel.text = @"7";
    } else {
        _resultLabel.text = [NSString stringWithFormat:@"%@7", _resultLabel.text];
    }
    
}

// 6
- (IBAction)SIX:(UIButton *)sender {
    
    if (_CLEAR) {
        
        // 重新赋值
        _resultLabel.text = @"";
        _CLEAR = NO;
        
    }
    
    if ([_resultLabel.text isEqualToString:@"0"]) {
        _resultLabel.text = @"6";
    } else {
        _resultLabel.text = [NSString stringWithFormat:@"%@6", _resultLabel.text];
    }
    
}

// 5
- (IBAction)FIVE:(UIButton *)sender {
    
    if (_CLEAR) {
        
        // 重新赋值
        _resultLabel.text = @"";
        _CLEAR = NO;
        
    }
    
    if ([_resultLabel.text isEqualToString:@"0"]) {
        _resultLabel.text = @"5";
    } else {
        _resultLabel.text = [NSString stringWithFormat:@"%@5", _resultLabel.text];
    }
    
}

// 4
- (IBAction)FOUR:(UIButton *)sender {
    
    if (_CLEAR) {
        
        // 重新赋值
        _resultLabel.text = @"";
        _CLEAR = NO;
        
    }
    
    if ([_resultLabel.text isEqualToString:@"0"]) {
        _resultLabel.text = @"4";
    } else {
        _resultLabel.text = [NSString stringWithFormat:@"%@4", _resultLabel.text];
    }
    
}

// 3
- (IBAction)THREE:(UIButton *)sender {
    
    if (_CLEAR) {
        
        // 重新赋值
        _resultLabel.text = @"";
        _CLEAR = NO;
        
    }
    
    if ([_resultLabel.text isEqualToString:@"0"]) {
        _resultLabel.text = @"3";
    } else {
        _resultLabel.text = [NSString stringWithFormat:@"%@3", _resultLabel.text];
    }
    
}

// 2
- (IBAction)TWO:(UIButton *)sender {
    
    if (_CLEAR) {
        
        // 重新赋值
        _resultLabel.text = @"";
        _CLEAR = NO;
        
    }
    
    if ([_resultLabel.text isEqualToString:@"0"]) {
        _resultLabel.text = @"2";
    } else {
        _resultLabel.text = [NSString stringWithFormat:@"%@2", _resultLabel.text];
    }
    
}

// 1
- (IBAction)ONE:(UIButton *)sender {
    
    if (_CLEAR) {
        
        // 重新赋值
        _resultLabel.text = @"";
        _CLEAR = NO;
        
    }
    
    if ([_resultLabel.text isEqualToString:@"0"]) {
        _resultLabel.text = @"1";
    } else {
        _resultLabel.text = [NSString stringWithFormat:@"%@1", _resultLabel.text];
    }
    
}

// 0
- (IBAction)ZERO:(UIButton *)sender {
    
    if (_CLEAR) {
        
        // 重新赋值
        _resultLabel.text = @"";
        _CLEAR = NO;
        
    }
    
    if ([_resultLabel.text isEqualToString:@"0"]) {
        _resultLabel.text = @"0";
    } else {
        _resultLabel.text = [NSString stringWithFormat:@"%@0", _resultLabel.text];
    }
    
}

// .
- (IBAction)POINT:(UIButton *)sender {
    
    if (_CLEAR) {
        
        // 重新赋值
        _resultLabel.text = @"0.";
        _CLEAR = NO;
        return;
        
    }
    
    if ([_resultLabel.text rangeOfString:@"."].location != NSNotFound) {
        
        // 已经有小数点，那就不用再添加了
        return;
    }
    
    
    if ([_resultLabel.text isEqualToString:@"0"]) {
        _resultLabel.text = @"0.";
    } else {
        _resultLabel.text = [NSString stringWithFormat:@"%@.", _resultLabel.text];
    }
    
    
}


#pragma mark - 结果
- (IBAction)RESULT:(UIButton *)sender {
    
    if ([_A isEqualToString:@""]) {
        
        // 还没输入A值
        return;
    }
    
    if ([_FUN isEqualToString:@""]) {
        
        // 还没输入算法
        return;
    }
    
    // 赋予B值
    _B = _resultLabel.text;
    
    // 开始计算
    float result = 0;
    if ([_FUN isEqualToString:@"+"]) {
        
        // 加
        result = _A.floatValue + _B.floatValue;
        
    } else if ([_FUN isEqualToString:@"-"]) {
        
        // 减
        result = _A.floatValue - _B.floatValue;
        
        
    } else if ([_FUN isEqualToString:@"*"]) {
        
        // 乘
        result = _A.floatValue * _B.floatValue;
        
    } else {
        
        // 除
        if ([_B isEqualToString:@"0"]) {
            // 除数不能为0
            return;
        } else {
            result = _A.floatValue / _B.floatValue;
        }
        
    }
    // 搞定小数的问题
    
    // 将浮点数化成字符串，再将其用小数点分割，肯定是两个整数
    NSArray *resultArray = [[NSString stringWithFormat:@"%.6f", result] componentsSeparatedByString:@"."];
    NSString *strF = resultArray.firstObject;   // 整数
    NSString *strB = resultArray.lastObject;    // 小数
    
    if (strB.floatValue > 0) {
        
        // 小数 002400
        NSInteger count = 0;    // 计算尾数0的个数
        for (NSInteger i = 5; i >= 0; i--) {
            
            if ([strB characterAtIndex:i] == '0') {
                
                count++;
                
            } else {
                
                // 遇到非0，跳出循环
                break;
            }
            
        }
        
        strB = [strB substringWithRange:NSMakeRange(0, 6 - count)];     // 去除尾部的0
        _RESULT = [NSString stringWithFormat:@"%@.%@", strF, strB];
        
        
        
    } else {
        
        // 整数
        _RESULT = strF;
        
    }
    
    // 显示结果
    _resultLabel.text = _RESULT;
    
    // 清空
    _A = @"";
    _FUN = @"";
    _B = @"";
    _CLEAR = YES;
    
}










#pragma mark ========================================网络请求=============================================


#pragma mark ========================================代理方法=============================================







































@end

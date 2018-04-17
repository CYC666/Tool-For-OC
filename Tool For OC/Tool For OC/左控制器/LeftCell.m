//
//  LeftCell.m
//  Tool For OC
//
//  Created by 曹老师 on 2018/4/17.
//  Copyright © 2018年 曹老师. All rights reserved.
//

#import "LeftCell.h"

@implementation LeftCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

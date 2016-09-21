//
//  BroughtHistoryCell.m
//  掌上云购
//
//  Created by coco船长 on 16/8/18.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import "BroughtHistoryCell.h"

@implementation BroughtHistoryCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _headPic.layer.cornerRadius = _headPic.width/2;
    _headPic.layer.masksToBounds = YES;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

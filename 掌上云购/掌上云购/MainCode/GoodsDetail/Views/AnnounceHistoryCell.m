//
//  AnnounceHistoryCell.m
//  掌上云购
//
//  Created by coco船长 on 16/8/18.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import "AnnounceHistoryCell.h"

@implementation AnnounceHistoryCell

- (void)awakeFromNib {
    [super awakeFromNib];
//    _goodsMsgLabel.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.3];
//    _goodsMsgLabel.textColor = [UIColor redColor];
    _picImgView.layer.cornerRadius = _picImgView.width/2;
    _picImgView.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

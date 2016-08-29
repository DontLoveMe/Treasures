//
//  SnatchRecordingCell.m
//  掌上云购
//
//  Created by 刘毅 on 16/8/24.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import "SnatchRecordingCell.h"

@implementation SnatchRecordingCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setRcModel:(RecordModel *)rcModel {
    _rcModel = rcModel;
    _titleLabel.text = _rcModel.name;
    _issueLabel.text = [NSString stringWithFormat:@"期号：%@",_rcModel.saleDraw.drawTimes];
    _sumLabel.text = [NSString stringWithFormat:@"总需人次：%@人次",_rcModel.totalShare];
    _surplusLabel.text =[NSString stringWithFormat:@"剩余人次：：%@人次",_rcModel.surplusShare];
    _participateLabel.text = [NSString stringWithFormat:@"本期参与人次：%@人次",_rcModel.sellShare];
}

- (IBAction)AgainAction:(UIButton *)sender {
}


@end

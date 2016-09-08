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
    
    Propicturelist *prtLs = _rcModel.proPictureList[0];
    NSURL *url = [NSURL URLWithString:prtLs.img650];
    [_imgView setImageWithURL:url placeholderImage:[UIImage imageNamed:@"揭晓-图片.jpg"]];
    
    _titleLabel.text = _rcModel.name;
    _issueLabel.text = [NSString stringWithFormat:@"期号：%@",_rcModel.saleDraw.drawTimes];
    _sumLabel.text = [NSString stringWithFormat:@"总需人次：%ld人次",(long)_rcModel.saleDraw.totalShare];
    _surplusLabel.text =[NSString stringWithFormat:@"剩余人次：：%ld人次",(long)_rcModel.saleDraw.surplusShare];
    _participateLabel.text = [NSString stringWithFormat:@"本期参与人次：%ld人次",(long)_rcModel.saleDraw.sellShare];
    
    NSInteger prograss = _rcModel.saleDraw.sellShare*100/_rcModel.saleDraw.totalShare;
    _progressView.progress = prograss;
    _progressLabel.text = [NSString stringWithFormat:@"%ld%%",prograss];
}

- (IBAction)AgainAction:(UIButton *)sender {
}


@end

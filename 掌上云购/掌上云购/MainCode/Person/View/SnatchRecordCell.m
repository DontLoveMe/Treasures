//
//  SnatchRecordCell.m
//  掌上云购
//
//  Created by 刘毅 on 16/8/9.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import "SnatchRecordCell.h"

@implementation SnatchRecordCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setRcModel:(RecordModel *)rcModel {
    _rcModel = rcModel;
    
    Propicturelist *prtLs = _rcModel.proPictureList[0];
    NSURL *url = [NSURL URLWithString:prtLs.img650];
    [_imgView setImageWithURL:url placeholderImage:[UIImage imageNamed:@"揭晓-图片.jpg"]];
    
    _titleLabel.text = rcModel.name;
    _issueLabel.text = [NSString stringWithFormat:@"期号：%@",rcModel.saleDraw.drawTimes
];
    _peopleNum.text = [NSString stringWithFormat:@"%@",rcModel.sellShare];
    _getName.text = rcModel.saleDraw.nickName;
    _getPeopleN.text = [NSString stringWithFormat:@"%ld",rcModel.saleDraw.sellShare];

}

//查看详情
- (IBAction)lookDetailAction:(UIButton *)sender {
}
//再次购买
- (IBAction)againShopAction:(UIButton *)sender {
}

@end

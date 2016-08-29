//
//  RechargeRecordCell.m
//  掌上云购
//
//  Created by 刘毅 on 16/8/17.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import "RechargeRecordCell.h"

@implementation RechargeRecordCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setRaModel:(RechargeModel *)raModel {
    _raModel = raModel;
    NSString *ratpStr;
    if ([_raModel.rechargeType integerValue] == 2) {
        ratpStr = @"微信支付";
    }
    _rechargeType.text = [NSString stringWithFormat:@"充值方式：%@",ratpStr];
    
//    _openingTime.text = _raModel.openingTime;
    _feeLabel.text = [NSString stringWithFormat:@"%@元",_raModel.fee];
}

@end

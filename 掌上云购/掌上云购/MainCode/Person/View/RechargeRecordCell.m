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
    switch ([_raModel.rechargeType integerValue]) {
        case 1:
            ratpStr = @"支付宝支付";
            break;
        case 2:
            ratpStr = @"微信支付";
            break;
        case 3:
            ratpStr = @"充值卡支付";
            break;
        case 4:
            ratpStr = @"银联支付";
            break;
        case 5:
            ratpStr = @"红包赠送";
            break;
        case 6:
            ratpStr = @"手动调整";
            break;
            
        default:
            break;
    }
    _rechargeType.text = [NSString stringWithFormat:@"充值方式：%@",ratpStr];
   
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:_raModel.openingTime/1000];
    NSLog(@"date:%@",[detaildate description]);
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSString *currentDateStr = [dateFormatter stringFromDate: detaildate];
    _openingTime.text = currentDateStr;
    
    _feeLabel.text = [NSString stringWithFormat:@"%@元",_raModel.fee];
}

@end

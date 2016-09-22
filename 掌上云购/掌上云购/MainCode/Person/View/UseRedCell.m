//
//  UseRedCell.m
//  掌上云购
//
//  Created by 刘毅 on 16/8/16.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import "UseRedCell.h"

@implementation UseRedCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setReModel:(RedEnvelopeModel *)reModel {
    _reModel = reModel;
    
    NSInteger money = _reModel.amount;
    switch (money) {
        case 1:
            _redImgView.image = [UIImage imageNamed:@"1元"];
            break;
        case 2:
            _redImgView.image = [UIImage imageNamed:@"2元"];
            break;
        case 5:
            _redImgView.image = [UIImage imageNamed:@"5元"];
            break;
        case 10:
            _redImgView.image = [UIImage imageNamed:@"10元"];
            break;
        case 50:
            _redImgView.image = [UIImage imageNamed:@"50元"];
            break;
            
        default:
            _redImgView.image = [UIImage imageNamed:@"红包"];
            break;
    }
    
    switch ([_reModel.status integerValue]) {
            //1：未使用，2：已使用 ，3：失效
        case 1:
            _stateLabel.hidden = YES;
            break;
        case 2:
            _stateLabel.text = @"已使用";
            _stateLabel.textColor = [UIColor colorFromHexRGB:ThemeColor];
            _endLabel.textColor = [UIColor colorWithWhite:0.7 alpha:1];
            _conditionLabel.textColor = [UIColor colorWithWhite:0.7 alpha:1];
            break;
        case 3:
            _stateLabel.text = @"失效";
            _stateLabel.textColor = [UIColor colorWithWhite:0.7 alpha:1];
            _endLabel.textColor = [UIColor colorWithWhite:0.7 alpha:1];
            _conditionLabel.textColor = [UIColor colorWithWhite:0.7 alpha:1];
            break;
            
        default:
            break;
    }
    
    _sourceLabel.text = [NSString stringWithFormat:@"红包来源：%@",_reModel.activityName];
    
//    _beginTimeLb.text = [NSString stringWithFormat:@"生效日期：%@",_reModel.effectiveStartDate];
    
    
    if (_reModel.effectiveEndDate) {
        _endLabel.text = [NSString stringWithFormat:@"有效期：%@",_reModel.effectiveEndDate];
    }else if([_reModel.isPermanentEffective boolValue]){
        _endLabel.text = [NSString stringWithFormat:@"有效期：永久有效"];
    }else {
        _endLabel.text = @"";
    }
    
    _conditionLabel.text = [NSString stringWithFormat:@"%@",_reModel.remarks];
    
    
}

@end

//
//  AddressCell.m
//  掌上云购
//
//  Created by 刘毅 on 16/8/17.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import "AddressCell.h"
#import "AddressModel.h"


@implementation AddressCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(AddressModel *)model {
    _model = model;
    
    _nameLabel.text = _model.receiver;
    
    _phoneLabel.text = [NSString stringWithFormat:@"联系方式：%@",[_model.mobile stringValue]];
    
    if (![_model.province[@"name"]isKindOfClass:[NSNull class]]) {
        if ([_model.city[@"name"]isEqualToString:_model.area[@"name"]]) {
            _addressLabel.text = [NSString stringWithFormat:@"地址：%@%@%@",_model.province[@"name"],_model.city[@"name"],_model.addressDetail];
        }else{
            _addressLabel.text = [NSString stringWithFormat:@"地址：%@%@%@%@",_model.province[@"name"],_model.city[@"name"],_model.area[@"name"],_model.addressDetail];
        }
       
    }else {
        
        _addressLabel.text = _model.addressDetail;
    }
    
    if ([_model.isDefault boolValue]) {
        _defaultButton.selected = YES;
        [_setDfaultBtn setTitle:@"默认地址" forState:UIControlStateNormal];
        [_setDfaultBtn setTitleColor:[UIColor colorFromHexRGB:ThemeColor] forState:UIControlStateNormal];
    }else {
        _defaultButton.selected = NO;
        [_setDfaultBtn setTitle:@"设为默认" forState:UIControlStateNormal];
        [_setDfaultBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
}
- (IBAction)defaultAction:(UIButton *)sender {
    
    self.selectDefault(sender);
   
}

@end

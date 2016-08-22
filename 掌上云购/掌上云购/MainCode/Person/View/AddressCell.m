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
    
    _phoneLabel.text = [_model.mobile stringValue];
    
    if (![_model.province[@"name"]isKindOfClass:[NSNull class]]) {
        if ([_model.city[@"name"]isEqualToString:_model.area[@"name"]]) {
            _addressLabel.text = [NSString stringWithFormat:@"%@%@%@",_model.province[@"name"],_model.city[@"name"],_model.addressDetailFull];
        }else{
            _addressLabel.text = [NSString stringWithFormat:@"%@%@%@%@",_model.province[@"name"],_model.city[@"name"],_model.area[@"name"],_model.addressDetailFull];
        }
       
    }else {
        
        _addressLabel.text = _model.addressDetailFull;
    }
    
    if ([_model.isDefault boolValue]) {
        _defaultButton.selected = YES;
    }else {
        _defaultButton.selected = NO;
    }
}
- (IBAction)defaultAction:(UIButton *)sender {
    
    self.selectDefault(sender);
   
}

@end

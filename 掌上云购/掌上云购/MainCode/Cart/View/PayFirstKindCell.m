//
//  PayFirstKindCell.m
//  掌上云购
//
//  Created by 杨浩斌 on 16/8/17.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import "PayFirstKindCell.h"
#import "UIView+SDAutoLayout.h"
@implementation PayFirstKindCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self initWithUI];
    }
    
    return self;

}

-(void)initWithUI{
    
    _goodsTotal = [[UILabel alloc]init];
    _goodsTotal.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:_goodsTotal];
    _goodsTotal.sd_layout
    .leftSpaceToView(self.contentView,14)
    .centerYEqualToView(self.contentView)
    .widthIs(KScreenWidth - 80)
    .heightIs(20);
    
    
    _iconView = [[UIImageView alloc]init];
    [self.contentView addSubview:_iconView];
    _iconView.sd_layout
    .rightSpaceToView(self.contentView,11)
    .centerYEqualToView(self.contentView)
    .widthIs(16)
    .heightIs(9);
    
    _radio = [UIButton buttonWithType:UIButtonTypeCustom];
    _radio.hidden = YES;
    [self.contentView addSubview:_radio];
    
    
    _radio.sd_layout
    .rightSpaceToView(self.contentView,11)
    .centerYEqualToView(_iconView)
    .widthIs(20)
    .heightIs(20);
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

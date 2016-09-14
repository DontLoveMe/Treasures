//
//  PayThreeKindCell.m
//  掌上云购
//
//  Created by 杨浩斌 on 16/8/17.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import "PayThreeKindCell.h"
#import "UIView+SDAutoLayout.h"
@implementation PayThreeKindCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self initWithUI];
    }
    
    return self;
    
}

-(void)initWithUI
{

   
    _iconView = [[UIImageView alloc]init];
    
    [self.contentView addSubview:_iconView];
    
    _iconView.sd_layout
    .leftSpaceToView(self.contentView,14)
    .topSpaceToView(self.contentView,5)
    .widthIs(40)
    .heightIs(40);
    
    _wechat  =[[UILabel alloc]init];
    
    [self.contentView addSubview:_wechat];
    
    _wechat.sd_layout
    .leftSpaceToView(_iconView,10)
    .centerYEqualToView(_iconView)
    .widthIs(100)
    .heightIs(20);
    
    _radio = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [self.contentView addSubview:_radio]
    ;
    
    _radio.sd_layout
    .rightSpaceToView(self.contentView,11)
    .centerYEqualToView(_iconView)
    .widthIs(20)
    .heightIs(20);
    
}

@end

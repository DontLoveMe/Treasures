//
//  DiscoverCell.m
//  掌上云购
//
//  Created by 杨浩斌 on 16/8/19.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import "DiscoverCell.h"
#import "UIView+SDAutoLayout.h"
@implementation DiscoverCell

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
    
    _iconView.contentMode = UIViewContentModeCenter;
    _iconView.sd_layout
    .leftSpaceToView(self.contentView,5)
    .centerYEqualToView(self.contentView)
    .widthIs(40)
    .heightIs(40);
    
    _titleLabel = [[UILabel alloc]init];
    _titleLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:_titleLabel];
    
    
    _titleLabel.sd_layout
    .leftSpaceToView(_iconView,10)
    .topSpaceToView(self.contentView,10)
    .rightSpaceToView(self.contentView,10)
    .heightIs(20);
    
    
    _detailLabel = [[UILabel alloc]init];
    _detailLabel.font = [UIFont systemFontOfSize:13];
    _detailLabel.textColor = [UIColor grayColor];
    [self.contentView addSubview:_detailLabel];
    
    _detailLabel.sd_layout
    .leftEqualToView(_titleLabel)
    .topSpaceToView(_titleLabel,10)
    .rightSpaceToView(self.contentView,10)
    .heightIs(20);
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

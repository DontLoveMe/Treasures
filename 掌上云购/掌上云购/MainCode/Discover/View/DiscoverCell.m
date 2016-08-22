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
    
    _iconView.sd_layout
    .leftSpaceToView(self.contentView,5)
    .topSpaceToView(self.contentView,10)
    .widthIs(60)
    .heightIs(60);
    
    _titleLabel = [[UILabel alloc]init];
    
    [self.contentView addSubview:_titleLabel];
    
    
    _titleLabel.sd_layout
    .leftSpaceToView(_iconView,10)
    .topSpaceToView(self.contentView,20)
    .widthIs(200)
    .heightIs(20);
    
    
    _detailLabel = [[UILabel alloc]init];
    
    [self.contentView addSubview:_detailLabel];
    
    _detailLabel.sd_layout
    .leftEqualToView(_titleLabel)
    .topSpaceToView(_titleLabel,10)
    .widthIs(300)
    .heightIs(20);
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

//
//  LuckCell.m
//  掌上云购
//
//  Created by 杨浩斌 on 16/8/23.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import "LuckCell.h"
#import "UIView+SDAutoLayout.h"
@implementation LuckCell


-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self initWithUI];
    }
    
    return self;
    
}
/**
 *  @property(nonatomic,strong)UIImageView *iconView;
 
 @property(nonatomic,strong)UILabel *goodsLabel;
 
 @property(nonatomic,strong)UILabel *numberLabel;
 
 @property(nonatomic,strong)UILabel *totalLabel;
 
 @property(nonatomic,strong)UILabel *luckLabel;
 
 @property(nonatomic,strong)UILabel *peopleLabel;
 
 @property(nonatomic,strong)UILabel *timeLabel;

 */
-(void)initWithUI
{

    _iconView = [[UIImageView alloc]init];
    
    [self.contentView addSubview:_iconView];
    
    _iconView.sd_layout
    .leftSpaceToView(self.contentView,10)
    .topSpaceToView(self.contentView,10)
    .widthIs(40)
    .heightIs(60);
    
    _goodsLabel = [[UILabel alloc]init];
    
    [self.contentView addSubview:_goodsLabel];
    
    _goodsLabel.sd_layout
    .leftSpaceToView(_iconView,10)
    .topSpaceToView(self.contentView,15)
    .widthIs(100)
    .heightIs(20);
    
    _numberLabel = [[UILabel alloc]init];
    
    [self.contentView addSubview:_numberLabel];
    
    _numberLabel.sd_layout
    .leftEqualToView(_goodsLabel)
    .topSpaceToView(_goodsLabel,10)
    .widthIs(100)
    .heightIs(20);
    
    _totalLabel = [[UILabel alloc]init];
    
    [self.contentView addSubview:_totalLabel];
    
    _totalLabel.sd_layout
    .leftEqualToView(_goodsLabel)
    .topSpaceToView(_numberLabel,10)
    .widthIs(100)
    .heightIs(20);
    
    _luckLabel = [[UILabel alloc]init];
    
    [self.contentView addSubview:_luckLabel];
    
    _luckLabel.sd_layout
    .leftEqualToView(_totalLabel)
    .topSpaceToView(_totalLabel,10)
    .widthIs(100)
    .heightIs(20);
    
    _peopleLabel = [[UILabel alloc]init];
    
    [self.contentView addSubview:_peopleLabel];
    
    _peopleLabel.sd_layout
    .leftEqualToView(_luckLabel)
    .topSpaceToView(_luckLabel,10)
    .widthIs(100)
    .heightIs(20);
    
    _timeLabel = [[UILabel alloc]init];
    
    [self.contentView addSubview:_timeLabel];
    
    _timeLabel.sd_layout
    .leftEqualToView(_peopleLabel)
    .topSpaceToView(_peopleLabel,10)
    .widthIs(100)
    .heightIs(20);
    
    
    
    

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

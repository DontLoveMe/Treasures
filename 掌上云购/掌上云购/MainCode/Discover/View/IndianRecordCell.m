//
//  IndianRecordCell.m
//  掌上云购
//
//  Created by 杨浩斌 on 16/8/23.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import "IndianRecordCell.h"
#import "UIView+SDAutoLayout.h"
@implementation IndianRecordCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self initWithUI];
    }
    
    return self;
    
}
/**
 *  @property(nonatomic,strong)UIView *backView;
 
 @property(nonatomic,strong)UIImageView *iconView;
 
 @property(nonatomic,strong)UIImageView *luckView;
 
 @property(nonatomic,strong)UILabel *goodsName;
 
 @property(nonatomic,strong)UILabel *numberLabel;
 
 @property(nonatomic,strong)UILabel *peopleLabel;
 
 @property(nonatomic,strong)UIButton *lookBtn;
 
 @property(nonatomic,strong)UILabel *winnerLabel;
 
 @property(nonatomic,strong)UILabel *passengersLabel;
 
 @property(nonatomic,strong)UIButton *buyBtn;
 */
-(void)initWithUI
{


    _backView = [[UIView alloc]init];
    
    _backView.backgroundColor = [UIColor colorWithRed:242/256.0 green:242/256.0 blue:242/256.0 alpha:1];
    
    [self.contentView addSubview:_backView];
    
    _backView.sd_layout
    .leftSpaceToView(self.contentView,0)
    .topSpaceToView(self.contentView,0)
    .widthIs(KScreenWidth)
    .heightIs(120);
    
    _iconView = [[UIImageView alloc]init];
    
    [_backView addSubview:_iconView];
    
    _iconView.sd_layout
    .leftSpaceToView(_backView,20)
    .topSpaceToView(_backView,20)
    .widthIs(70)
    .heightIs(70);
    
    
    _luckView = [[UIImageView alloc]init];
    
    [_backView addSubview:_luckView];
    
    _luckView.sd_layout
    .rightSpaceToView(_backView,15)
    .topSpaceToView(_backView,20)
    .widthIs(70)
    .heightIs(70);
    
    
    _goodsName = [[UILabel alloc]init];
    
    [_backView addSubview:_goodsName];
    
    _goodsName.sd_layout
    .leftSpaceToView(_iconView,20)
    .topSpaceToView(_backView,15)
    .widthIs(100)
    .heightIs(20);
    
    _numberLabel = [[UILabel alloc]init];
    
    [_backView addSubview:_numberLabel];
    
    _numberLabel.sd_layout
    .leftEqualToView(_goodsName)
    .topSpaceToView(_goodsName,10)
    .widthIs(100)
    .heightIs(20);
    
    _peopleLabel  = [[UILabel alloc]init];
    
    [_backView addSubview:_peopleLabel];
    
    _peopleLabel.sd_layout
    .leftEqualToView(_numberLabel)
    .topSpaceToView(_numberLabel,10)
    .widthIs(150)
    .heightIs(20);
    
    _lookBtn = [[UIButton alloc]init];
    
    [_lookBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    
    [_backView addSubview:_lookBtn];
    
    _lookBtn.sd_layout
    .leftSpaceToView(_peopleLabel,10)
    .topSpaceToView(_peopleLabel,5)
    .widthIs(80)
    .heightIs(20);
    
    _winnerLabel = [[UILabel alloc]init];
    
    [self.contentView addSubview:_winnerLabel];
    
    _winnerLabel.sd_layout
    .leftSpaceToView(self.contentView,5)
    .topSpaceToView(_backView,20)
    .widthIs(200)
    .heightIs(20);
    
    
    _buyBtn = [[UIButton alloc]init];
    
    [self.contentView addSubview:_buyBtn];
    
    _buyBtn.sd_layout
    .rightSpaceToView(self.contentView,15)
    .topSpaceToView(_backView,10)
    .widthIs(60)
    .heightIs(20);
    
    
    
    
    _passengersLabel = [[UILabel alloc]init];
    
    [self.contentView addSubview:_passengersLabel];
    
    _passengersLabel.sd_layout
    .rightSpaceToView(_buyBtn,20)
    .topEqualToView(_winnerLabel)
    .widthIs(60)
    .heightIs(20);
    
    
    
    
    
    
    
    
    
    

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

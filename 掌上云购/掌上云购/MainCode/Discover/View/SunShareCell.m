//
//  SunShareCell.m
//  掌上云购
//
//  Created by 杨浩斌 on 16/8/19.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import "SunShareCell.h"
#import "UIView+SDAutoLayout.h"
@implementation SunShareCell

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
    .leftSpaceToView(self.contentView,10)
    .topSpaceToView(self.contentView,10)
    .widthIs(60)
    .heightIs(60);
    
    
    _nameLabel = [[UILabel alloc]init];
    
    [self.contentView addSubview:_nameLabel];
    
    _nameLabel.sd_layout
    .leftSpaceToView(_iconView,10)
    .topEqualToView(_iconView)
    .widthIs(200)
    .heightIs(20);
    
    _timeLabel = [[UILabel alloc]init];
    
    [self.contentView addSubview:_timeLabel];
    
    _timeLabel.sd_layout
    .rightSpaceToView(self.contentView,5)
    .topEqualToView(_nameLabel)
    .widthIs(80)
    .heightIs(20);
    
    
    
    _dateLabel = [[UILabel alloc]init];
    
    [self.contentView addSubview:_dateLabel];
    
    _dateLabel.sd_layout
    .rightSpaceToView(_timeLabel,5)
    .topEqualToView(_timeLabel)
    .widthIs(60)
    .heightIs(20);
    
    
    _backView = [[UIImageView alloc]init];
    
   // _backView.backgroundColor = [UIColor grayColor];
  
    [self.contentView addSubview:_backView];
    
    _backView.sd_layout
    .leftEqualToView(_nameLabel)
    .topSpaceToView(_nameLabel,10)
    .rightEqualToView(_timeLabel)
    .heightIs(80);
    
    _commentLabel = [[UILabel alloc]init];
    
    [_backView addSubview:_commentLabel];
    
    _commentLabel.sd_layout
    .leftSpaceToView(_backView,5)
    .topSpaceToView(_backView,10)
    .widthIs(200)
    .heightIs(20);
    
    _goodsnameLabel = [[UILabel alloc]init];
    
    [_backView addSubview:_goodsnameLabel];
    
    _goodsnameLabel.sd_layout
    .leftEqualToView(_commentLabel)
    .topSpaceToView(_commentLabel,7)
    .widthIs(300)
    .heightIs(20);
    
    _issueLabel = [[UILabel alloc]init];
    
    [_backView addSubview:_issueLabel];
    
    _issueLabel.sd_layout
    .leftEqualToView(_goodsnameLabel)
    .topSpaceToView(_goodsnameLabel,7)
    .widthIs(300)
    .heightIs(20);
    
    
    _detailLabel = [[UILabel alloc]init];
    
    _detailLabel.numberOfLines = 0;
    
    [_backView addSubview:_detailLabel];
    
    _detailLabel.sd_layout
    .leftEqualToView(_issueLabel)
    .topSpaceToView(_issueLabel,7)
    .widthIs(300)
    .heightIs(80);
    
    _imgOne = [[UIImageView alloc]init];
    
    [_backView addSubview:_imgOne];
    
    _imgOne.sd_layout
    .leftEqualToView(_detailLabel)
    .topSpaceToView(_detailLabel,7)
    .widthIs(40)
    .heightIs(40);
    
    _imgTwo = [[UIImageView alloc]init];
    
    [_backView addSubview:_imgTwo];
    
    _imgTwo.sd_layout
    .leftSpaceToView(_imgOne,30)
    .topEqualToView(_imgOne)
    .widthIs(40)
    .heightIs(40);
    
    _imgThree = [[UIImageView alloc]init];
    
    [_backView addSubview:_imgThree];
    
    _imgThree.sd_layout
    .leftSpaceToView(_imgTwo,30)
    .topEqualToView(_imgTwo)
    .widthIs(40)
    .heightIs(40);
    
    
    
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

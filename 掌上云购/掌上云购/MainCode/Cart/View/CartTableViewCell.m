//
//  CartTableViewCell.m
//  掌上云购
//
//  Created by 杨浩斌 on 16/8/15.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import "CartTableViewCell.h"
#import "UIView+SDAutoLayout.h"
@implementation CartTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self initWithUI];
    }

    return self;
}

-(void)initWithUI
{

  
   _goodsType = [[UIImageView alloc]init];
    
    [self.contentView addSubview:_goodsType];

    _goodsType.sd_layout
    .leftSpaceToView(self.contentView,5)
    .topSpaceToView(self.contentView,5)
    .widthIs(40)
    .heightIs(40);
    

    
    _goodsImg = [[UIImageView alloc]init];
    
    [self.contentView addSubview:_goodsImg];

    _goodsImg.sd_layout
    .leftSpaceToView(self.contentView,20)
    .topSpaceToView(_goodsType,2)
    .widthIs(50)
    .heightIs(60);
    
    
    
    _goodsTitle = [[UILabel alloc]init];
    
    _goodsTitle.textColor = [UIColor blackColor];
    
    [self.contentView addSubview:_goodsTitle];

    
    _goodsTitle.sd_layout
    .leftSpaceToView(_goodsImg,10)
    .topSpaceToView(self.contentView,10)
    .widthIs(300)
    .heightIs(20);
    
    
    
    _totalNumber = [[UILabel alloc]init];
    
    [self.contentView addSubview:_totalNumber];

    
    _totalNumber.sd_layout
    .leftEqualToView(_goodsTitle)
    .topSpaceToView(_goodsTitle,10)
    .widthIs(120)
    .heightIs(20);
   
   
    
    
    _surplusNumber = [[UILabel alloc]init];
    
    [self.contentView addSubview:_surplusNumber];

    _surplusNumber.sd_layout
    .leftSpaceToView(_totalNumber,3)
    .topEqualToView(_totalNumber)
    .widthIs(100)
    .heightIs(20);
    
    
    _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    _deleteBtn.tag = 11;
    
    [self.contentView addSubview:_deleteBtn];

    
    _deleteBtn.sd_layout
    .leftEqualToView(_totalNumber)
    .topSpaceToView(_totalNumber,10)
    .heightIs(30)
    .widthIs(30);
    
    
    
    _goodsNumLab = [[UILabel alloc]init];

    _goodsNumLab.textAlignment = NSTextAlignmentCenter;
    
    [self.contentView addSubview:_goodsNumLab];
    
    _goodsNumLab.textColor = [UIColor redColor];
    
    _goodsNumLab.sd_layout
    .leftSpaceToView(_deleteBtn,10)
    .topEqualToView(_deleteBtn)
    .widthIs(50)
    .heightIs(30);
    
    
    _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [self.contentView addSubview:_addBtn];

    
    _addBtn.tag = 12;
    
    _addBtn.sd_layout
    .leftSpaceToView(_goodsNumLab,10)
    .topEqualToView(_goodsNumLab)
    .widthIs(30)
    .heightIs(30);
    
    
    _passengers = [[UILabel alloc]init];
    
    [self.contentView addSubview:_passengers];

    
    _passengers.sd_layout
    .leftSpaceToView(_addBtn,15)
    .topSpaceToView(_surplusNumber,20)
    .widthIs(40)
    .heightIs(10);
    
    
    
    _price = [[UILabel alloc]init];
    
    [self.contentView addSubview:_price];

    
    _price.textColor = [UIColor redColor];
    
    _price.sd_layout
    .leftEqualToView(_deleteBtn)
    .topSpaceToView(_deleteBtn,20)
    .widthIs(80)
    .heightIs(20);
    
    
    _isSelectImg = [[UIImageView alloc]init];
    
    [self.contentView addSubview:_isSelectImg];

    
    _isSelectImg.sd_layout
    .leftEqualToView(_goodsImg)
    .topSpaceToView(_goodsImg,10)
    .widthIs(30)
    .heightIs(30);
    
    
    
    _checkboxText = [[UILabel alloc]init];
    
    _checkboxText.sd_layout
    .leftSpaceToView(_isSelectImg,10)
    .topEqualToView(_isSelectImg)
    .widthIs(40)
    .heightIs(20);
    
    [self.contentView addSubview:_checkboxText];
    
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

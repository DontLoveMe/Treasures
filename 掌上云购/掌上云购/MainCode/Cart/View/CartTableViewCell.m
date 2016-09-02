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

-(void)initWithUI{

    //商品图片
    _goodsImg = [[UIImageView alloc]init];
    [self.contentView addSubview:_goodsImg];
    _goodsImg.sd_layout
    .leftSpaceToView(self.contentView,8)
    .topSpaceToView(self.contentView,8)
    .widthIs(64)
    .heightIs(72);
    //商品分类
    _goodsType = [[UIImageView alloc]init];
    [_goodsImg addSubview:_goodsType];
    _goodsType.sd_layout
    .leftSpaceToView(_goodsImg,0)
    .topSpaceToView(_goodsImg,0)
    .widthIs(12)
    .heightIs(12);
    //商品名
    _goodsTitle = [[UILabel alloc]init];
    _goodsTitle.textColor = [UIColor blackColor];
    _goodsTitle.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:_goodsTitle];
    _goodsTitle.sd_layout
    .leftSpaceToView(_goodsImg,8)
    .topSpaceToView(self.contentView,8)
    .rightSpaceToView(self.contentView,8)
    .heightIs(20);
    //商品总量
    _totalNumber = [[UILabel alloc]init];
    _totalNumber.textColor = [UIColor blackColor];
    _totalNumber.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:_totalNumber];
    _totalNumber.sd_layout
    .leftEqualToView(_goodsTitle)
    .topSpaceToView(_goodsTitle,4)
    .widthIs(100)
    .heightIs(20);
    //商品剩余量
    _surplusNumber = [[UILabel alloc]init];
    _surplusNumber.textColor = [UIColor blackColor];
    _surplusNumber.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:_surplusNumber];
    _surplusNumber.sd_layout
    .leftSpaceToView(_totalNumber,8)
    .topEqualToView(_totalNumber)
    .widthIs(100)
    .heightIs(20);
    //减少按钮
    _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_deleteBtn setImage:[UIImage imageNamed:@"按钮-"] forState:UIControlStateNormal];
    [_deleteBtn addTarget:self
                action:@selector(reduceAction:)
      forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_deleteBtn];
    _deleteBtn.sd_layout
    .leftEqualToView(_totalNumber)
    .topSpaceToView(_totalNumber,4)
    .heightIs(28)
    .widthIs(28);
    //选择量
    _goodsNumLab = [[UILabel alloc]init];
    _goodsNumLab.textColor = [UIColor blackColor];
    _goodsNumLab.font = [UIFont systemFontOfSize:13];
    _goodsNumLab.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_goodsNumLab];
    _goodsNumLab.textColor = [UIColor redColor];
    _goodsNumLab.sd_layout
    .leftSpaceToView(_deleteBtn,0)
    .topEqualToView(_deleteBtn)
    .widthIs(50)
    .heightIs(28);
    //增加按钮
    _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_addBtn setImage:[UIImage imageNamed:@"按钮+"] forState:UIControlStateNormal];
    [_addBtn addTarget:self
                   action:@selector(addAction:)
         forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_addBtn];
    _addBtn.tag = 12;
    _addBtn.sd_layout
    .leftSpaceToView(_goodsNumLab,0)
    .topEqualToView(_goodsNumLab)
    .widthIs(28)
    .heightIs(28);
    //单位
    _passengers = [[UILabel alloc]init];
    _passengers.text = @"人次";
    _passengers.textColor = [UIColor blackColor];
    _passengers.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:_passengers];
    _passengers.sd_layout
    .leftSpaceToView(_addBtn,15)
    .topSpaceToView(_surplusNumber,20)
    .widthIs(40)
    .heightIs(10);
    //价格
    _price = [[UILabel alloc]init];
    _price.text = @"10元/次";
    _price.textColor = [UIColor redColor];
    _price.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:_price];
    _price.sd_layout
    .leftEqualToView(_deleteBtn)
    .topSpaceToView(_deleteBtn,4)
    .widthIs(80)
    .heightIs(20);
    
}

#pragma mark - ButtonAction
- (void)addAction:(UIButton *)button{

    if ([_functionDelegate respondsToSelector:@selector(addCountAtIndexPath:)]) {
        [_functionDelegate addCountAtIndexPath:_indexPath];
    }
    
}

- (void)reduceAction:(UIButton *)button{

    if ([_functionDelegate respondsToSelector:@selector(reduceCountAtIndexPath:)]) {
        [_functionDelegate reduceCountAtIndexPath:_indexPath];
    }

}


@end

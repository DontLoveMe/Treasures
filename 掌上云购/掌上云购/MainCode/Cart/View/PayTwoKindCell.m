//
//  PayTwoKindCell.m
//  掌上云购
//
//  Created by 杨浩斌 on 16/8/17.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import "PayTwoKindCell.h"
#import "UIView+SDAutoLayout.h"
@implementation PayTwoKindCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self initWithUI];
    }
    
    return self;
    
}

-(void)initWithUI
{

    _backView = [[UIView alloc]init];
    
    [self.contentView addSubview:_backView];
    
    _backView.sd_layout
    .leftSpaceToView(self.contentView,0)
    .topSpaceToView(self.contentView,6)
    .widthIs(KScreenWidth)
    .heightIs(80);
    
    _redText = [[UILabel alloc]init];
    
    [_backView addSubview:_redText];
    
    _redText.sd_layout
    .leftSpaceToView(_backView,5)
    .topSpaceToView(_backView,25)
    .widthIs(100)
    .heightIs(20);
    
    _choiceText = [[UILabel alloc]init];
    
    [_backView addSubview:_choiceText];
    
    _choiceText.sd_layout
    .rightSpaceToView(_backView,10)
    .topSpaceToView(_backView,20)
    .widthIs(120)
    .heightIs(20);
    
    _view = [[UIView alloc]init];
        
    [_backView addSubview:_view];
    
    _view.sd_layout
    .leftSpaceToView(_backView,0)
    .topSpaceToView(_redText,25)
    .widthIs(KScreenWidth)
    .heightIs(50);
    
    _otherText = [[UILabel alloc]init];
    
    [_view addSubview:_otherText];
    
    _otherText.sd_layout
    .leftSpaceToView(_view,5)
    .topSpaceToView(_view,20)
    .widthIs(110)
    .heightIs(20);
    
    _money = [[UILabel alloc]init];
    
    [_view addSubview:_money];
    
    _money.sd_layout
    .rightSpaceToView(_view,5)
    .topSpaceToView(_view,20)
    .widthIs(50)
    .heightIs(20);
    
    
    
    

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

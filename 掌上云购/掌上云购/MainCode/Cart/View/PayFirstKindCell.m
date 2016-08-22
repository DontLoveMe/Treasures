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

-(void)initWithUI
{

   
    
    
    _view = [[UIView alloc]init];
    
    _view.backgroundColor = [UIColor whiteColor];
    
    
    [self.contentView addSubview:_view];
    
    _view.sd_layout
    .leftSpaceToView(self.contentView,0)
    .topSpaceToView(self.contentView,6)
    .widthIs(KScreenWidth)
    .heightIs(40);
    
    _goodsTotal = [[UILabel alloc]init];
    
    [_view addSubview:_goodsTotal];
    
    _goodsTotal.sd_layout
    .leftSpaceToView(_view,5)
    .topSpaceToView(_view,6)
    .widthIs(130)
    .heightIs(20);
    
    
    
    _iconView = [[UIImageView alloc]init];
    
    [_view addSubview:_iconView];
    
    _iconView.sd_layout
    .rightSpaceToView(_view,5)
    .topEqualToView(_goodsTotal)
    .widthIs(15)
    .heightIs(20);
    
    
    
 

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

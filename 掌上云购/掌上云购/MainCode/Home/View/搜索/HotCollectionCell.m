//
//  HotCollectionCell.m
//  掌上云购
//
//  Created by 刘毅 on 16/8/22.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import "HotCollectionCell.h"

@implementation HotCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    UIImage *img = [UIImage imageNamed:@"搜索标签背景"];
    img = [img stretchableImageWithLeftCapWidth:10 topCapHeight:0];
    _bgImgView.image = img;
}

@end

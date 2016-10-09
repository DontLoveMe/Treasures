//
//  LoveCell.m
//  掌上云购
//
//  Created by 刘毅 on 16/9/9.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import "LoveCell.h"

@implementation LoveCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setGsModel:(GoodsModel *)gsModel {
    _gsModel = gsModel;
    
    if (_gsModel.pictureList.count != 0) {
        
        NSDictionary *picDic = _gsModel.pictureList[0];
        NSString *imgUrl = picDic[@"img650"];
        
        if (imgUrl.length>0) {
            [_imgView setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:[UIImage imageNamed:@"未加载图片"]];
        }
    }else {
        [_imgView setImage:[UIImage imageNamed:@"未加载图片"]];
    }
    
    
    _titleLabel.text = _gsModel.name;
//    _totalLabel.text = [NSString stringWithFormat:@"总需人次：%ld",_gsModel.totalShare];
    NSInteger progress = _gsModel.sellShare*100/_gsModel.totalShare;
    _progressView.progress = progress;
    
    
    _progressLb.text = [NSString stringWithFormat:@"%ld%%",progress];
    _progressLb.textColor = [UIColor colorFromHexRGB:ThemeColor];
    
}

@end

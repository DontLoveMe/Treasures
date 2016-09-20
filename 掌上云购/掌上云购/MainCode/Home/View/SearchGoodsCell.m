//
//  SearchGoodsCell.m
//  掌上云购
//
//  Created by 刘毅 on 16/9/6.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import "SearchGoodsCell.h"

@implementation SearchGoodsCell

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
    }
    
    
    _titleLabel.text = _gsModel.name;
    _totalLabel.text = [NSString stringWithFormat:@"总需人次：%ld",_gsModel.totalShare];
    _surplusLable.text = [NSString stringWithFormat:@"剩余人次：%ld",_gsModel.surplusShare];
    
    NSInteger progress = _gsModel.sellShare*100/_gsModel.totalShare;
    _progressView.progress = progress;
    
}
- (IBAction)addToCart:(id)sender {
    
    NSMutableArray *picArr = [_gsModel.pictureList mutableCopy];
    for (int i = 0; i < picArr.count; i ++) {
        
        NSMutableDictionary *dic = [[picArr objectAtIndex:i] mutableCopy];
        for (NSInteger j = dic.allKeys.count - 1 ; j >= 0 ; j --) {
            
            if ([[dic objectForKey:dic.allKeys[j]] isEqual:[NSNull null]]) {
                
                [dic removeObjectForKey:dic.allKeys[j]];
                
            }
            
        }
        [picArr replaceObjectAtIndex:i withObject:dic];
        
    }
    
    NSDictionary *goods = @{@"id":_gsModel.ID,
                            @"name":_gsModel.name,
                            @"proPictureList":picArr,
                            @"totalShare":@(_gsModel.totalShare),
                            @"surplusShare":@(_gsModel.surplusShare),
                            @"buyTimes":[NSNumber numberWithInteger:1],
                            @"singlePrice":@(_gsModel.singlePrice)};
    
    BOOL isSuccess = [CartTools addCartList:@[goods]];
    if (isSuccess) {
        
//        if ([_delegate respondsToSelector:@selector(addToCartWithIndexpath:)]) {
//            [_delegate addToCartWithIndexpath:_nowIndexpath];
//            
//        }
    }
    NSLogZS(@"加入清单，成功了么%d",isSuccess);
    
}

@end

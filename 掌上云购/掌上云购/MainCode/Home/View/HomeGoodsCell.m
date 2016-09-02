//
//  HomeGoodsCell.m
//  掌上云购
//
//  Created by coco船长 on 16/8/15.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import "HomeGoodsCell.h"

@implementation HomeGoodsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (IBAction)addToCart:(id)sender {

    NSMutableArray *picArr = [[_dataDic objectForKey:@"proPictureList"] mutableCopy];
    for (int i = 0; i < picArr.count; i ++) {
        
        NSMutableDictionary *dic = [[picArr objectAtIndex:i] mutableCopy];
        for (NSInteger j = dic.allKeys.count - 1 ; j >= 0 ; j --) {
            
            if ([[dic objectForKey:dic.allKeys[j]] isEqual:[NSNull null]]) {
                
                [dic removeObjectForKey:dic.allKeys[j]];
                
            }
            
        }
        [picArr replaceObjectAtIndex:i withObject:dic];
        
    }
    
    NSDictionary *goods = @{@"id":[_dataDic objectForKey:@"id"],
                            @"name":[_dataDic objectForKey:@"name"],
                            @"proPictureList":picArr,
                            @"totalShare":[_dataDic objectForKey:@"totalShare"],
                            @"surplusShare":[_dataDic objectForKey:@"surplusShare"],
                            @"buyTimes":[NSNumber numberWithInteger:1]};
    //                            @"actualPrice":[_dataDic objectForKey:@"actualPrice"]
    
    BOOL isSuccess = [CartTools addCartList:@[goods]];
    if (isSuccess) {
        
        if ([_delegate respondsToSelector:@selector(addToCartWithIndexpath:)]) {
            
            [_delegate addToCartWithIndexpath:_nowIndexpath];
            
        }
    }
    NSLogZS(@"加入清单，成功了么%d",isSuccess);
    
}

@end

//
//  ProductCell.m
//  test
//
//  Created by 刘毅 on 16/7/28.
//  Copyright © 2016年 刘毅. All rights reserved.
//

#import "ProductCell.h"

@implementation ProductCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setGsModel:(GoodsModel *)gsModel {
    _gsModel = gsModel;
    NSArray *proAttrList = _gsModel.proAttrList;
    if (proAttrList != 0) {
        [_typeMarkImgView setImageWithURL:[NSURL URLWithString:[proAttrList[0] objectForKey:@"photoUrl"]]
                             placeholderImage:[UIImage new]];
    }else {
        _typeMarkImgView.image = [UIImage new];
    }
    if (_gsModel.pictureList.count != 0) {
        
        NSDictionary *picDic = _gsModel.pictureList[0];
        NSString *imgUrl = picDic[@"img650"];
        
        if (imgUrl.length>0) {
            [_productImg setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:[UIImage imageNamed:@"未加载图片"]];
        }
    }else {
        _productImg.image = [UIImage imageNamed:@"未加载图片"];
    }
    
    
    _titleLabel.text = _gsModel.name;
    _totalLabel.text = [NSString stringWithFormat:@"总需人次：%ld",_gsModel.totalShare];
    NSInteger progress = _gsModel.sellShare*100/_gsModel.totalShare;
    _progressView.progress = progress;
    
    _progressLb.text = [NSString stringWithFormat:@"%ld%%",progress];
    
}

- (IBAction)participateAction:(UIButton *)sender {
//    NSLog(@"参与");
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
        
         [self getRootController].cartNum = [CartTools getCartList].count;
        [[self viewController] showHUD:@"加入购物车成功"];
        [[self viewController] hideSuccessHUD:@"加入购物车成功"];
    
    }
    NSLogZS(@"加入清单，成功了么%d",isSuccess);
}

- (BaseViewController *)viewController {
    UIResponder *next = self.nextResponder;
    
    do {
        
        if ([next isKindOfClass:[BaseViewController class]]) {
            
            return (BaseViewController *)next;
        }
        
        next = next.nextResponder;
        
    } while (next != nil);
    
    return nil;
}

- (TabbarViewcontroller *)getRootController{
    
    UIApplication *app = [UIApplication sharedApplication];
    UIWindow *windows = app.keyWindow;
    return (TabbarViewcontroller *)windows.rootViewController;
    
}

@end

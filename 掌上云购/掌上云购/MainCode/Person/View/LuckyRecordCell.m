//
//  LuckyRecordCell.m
//  掌上云购
//
//  Created by 刘毅 on 16/8/9.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import "LuckyRecordCell.h"
#import "ConfirmDataController.h"
#import "ConfirmGoodsController.h"

@implementation LuckyRecordCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setDic:(NSDictionary *)dic {
    _dic = dic;
    _titleLabel.text = _dic[@"name"];
    if ([_dic[@"isGoods"] boolValue]) {
        if ([_dic[@"isSure"] boolValue]) {
            [_goodsButton setTitle:@"已发货" forState:UIControlStateNormal];
        }else {
            [_goodsButton setTitle:@"确认地址" forState:UIControlStateNormal];
        }
    }else {
        [_goodsButton setTitle:@"商品确认" forState:UIControlStateNormal];
 
    }
    
}
//确认收货
- (IBAction)goodsAction:(UIButton *)sender {
    if ([_dic[@"isGoods"] boolValue]) {
        
        ConfirmDataController *cdVC = [[ConfirmDataController alloc] init];
        if ([_dic[@"isSure"] boolValue]) {
            cdVC.state = 1;
        }else {
            cdVC.state = 0;
        }
        [[self viewController].navigationController pushViewController:cdVC animated:YES];
    }else {
        ConfirmGoodsController *cgVC = [[ConfirmGoodsController alloc] init];
        [[self viewController].navigationController pushViewController:cgVC animated:YES];

    }
}

- (UIViewController *)viewController {
    
    UIResponder *next = self.nextResponder;
    
    do {
        
        if ([next isKindOfClass:[UIViewController class]]) {
            
            return (UIViewController *)next;
        }
        
        next = next.nextResponder;
        
    } while (next != nil);
    
    return nil;
}

@end

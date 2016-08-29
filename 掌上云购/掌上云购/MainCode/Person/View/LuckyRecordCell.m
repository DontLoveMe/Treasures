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

- (void)setLkModel:(RecordModel *)lkModel {
    _lkModel = lkModel;
    
    _titleLabel.text = _lkModel.name;
    _issueLabel.text = [NSString stringWithFormat:@"%@",_lkModel.saleDraw.drawTimes];
    _sumLabel.text = [NSString stringWithFormat:@"%ld人次",_lkModel.saleDraw.totalShare];
    _luckyNumLabel.text = _lkModel.saleDraw.drawNumber;
    _participateLabel.text = [NSString stringWithFormat:@"%ld人次",_lkModel.saleDraw.sellShare];
    _timeLabel.text = _lkModel.saleDraw.countdownEndDate;
}

- (void)setDic:(NSDictionary *)dic {
//    _dic = dic;
//    _titleLabel.text = _dic[@"name"];
//    if ([_dic[@"isGoods"] boolValue]) {
//        if ([_dic[@"isSure"] boolValue]) {
//            [_goodsButton setTitle:@"已发货" forState:UIControlStateNormal];
//        }else {
//            [_goodsButton setTitle:@"确认地址" forState:UIControlStateNormal];
//        }
//    }else {
//        [_goodsButton setTitle:@"商品确认" forState:UIControlStateNormal];
// 
//    }
    
}
//确认收货
- (IBAction)goodsAction:(UIButton *)sender {
//    if ([_dic[@"isGoods"] boolValue]) {
//        
//        ConfirmDataController *cdVC = [[ConfirmDataController alloc] init];
//        if ([_dic[@"isSure"] boolValue]) {
//            cdVC.state = 1;
//        }else {
//            cdVC.state = 0;
//        }
//        [[self viewController].navigationController pushViewController:cdVC animated:YES];
//    }else {
//        ConfirmGoodsController *cgVC = [[ConfirmGoodsController alloc] init];
//        [[self viewController].navigationController pushViewController:cgVC animated:YES];
//
//    }
    [self confirmAddress];
}

- (void)confirmAddress {
    //取出存储的用户信息
    //    NSDictionary *userDic = [[NSUserDefaults standardUserDefaults] objectForKey:@"userDic"];
    //    NSNumber *userId = userDic[@"userId"];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:@2 forKey:@"buyUserId"];
    [params setObject:_lkModel.ID forKey:@"productId"];
    [params setObject:@(_lkModel.saleDraw.periodsNumber) forKey:@"buyPeriods"];
    
    NSString *url = [NSString stringWithFormat:@"%@%@",BASE_URL,ConfirmAddress_URL];
    [ZSTools post:url
           params:params
          success:^(id json) {
              
              BOOL isSuccess = [[json objectForKey:@"flag"] boolValue];
              
              if (isSuccess) {
                 
              }
              
              
          } failure:^(NSError *error) {
              
              
              NSLogZS(@"%@",error);
          }];
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

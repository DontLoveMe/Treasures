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
    
    Propicturelist *plist = _lkModel.proPictureList[0];
    
    NSURL *url = [NSURL URLWithString:plist.img650];
    [_imgView setImageWithURL:url placeholderImage:[UIImage imageNamed:@"揭晓-图片.jpg"]];
    
    _titleLabel.text = _lkModel.name;
    _issueLabel.text = [NSString stringWithFormat:@"%@",_lkModel.saleDraw.drawTimes];
    _sumLabel.text = [NSString stringWithFormat:@"%ld人次",_lkModel.saleDraw.totalShare];
    _luckyNumLabel.text = _lkModel.saleDraw.drawTimes;
    _participateLabel.text = [NSString stringWithFormat:@"%ld人次",_lkModel.saleDraw.sellShare];
    _timeLabel.text = _lkModel.saleDraw.drawDate;
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
    self.suerBlock();
    
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

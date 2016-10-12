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
#import "AddShareController.h"

@implementation LuckyRecordCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setLkModel:(RecordModel *)lkModel {
    _lkModel = lkModel;
    
    NSArray *pArr = _lkModel.proPictureList;
    if (pArr.count>0) {
        Propicturelist *prtLs = pArr[0];
        NSURL *url = [NSURL URLWithString:prtLs.img650];
        [_imgView setImageWithURL:url placeholderImage:[UIImage imageNamed:@"未加载图片"]];
    }
    
//    NSURL *url = [NSURL URLWithString:plist.img650];
//    [_imgView setImageWithURL:url placeholderImage:[UIImage imageNamed:@"揭晓-图片.jpg"]];
    
    _titleLabel.text = _lkModel.name;
    _issueLabel.text = [NSString stringWithFormat:@"%@",_lkModel.saleDraw.drawTimes];
    _sumLabel.text = [NSString stringWithFormat:@"%ld人次",_lkModel.saleDraw.totalShare];
    _luckyNumLabel.text = _lkModel.saleDraw.drawNumber;
    _participateLabel.text = [NSString stringWithFormat:@"%ld人次",_lkModel.partakeCount];
    _timeLabel.text = [TimeFormat getNewTimeString:_lkModel.saleDraw.drawDate];
    

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
- (IBAction)isSunAction:(UIButton *)sender {
    
    NSInteger orderStatus = [_lkModel.orderStatus integerValue];
    if (orderStatus == 3) {
        
        AddShareController *asVC = [[AddShareController alloc] init];
        asVC.lkModel = _lkModel;
        [[self viewController].navigationController pushViewController:asVC animated:YES];
    }else {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示"
                                                                                 message:@"请确认收货！" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"好"
                                                               style:UIAlertActionStyleCancel
                                                             handler:^(UIAlertAction * _Nonnull action) {
                                                                 [alertController dismissViewControllerAnimated:YES
                                                                                                     completion:nil];
                                                             }];
        [alertController addAction:cancelAction];
        [[self viewController] presentViewController:alertController
                           animated:YES
                         completion:nil];
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

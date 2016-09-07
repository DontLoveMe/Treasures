//
//  GoodsStateCell.h
//  掌上云购
//
//  Created by 刘毅 on 16/8/19.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GoodsStateCellDelegate <NSObject>

@optional
- (void)clickButtonBackTag:(NSInteger)tag;

@end

@interface GoodsStateCell : UITableViewCell
/* 1获得商品2确认收货地址3商品派发4确认收货5已签收*/
@property (weak, nonatomic) IBOutlet UIImageView *stateView1;
@property (weak, nonatomic) IBOutlet UIImageView *stateView2;
@property (weak, nonatomic) IBOutlet UIImageView *stateView3;
@property (weak, nonatomic) IBOutlet UIImageView *stateView4;
@property (weak, nonatomic) IBOutlet UIImageView *stateView5;

@property (weak, nonatomic) IBOutlet UILabel *stateLabel1;
@property (weak, nonatomic) IBOutlet UILabel *stateLabel2;
@property (weak, nonatomic) IBOutlet UILabel *stateLabel3;
@property (weak, nonatomic) IBOutlet UILabel *stateLabel4;
@property (weak, nonatomic) IBOutlet UILabel *stateLabel5;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel1;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel2;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel3;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel4;

@property (weak, nonatomic) IBOutlet UIButton *shareBtn;//立即晒单
@property (weak, nonatomic) IBOutlet UIButton *sureAddress;//确认地址
@property (weak, nonatomic) IBOutlet UIButton *selectAddress;//选择地址
@property (weak, nonatomic) IBOutlet UIButton *delayReceipt;//延期收货
@property (weak, nonatomic) IBOutlet UIButton *sureReceipt;//确认收货

@property (nonatomic,weak)id<GoodsStateCellDelegate> delegate;

@end

//
//  PersonHeaderView.h
//  掌上云购
//
//  Created by 刘毅 on 16/8/29.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonHeaderView : UICollectionReusableView

//@property (weak, nonatomic) IBOutlet UIImageView *bgIconView;
@property (weak, nonatomic) IBOutlet UIImageView *iconView;//头像
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;//名字
@property (weak, nonatomic) IBOutlet UIButton *balanceButton;//余额
@property (weak, nonatomic) IBOutlet UIButton *rechargeButton;//充值
@property (weak, nonatomic) IBOutlet UIButton *integralButton;//积分

@end

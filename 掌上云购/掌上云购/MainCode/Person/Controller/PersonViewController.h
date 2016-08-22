//
//  PersonViewController.h
//  掌上云购
//
//  Created by coco船长 on 16/8/3.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import "BaseViewController.h"

@interface PersonViewController : BaseViewController<UICollectionViewDelegate,UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UIImageView *iconView;//头像
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;//名字
@property (weak, nonatomic) IBOutlet UIButton *balanceButton;//余额
@property (weak, nonatomic) IBOutlet UIButton *rechargeButton;//充值
@property (weak, nonatomic) IBOutlet UIButton *integralButton;//积分

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;



@end

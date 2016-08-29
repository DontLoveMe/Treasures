//
//  RechargeRecordCell.h
//  掌上云购
//
//  Created by 刘毅 on 16/8/17.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RechargeModel.h"

@interface RechargeRecordCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *rechargeType;
@property (weak, nonatomic) IBOutlet UILabel *openingTime;

@property (weak, nonatomic) IBOutlet UILabel *feeLabel;

@property (nonatomic,strong) RechargeModel *raModel;
@end

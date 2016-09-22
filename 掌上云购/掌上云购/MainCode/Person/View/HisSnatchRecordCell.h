//
//  HisSnatchRecordCell.h
//  掌上云购
//
//  Created by 刘毅 on 16/9/22.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecordModel.h"

@interface HisSnatchRecordCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;//标题
@property (weak, nonatomic) IBOutlet UILabel *userIDLb;

@property (weak, nonatomic) IBOutlet UILabel *issueLabel;//期号
@property (weak, nonatomic) IBOutlet UILabel *peopleNum;//参与

@property (weak, nonatomic) IBOutlet UIButton *detailButton;//查看详情

@property (weak, nonatomic) IBOutlet UILabel *getName;//获得者
@property (weak, nonatomic) IBOutlet UILabel *getPeopleN;//获得者参与人次
@property (weak, nonatomic) IBOutlet UILabel *drowTImeLb;

@property (weak, nonatomic) IBOutlet UIButton *againButton;

@property (nonatomic, strong) RecordModel *rcModel;
@end

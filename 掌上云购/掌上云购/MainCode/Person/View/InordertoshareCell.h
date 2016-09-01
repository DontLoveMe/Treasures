//
//  InordertoshareCell.h
//  掌上云购
//
//  Created by 刘毅 on 16/8/15.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InordertoshareModel.h"

@interface InordertoshareCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *iconButton;//头像按钮
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;//昵称
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;//日期
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;//标题
@property (weak, nonatomic) IBOutlet UILabel *productNameLabel;//物品名称
@property (weak, nonatomic) IBOutlet UILabel *drawTimesLabel;//期号
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;//内容

@property (nonatomic, strong)InordertoshareModel *iSModel;


@end

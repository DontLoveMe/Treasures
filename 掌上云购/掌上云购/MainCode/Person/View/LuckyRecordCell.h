//
//  LuckyRecordCell.h
//  掌上云购
//
//  Created by 刘毅 on 16/8/9.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecordModel.h"

@interface LuckyRecordCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imgView;//图片
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;//标题
@property (weak, nonatomic) IBOutlet UILabel *issueLabel;//期号
@property (weak, nonatomic) IBOutlet UILabel *sumLabel;//总需
@property (weak, nonatomic) IBOutlet UILabel *luckyNumLabel;//幸运号
@property (weak, nonatomic) IBOutlet UILabel *participateLabel;//本期参与

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIButton *goodsButton;//按钮

@property (nonatomic ,strong)RecordModel *lkModel;

@end

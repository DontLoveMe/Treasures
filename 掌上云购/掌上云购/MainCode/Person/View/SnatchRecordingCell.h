//
//  SnatchRecordingCell.h
//  掌上云购
//
//  Created by 刘毅 on 16/8/24.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecordModel.h"
#import "ProgressView.h"

@interface SnatchRecordingCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;//图片
@property (weak, nonatomic) IBOutlet UILabel *issueLabel;//期号
@property (weak, nonatomic) IBOutlet UILabel *sumLabel;//总需
@property (weak, nonatomic) IBOutlet UILabel *surplusLabel;
@property (weak, nonatomic) IBOutlet UILabel *participateLabel;//本期参与
@property (weak, nonatomic) IBOutlet UILabel *progressLabel;
@property (weak, nonatomic) IBOutlet ProgressView *progressView;

@property (nonatomic, strong) RecordModel *rcModel;

@end

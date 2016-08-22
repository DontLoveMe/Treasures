//
//  UseRedCell.h
//  掌上云购
//
//  Created by 刘毅 on 16/8/16.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UseRedCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *redImgView;
@property (weak, nonatomic) IBOutlet UILabel *stateLabel;//状态（可用，过期）
@property (weak, nonatomic) IBOutlet UILabel *sourceLabel;//红包来源
@property (weak, nonatomic) IBOutlet UILabel *beginTimeLb;//生效日期
@property (weak, nonatomic) IBOutlet UILabel *endLabel;//有效期至
@property (weak, nonatomic) IBOutlet UILabel *conditionLabel;//使用条件

@end

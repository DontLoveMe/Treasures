//
//  BroughtHistoryCell.h
//  掌上云购
//
//  Created by coco船长 on 16/8/18.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HisIconImageView.h"
@interface BroughtHistoryCell : UITableViewCell

@property (weak, nonatomic) IBOutlet HisIconImageView *headPic;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *joinTimes;
@property (weak, nonatomic) IBOutlet UILabel *userIP;

@end

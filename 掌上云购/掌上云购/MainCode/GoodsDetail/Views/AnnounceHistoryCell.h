//
//  AnnounceHistoryCell.h
//  掌上云购
//
//  Created by coco船长 on 16/8/18.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AnnounceHistoryCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UILabel *goodsMsgLabel;
@property (weak, nonatomic) IBOutlet UIImageView *picImgView;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *userId;
@property (weak, nonatomic) IBOutlet UILabel *luckyNum;
@property (weak, nonatomic) IBOutlet UILabel *joinTimes;

@end

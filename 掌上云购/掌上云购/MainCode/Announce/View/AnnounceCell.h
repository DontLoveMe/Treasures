//
//  AnnounceCell.h
//  掌上云购
//
//  Created by 刘毅 on 16/8/8.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CountDown.h"

@interface AnnounceCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *timeIconView;
@property (weak, nonatomic) IBOutlet UILabel *unveilLabel;
@property (weak, nonatomic) IBOutlet UILabel *getUserLabel;
@property (weak, nonatomic) IBOutlet UILabel *peopleNumLb;
@property (weak, nonatomic) IBOutlet UILabel *luckyLabel;
@property (weak, nonatomic) IBOutlet UILabel *announceTimeLb;

@property (strong, nonatomic)  CountDown *countDown;

@property (nonatomic,copy) NSString *str;

@end

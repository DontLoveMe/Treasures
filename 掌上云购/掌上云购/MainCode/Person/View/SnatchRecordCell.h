//
//  SnatchRecordCell.h
//  掌上云购
//
//  Created by 刘毅 on 16/8/9.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SnatchRecordCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imgView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *issueLabel;
@property (weak, nonatomic) IBOutlet UILabel *peopleNum;

@property (weak, nonatomic) IBOutlet UIButton *detailButton;

@property (weak, nonatomic) IBOutlet UILabel *getName;
@property (weak, nonatomic) IBOutlet UILabel *getPeopleN;

@property (weak, nonatomic) IBOutlet UIButton *againButton;



@end

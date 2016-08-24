//
//  AddressCell.h
//  掌上云购
//
//  Created by 刘毅 on 16/8/17.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AddressModel;
@interface AddressCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;//姓名
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;//电话
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;//地址
@property (weak, nonatomic) IBOutlet UIButton *defaultButton;//默认
@property (weak, nonatomic) IBOutlet UIButton *setDfaultBtn;
@property (nonatomic,strong) AddressModel *model;

@property (nonatomic,copy)void(^selectDefault)(UIButton *);

@end

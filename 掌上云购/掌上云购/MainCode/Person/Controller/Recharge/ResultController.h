//
//  RechargeResultController.h
//  掌上云购
//
//  Created by 刘毅 on 16/9/18.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import "BaseViewController.h"

@interface ResultController : BaseViewController


@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIButton *snatchBtn;
@property (weak, nonatomic) IBOutlet UIButton *lookListBtn;

@property (nonatomic,copy)void(^clickBlock)(NSInteger tag);

@end

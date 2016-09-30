//
//  PromptController.h
//  掌上云购
//
//  Created by 刘毅 on 16/9/24.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import "BaseViewController.h"

@interface PromptController : BaseViewController

@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleWidth;

@property (nonatomic,assign)NSInteger tabbarIndex;
//0 ：红包 1 ：中奖
@property (nonatomic,assign)NSInteger type;
@end

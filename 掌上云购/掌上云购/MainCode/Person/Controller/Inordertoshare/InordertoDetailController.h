//
//  InordertoDetailController.h
//  掌上云购
//
//  Created by 刘毅 on 16/8/15.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import "BaseViewController.h"

@interface InordertoDetailController : BaseViewController

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (nonatomic, assign)NSInteger shareID;
@property (nonatomic,assign)NSInteger buyUserId;
@end

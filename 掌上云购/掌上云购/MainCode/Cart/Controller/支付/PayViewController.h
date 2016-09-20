//
//  PayViewController.h
//  掌上云购
//
//  Created by 杨浩斌 on 16/8/16.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import "BaseViewController.h"

@interface PayViewController : BaseViewController

//是否直接购买(1-购物车，2直接购买)
@property (nonatomic,copy)NSString *isimidiately;

@property (nonatomic,copy)NSArray *immidiatelyArr;


@end

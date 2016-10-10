//
//  PayViewController.h
//  掌上云购
//
//  Created by 杨浩斌 on 16/8/16.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import "BaseViewController.h"

#import "RedEnvelopeController.h"

@interface PayViewController : BaseViewController<RedEnveloperDelegate>{

    //红包减价金额
    NSInteger   _redEnveloperReduceCount;
    //红包id
    NSString    *_redEnveloperID;
    //是否选择第三方支付
    NSArray     *_thirdPayState;
    //是否使用余额支付
    NSInteger   _isBalance;

}

//是否直接购买(1-购物车，2直接购买)
@property (nonatomic,copy)NSString *isimidiately;

@property (nonatomic,copy)NSArray *immidiatelyArr;


@end

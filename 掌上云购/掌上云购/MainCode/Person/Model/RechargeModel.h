//
//  RechargeModel.h
//  掌上云购
//
//  Created by 刘毅 on 16/8/29.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RechargeModel : NSObject

@property (nonatomic, copy) NSString *delFlag;

@property (nonatomic, copy) NSString *mobile;

@property (nonatomic, assign) long long openingTime;

@property (nonatomic, copy) NSString *fee;

@property (nonatomic, copy) NSString *serialNo;

@property (nonatomic, copy) NSString *endDate;

@property (nonatomic, copy) NSString *userId;

@property (nonatomic, copy) NSString *nickName;

@property (nonatomic, copy) NSString *beginDate;

@property (nonatomic, copy) NSString *rechargeType;

@property (nonatomic, copy) NSString *userAccount;

@property (nonatomic, copy) NSString *virtualMoney;

@property (nonatomic, copy) NSString *status;

@end

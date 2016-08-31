//
//  RedEnvelopeModel.h
//  掌上云购
//
//  Created by 刘毅 on 16/8/31.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RedEnvelopeModel : NSObject

@property (nonatomic, copy) NSString *effectiveStartDate;

@property (nonatomic, copy) NSString *effectiveEndDate;

@property (nonatomic, assign) NSInteger redNumber;

@property (nonatomic, copy) NSString *status;

@property (nonatomic, assign) NSInteger amount;

@property (nonatomic, copy) NSString *releaseDate;

@property (nonatomic, assign) NSInteger redResidualNumber;

@property (nonatomic, copy) NSString *updateDate;

@property (nonatomic, copy) NSString *activityType;

@property (nonatomic, assign) NSInteger consumeAmount;

@property (nonatomic, copy) NSString *delFlag;

@property (nonatomic, copy) NSString *type;

@property (nonatomic, copy) NSString *useDate;

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, copy) NSString *orderNo;

@property (nonatomic, copy) NSString *releaseStatus;

@property (nonatomic, assign) NSInteger createBy;

@property (nonatomic, assign) NSInteger updateBy;

@property (nonatomic, copy) NSString *activityName;

@property (nonatomic, assign) NSInteger redActivityId;

@property (nonatomic, copy) NSString *remarks;

@property (nonatomic, copy) NSString *createDate;

@property (nonatomic, assign) NSInteger userId;

@end

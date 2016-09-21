//
//  InordertoshareModel.h
//  掌上云购
//
//  Created by 刘毅 on 16/9/1.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InordertoshareModel : NSObject

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, assign) NSInteger productId;

@property (nonatomic, copy) NSString *createBy;

@property (nonatomic, assign) NSInteger delFlag;

@property (nonatomic, copy) NSString *updateBy;

@property (nonatomic, copy) NSString *createDate;

@property (nonatomic, copy) NSString *productName;

@property (nonatomic, assign) NSInteger buyUserId;

@property (nonatomic, strong) NSArray<NSString *> *photoUrllist;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *updateDate;

@property (nonatomic, assign) NSInteger saleOrderDetailId;

@property (nonatomic, copy) NSString *photoUrl;

@property (nonatomic, copy) NSString *userPhotoUrl;

@property (nonatomic, copy) NSString *nickName;

@property (nonatomic, copy) NSString *drawTimes;

@property (nonatomic, assign) NSInteger status;

@property (nonatomic, copy) NSString *content;

@property (nonatomic, copy) NSString *buyTimes;

@property (nonatomic, copy) NSString *drawDate;

@property (nonatomic, copy) NSString *drawNumber;

@end

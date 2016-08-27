//
//  LuckyModel.h
//  掌上云购
//
//  Created by 刘毅 on 16/8/27.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Saledraw,Propicturelist;
@interface LuckyModel : NSObject

@property (nonatomic, copy) NSString *surplusShare;

@property (nonatomic, copy) NSString *sellShare;

@property (nonatomic, copy) NSString *totalShare;

@property (nonatomic, assign) NSInteger status;

@property (nonatomic, copy) NSString *expirationDate;

@property (nonatomic, assign) NSInteger isBuy;

@property (nonatomic, copy) NSString *countdownEndDate;

@property (nonatomic, copy) NSString *detailHtml;

@property (nonatomic, strong) Saledraw *saleDraw;

@property (nonatomic, copy) NSString *limitShare;

@property (nonatomic, copy) NSString *buyNumbers;

@property (nonatomic, strong) NSNumber *companyId;

@property (nonatomic, copy) NSString *isSunOrder;

@property (nonatomic, copy) NSString *isMany;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *isSyncShop;

@property (nonatomic, copy) NSString *proNumber;

@property (nonatomic, strong) NSNumber *drawId;

@property (nonatomic, strong) NSNumber *brandId;

@property (nonatomic, strong) NSNumber *ID;

@property (nonatomic, copy) NSString *createBy;

@property (nonatomic, strong) NSArray *proAttrList;

@property (nonatomic, copy) NSString *unit;

@property (nonatomic, copy) NSString *salePrice;

@property (nonatomic, copy) NSString *checkStatus;

@property (nonatomic, copy) NSString *actualPrice;

@property (nonatomic, copy) NSString *remarks;

@property (nonatomic, strong) NSArray<Propicturelist *> *proPictureList;

@property (nonatomic, copy) NSString *isSpeed;

@property (nonatomic, strong) NSNumber *categoryId;

@property (nonatomic, copy) NSString *singlePrice;

@end

@interface Saledraw : NSObject

@property (nonatomic, copy) NSString *productName;

@property (nonatomic, copy) NSString *photoUrl;

@property (nonatomic, assign) NSInteger totalShare;

@property (nonatomic, assign) NSInteger status;

@property (nonatomic, copy) NSString *nickName;

@property (nonatomic, copy) NSString *buyIpAddress;

@property (nonatomic, copy) NSString *updateDate;

@property (nonatomic, strong) NSNumber *productId;

@property (nonatomic, strong) NSNumber *drawId;

@property (nonatomic, copy) NSString *drawTimes;

@property (nonatomic, strong) NSNumber *orderDetailId;

@property (nonatomic, strong) NSNumber *ID;

@property (nonatomic, copy) NSString *countdownStartDate;

@property (nonatomic, copy) NSString *buyIp;

@property (nonatomic, copy) NSString *createBy;

@property (nonatomic, copy) NSString *updateBy;

@property (nonatomic, assign) NSInteger periodsNumber;

@property (nonatomic, copy) NSString *qty;

@property (nonatomic, copy) NSString *countdownEndDate;

@property (nonatomic, copy) NSString *drawDate;

@property (nonatomic, assign) NSInteger sellShare;

@property (nonatomic, strong) NSNumber *drawUserId;

@property (nonatomic, assign) NSInteger surplusShare;

@property (nonatomic, copy) NSString *drawNumber;

@property (nonatomic, copy) NSString *createDate;

@end

@interface Propicturelist : NSObject

@property (nonatomic, copy) NSString *img60;

@property (nonatomic, copy) NSString *img650;

@property (nonatomic, copy) NSString *img170;

@property (nonatomic, copy) NSString *img120;

@property (nonatomic, copy) NSString *img400;

@end


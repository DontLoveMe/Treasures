//
//  LuckyModel.h
//  掌上云购
//
//  Created by 刘毅 on 16/8/27.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Saledraw,Propicturelist,Proattrlist;
@interface RecordModel : NSObject


@property (nonatomic, copy) NSString *categoryId;

@property (nonatomic, copy) NSString *proNumber;

@property (nonatomic, copy) NSString *ID;

@property (nonatomic, strong) Saledraw *saleDraw;

@property (nonatomic, copy) NSString *surplusShare;

@property (nonatomic, copy) NSString *countdownStartDate;

@property (nonatomic, copy) NSString *salePrice;

@property (nonatomic, copy) NSString *isMany;

@property (nonatomic, copy) NSString *singlePrice;

@property (nonatomic, copy) NSString *expirationDate;

@property (nonatomic, copy) NSString *orderStatus;

@property (nonatomic, copy) NSString *unit;

@property (nonatomic, copy) NSString *drawId;

@property (nonatomic, strong) NSArray<Propicturelist *> *proPictureList;

@property (nonatomic, copy) NSString *commentStatus;

@property (nonatomic, assign) NSInteger winnersPartakeCount;

@property (nonatomic, copy) NSString *actualPrice;

@property (nonatomic, copy) NSString *isSpeed;

@property (nonatomic, copy) NSString *detailHtml;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *remarks;

@property (nonatomic, copy) NSString *totalShare;

@property (nonatomic, strong) NSArray<Proattrlist *> *proAttrList;

@property (nonatomic, copy) NSString *createBy;

@property (nonatomic, assign) NSInteger status;

@property (nonatomic, copy) NSString *companyId;

@property (nonatomic, copy) NSString *sellShare;

@property (nonatomic, copy) NSString *buyNumbers;

@property (nonatomic, assign) NSInteger orderDetailId;

@property (nonatomic, copy) NSString *limitShare;

@property (nonatomic, copy) NSString *isLimit;

@property (nonatomic, assign) NSInteger isBuy;

@property (nonatomic, copy) NSString *isSyncShop;

@property (nonatomic, copy) NSString *brandId;

@property (nonatomic, copy) NSString *periodsNumber;

@property (nonatomic, copy) NSString *isVirtualgoods;

@property (nonatomic, copy) NSString *checkStatus;

@property (nonatomic, copy) NSString *countdownEndDate;

@property (nonatomic, copy) NSString *drawTimes;

@property (nonatomic, assign) NSInteger isSunOrder;

@property (nonatomic, assign) NSInteger sunOrder;

@property (nonatomic, assign) NSInteger partakeCount;

@property (nonatomic, copy) NSString *imgUrl;

@property (nonatomic, copy) NSString *orderDrawStatus;

@property (nonatomic, assign) NSInteger proStatus;

@property (nonatomic,assign) NSInteger proNumberStatus;

@end

@interface Saledraw : NSObject

@property (nonatomic, copy) NSString *productName;

@property (nonatomic, copy) NSString *photoUrl;

@property (nonatomic, assign) NSInteger totalShare;

@property (nonatomic, assign) NSInteger status;

@property (nonatomic, copy) NSString *nickName;

@property (nonatomic, copy) NSString *lockTime;

@property (nonatomic, copy) NSString *buyIpAddress;

@property (nonatomic, copy) NSString *updateDate;

@property (nonatomic, copy) NSString *productId;

@property (nonatomic, assign) NSInteger drawId;

@property (nonatomic, copy) NSString *lockUserId;

@property (nonatomic, copy) NSString *drawTimes;

@property (nonatomic, copy) NSString *orderDetailId;

@property (nonatomic, assign) NSInteger partakeCount;

@property (nonatomic, copy) NSString *ID;

@property (nonatomic, copy) NSString *countdownStartDate;

@property (nonatomic, copy) NSString *buyIp;

@property (nonatomic, copy) NSString *createBy;

@property (nonatomic, copy) NSString *updateBy;

@property (nonatomic, assign) NSInteger periodsNumber;

@property (nonatomic, copy) NSString *qty;

@property (nonatomic, copy) NSString *isLocked;

@property (nonatomic, copy) NSString *countdownEndDate;

@property (nonatomic, copy) NSString *drawDate;

@property (nonatomic, assign) NSInteger sellShare;

@property (nonatomic, copy) NSString *drawUserId;

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

@interface Proattrlist : NSObject

@property (nonatomic, copy) NSString *attrValue;

@end


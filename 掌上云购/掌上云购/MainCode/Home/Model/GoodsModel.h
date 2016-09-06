//
//  GoodsModel.h
//  掌上云购
//
//  Created by 刘毅 on 16/9/6.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Proattrlist;
@interface GoodsModel : NSObject

@property (nonatomic, copy) NSString *categoryId;

@property (nonatomic, copy) NSString *proNumber;

@property (nonatomic, copy) NSString *ID;

@property (nonatomic, copy) NSString *saleDraw;

@property (nonatomic, assign) NSInteger surplusShare;

@property (nonatomic, copy) NSString *countdownStartDate;

@property (nonatomic, copy) NSString *salePrice;

@property (nonatomic, copy) NSString *isMany;

@property (nonatomic, assign) NSInteger singlePrice;

@property (nonatomic, copy) NSString *expirationDate;

@property (nonatomic, copy) NSString *unit;

@property (nonatomic, copy) NSString *drawId;

@property (nonatomic, strong) NSArray<NSDictionary *> *pictureList;

@property (nonatomic, copy) NSString *actualPrice;

@property (nonatomic, copy) NSString *isSpeed;

@property (nonatomic, copy) NSString *detailHtml;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *remarks;

@property (nonatomic, assign) NSInteger totalShare;

@property (nonatomic, strong) NSArray<Proattrlist *> *proAttrList;

@property (nonatomic, copy) NSString *createBy;

@property (nonatomic, assign) NSInteger status;

@property (nonatomic, copy) NSString *companyId;

@property (nonatomic, assign) NSInteger sellShare;

@property (nonatomic, copy) NSString *buyNumbers;

@property (nonatomic, assign) NSInteger limitShare;

@property (nonatomic, assign) NSInteger isLimit;

@property (nonatomic, assign) NSInteger isBuy;

@property (nonatomic, copy) NSString *isSyncShop;

@property (nonatomic, copy) NSString *brandId;

@property (nonatomic, copy) NSString *periodsNumber;

@property (nonatomic, copy) NSString *checkStatus;

@property (nonatomic, copy) NSString *countdownEndDate;

@property (nonatomic, copy) NSString *drawTimes;

@property (nonatomic, copy) NSString *isSunOrder;

@property (nonatomic, copy) NSString *sunOrder;

@property (nonatomic, copy) NSString *imgUrl;

@end

@interface Proattrlist : NSObject

@property (nonatomic, copy) NSString *attrValue;

@end


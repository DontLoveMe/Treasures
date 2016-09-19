//
//  AddressModel.h
//  掌上云购
//
//  Created by 刘毅 on 16/8/18.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddressModel : NSObject

/* "id": 1,
 "userId": 1,
 "addressDetail": "Jiedao258",
 "addressDetailFull": "变河北101号",
 "receiver": "李四",
 "zipCode": "410005",
 "mobile": "18073120368",
 "isDefault": "0",
 "province": {
 "id": "1",
 "name": "中国"
 },
 "city": {
 "id": "1",
 "name": "中国"
 },
 "area": {
 "id": "1",
 "name": "中国"
 }
 },
 */
@property (nonatomic,strong)NSNumber *addressId;
@property (nonatomic,strong)NSNumber *userId;
@property (nonatomic,strong)NSNumber *zipCode;
@property (nonatomic,strong)NSNumber *mobile;
@property (nonatomic,strong)NSNumber *isDefault;
@property (nonatomic,copy)NSString *addressDetailFull;
@property (nonatomic,copy)NSString *addressDetail;
@property (nonatomic,copy)NSString *receiver;
@property (nonatomic,strong)NSDictionary *province;
@property (nonatomic,strong)NSDictionary *city;
@property (nonatomic,strong)NSDictionary *area;

@end

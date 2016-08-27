//
//  AddressModel.m
//  掌上云购
//
//  Created by 刘毅 on 16/8/18.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import "AddressModel.h"

@implementation AddressModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"addressId" : @"id",
             };
}

@end

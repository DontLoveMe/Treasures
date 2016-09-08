//
//  GoodsModel.m
//  掌上云购
//
//  Created by 刘毅 on 16/9/6.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import "GoodsModel.h"

@implementation GoodsModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"ID" : @"id",
             @"pictureList":@"proPictureList"};
}

@end





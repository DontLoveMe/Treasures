//
//  LuckyModel.m
//  掌上云购
//
//  Created by 刘毅 on 16/8/27.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import "RecordModel.h"

@implementation RecordModel


+ (NSDictionary *)objectClassInArray{
    return @{@"proPictureList" : [Propicturelist class]};
}
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"ID":@"id"};
}
@end
@implementation Saledraw
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"ID":@"id"};
}

@end


@implementation Propicturelist

@end






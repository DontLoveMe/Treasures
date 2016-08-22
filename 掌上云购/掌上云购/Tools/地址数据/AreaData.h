//
//  AreaData.h
//  test
//
//  Created by 刘毅 on 16/8/18.
//  Copyright © 2016年 刘毅. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AreaData : NSObject

@property (nonatomic,strong) NSArray *data;

+ (NSArray *)getProvinces;

+ (NSArray *)getCitys:(NSNumber *)parentId;

+ (NSArray *)getAreas:(NSNumber *)parentId;

@end

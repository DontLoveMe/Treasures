//
//  AreaData.m
//  test
//
//  Created by 刘毅 on 16/8/18.
//  Copyright © 2016年 刘毅. All rights reserved.
//

#import "AreaData.h"

@implementation AreaData



+ (NSArray *)getProvinces {
    NSMutableArray *provinces = @[].mutableCopy;
    
    NSString *path = [[NSBundle mainBundle]pathForResource:@"areaData" ofType:@"plist"];
    NSArray *data = [[[NSDictionary alloc]initWithContentsOfFile:path] objectForKey:@"data"];
    
    for (NSDictionary *dic in data) {
        if ([dic[@"parentId"] integerValue] == 0) {
            [provinces addObject:dic];
        }
    }
    NSArray *province = provinces;
 
    return province;
}

+ (NSArray *)getCitys:(NSNumber *)parentId {
    NSMutableArray *citys = @[].mutableCopy;
    
    NSString *path = [[NSBundle mainBundle]pathForResource:@"areaData" ofType:@"plist"];
    NSArray *data = [[[NSDictionary alloc]initWithContentsOfFile:path] objectForKey:@"data"];
    
    for (NSDictionary *dic in data) {
        if ([dic[@"parentId"] integerValue] == [parentId integerValue]) {
            [citys addObject:dic];
        }
    }
    NSArray *city = citys;
    
    return city;
}

+ (NSArray *)getAreas:(NSNumber *)parentId {
    NSMutableArray *areas = @[].mutableCopy;
    
    NSString *path = [[NSBundle mainBundle]pathForResource:@"areaData" ofType:@"plist"];
    NSArray *data = [[[NSDictionary alloc]initWithContentsOfFile:path] objectForKey:@"data"];
    
    for (NSDictionary *dic in data) {
        if ([dic[@"parentId"] integerValue] == [parentId integerValue]|| [dic[@"parentId"] integerValue] == [parentId integerValue]+1){
            [areas addObject:dic];
        }
    }
    NSArray *area = areas;
    
    return area;
}


@end

//
//  HistoryData.m
//  掌上云购
//
//  Created by 刘毅 on 16/8/22.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import "HistoryData.h"

@implementation HistoryData

+ (NSArray *)getHistoryData {
    
    NSArray *dataArr = [[NSUserDefaults standardUserDefaults] objectForKey:@"HistoryData"];
    return dataArr;
    
}

+ (void)addHistoryData:(NSString *)historyStr {
    NSMutableArray *dataArr = [NSMutableArray array];

    if ([self getHistoryData].count > 0) {
        dataArr = [self getHistoryData].mutableCopy;
        if ([historyStr isEqualToString:[self getHistoryData][0]]) {
            return;
        }
        [dataArr insertObject:historyStr atIndex:0];
    }else{
        [dataArr insertObject:historyStr atIndex:0];
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:dataArr forKey:@"HistoryData"];

}

+ (void)deleteHistoryData:(NSInteger)index {
    
    NSMutableArray *dataArr = [NSMutableArray array];
    if ([self getHistoryData].count > 0) {
        dataArr = [self getHistoryData].mutableCopy;
        [dataArr removeObjectAtIndex:index];
        [[NSUserDefaults standardUserDefaults] setObject:dataArr forKey:@"HistoryData"];
    }
    

}

+ (void)allDeleteHistoryData {
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"HistoryData"];
    
}


@end

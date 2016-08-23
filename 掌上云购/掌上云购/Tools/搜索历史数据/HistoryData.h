//
//  HistoryData.h
//  掌上云购
//
//  Created by 刘毅 on 16/8/22.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HistoryData : NSObject

+ (NSArray *)getHistoryData;

+ (void)addHistoryData:(NSString *)historyStr;

+ (void)deleteHistoryData:(NSInteger)index;

+ (void)allDeleteHistoryData;


@end

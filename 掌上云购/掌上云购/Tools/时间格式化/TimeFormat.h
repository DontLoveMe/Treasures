//
//  TimeFormat.h
//  掌上云购
//
//  Created by 刘毅 on 16/10/11.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TimeFormat : NSObject
+ (NSString *)getNowTimeToString:(NSString *)timeString;

+ (NSString *)getNewTimeString:(NSString *)oldTimeString;

@end

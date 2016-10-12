//
//  TimeFormat.m
//  掌上云购
//
//  Created by 刘毅 on 16/10/11.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import "TimeFormat.h"

@implementation TimeFormat

+ (NSString *)getNowTimeToString:(NSString *)aTimeString {
    NSDateFormatter* formater = [[NSDateFormatter alloc] init];
    [formater setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDateFormatter* formater2 = [[NSDateFormatter alloc] init];
    [formater2 setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    // 截止时间date格式
    NSDate  *expireDate = [formater2 dateFromString:aTimeString];
    NSDate  *nowDate = [NSDate date];
    // 当前时间字符串格式
    NSString *nowDateStr = [formater stringFromDate:nowDate];
    // 当前时间date格式
    nowDate = [formater dateFromString:nowDateStr];
    // 当前日历
    NSCalendar *calendar = [NSCalendar currentCalendar];
    // 需要对比的时间数据
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth
    | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    // 对比时间差
    NSDateComponents *dateCom = [calendar components:unit fromDate:expireDate toDate:nowDate options:0];
    
    NSInteger days = dateCom.day;
    NSInteger hours = dateCom.hour;
    NSInteger minutes = dateCom.minute;
    NSInteger seconds = dateCom.second;
    
    if (days<3) {
        if (days == 0) {
            if (hours == 0) {
                if (minutes == 0) {
                    return [NSString stringWithFormat:@"%ld秒前",seconds];
                }else {
                    return [NSString stringWithFormat:@"%ld分钟前",minutes];
                }
                
            }else {
                return [NSString stringWithFormat:@"%ld小时前",hours];
            }
            
        }else if (days == 1){
            return [NSString stringWithFormat:@"昨天"];
        }
        else if (days == 2){
            return [NSString stringWithFormat:@"前天"];
        }
        
    }
    
    return aTimeString;
}

+ (NSString *)getNewTimeString:(NSString *)oldTimeString {
    
    NSString *newTimeString;
    NSDateFormatter* formater = [[NSDateFormatter alloc] init];
    [formater setDateFormat:@"yyyy-MM-dd HH:mm:ss.0"];
    NSDate *oldDate = [formater dateFromString:oldTimeString];
    [formater setDateFormat:@"yyyy-MM-dd HH:mm"];
    
    newTimeString = [formater stringFromDate:oldDate];
    
    return newTimeString;
}

@end

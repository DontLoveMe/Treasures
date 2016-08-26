//
//  AnnounceCell.m
//  掌上云购
//
//  Created by 刘毅 on 16/8/8.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import "AnnounceCell.h"

@implementation AnnounceCell


- (void)awakeFromNib {
    [super awakeFromNib];
    

 
}

- (void)setStr:(NSString *)str  {
    _str = str;
    self.countDown = [[CountDown alloc] init];
    __weak __typeof(self) weakSelf= self;
    weakSelf.timeLabel.text = _str;
    [self.countDown countDownWithPER_SECBlock:^{
        //        NSLog(@"倒计时");
        weakSelf.timeLabel.text = [self getNowTimeWithString:_str];
   
    }];
}
//得到时间间隔
-(NSString *)getNowTimeWithString:(NSString *)aTimeString{
    NSDateFormatter* formater = [[NSDateFormatter alloc] init];
    [formater setDateFormat:@"yyyy-MM-dd HH:mm:ss:SSS"];
    // 截止时间date格式
    NSDate  *expireDate = [formater dateFromString:aTimeString];
    NSDate  *nowDate = [NSDate date];
    // 当前时间字符串格式
    NSString *nowDateStr = [formater stringFromDate:nowDate];
    // 当前时间date格式
    nowDate = [formater dateFromString:nowDateStr];
    //传入时间与现在时间的间隔
    NSTimeInterval timeInterval =[expireDate timeIntervalSinceDate:nowDate]*1000;
    
    int hours = (int)(timeInterval/1000/3600);
    int minutes = (int)(timeInterval/1000-hours*3600)/60;
    int seconds = timeInterval/1000-hours*3600-minutes*60;
    int millisecond = (int)timeInterval-(hours*3600+minutes*60+seconds)*1000;
    NSString *hoursStr;NSString *minutesStr;NSString *secondsStr; NSString *millisecondStr;
    
    //小时
    hoursStr = [NSString stringWithFormat:@"%d",hours];
    //分钟
    if(minutes<10)
        minutesStr = [NSString stringWithFormat:@"0%d",minutes];
    else
        minutesStr = [NSString stringWithFormat:@"%d",minutes];
    //秒
    if(seconds < 10)
        secondsStr = [NSString stringWithFormat:@"0%d", seconds];
    else
        secondsStr = [NSString stringWithFormat:@"%d",seconds];
    if (millisecond<100) {
        millisecondStr = [NSString stringWithFormat:@"0%d",millisecond];
    }else if (millisecond<10) {
        millisecondStr = [NSString stringWithFormat:@"00%d",millisecond];
    }else{
        millisecondStr = [NSString stringWithFormat:@"%d",millisecond];
    }
    if (hours<=0&&minutes<=0&&seconds<=0&&millisecond<=0) {
        [self.countDown destoryTimer];
        
        
        _getUserLabel.hidden = NO;
        _peopleNumLb.hidden = NO;
        _luckyLabel.hidden = NO;
        _announceTimeLb.hidden = NO;
        
        _timeIconView.hidden = YES;
        _timeLabel.hidden = YES;
        _unveilLabel.hidden = YES;
        
        return @"已经结束！";
    }else {
        
        _getUserLabel.hidden = YES;
        _peopleNumLb.hidden = YES;
        _luckyLabel.hidden = YES;
        _announceTimeLb.hidden = YES;
        
        _timeIconView.hidden = NO;
        _timeLabel.hidden = NO;
        _unveilLabel.hidden = NO;
    }
    if (hours>0) {
        return [NSString stringWithFormat:@"%@:%@:%@:%@",hoursStr , minutesStr,secondsStr,millisecondStr];
    }
    return [NSString stringWithFormat:@"%@:%@:%@", minutesStr,secondsStr,millisecondStr];
}

@end

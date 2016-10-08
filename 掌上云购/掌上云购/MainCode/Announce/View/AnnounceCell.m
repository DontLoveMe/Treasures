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
    
    [self.countDown destoryTimer];
}


//- (void)setStr:(NSString *)str  {
//    
//    if (_str != str) {
//        
//        _str = str;
//        if (self.countDown) {
//            [self.countDown destoryTimer];
//        }else {
//            self.countDown = [[CountDown alloc] init];
//        }
//        
//        __weak __typeof(self) weakSelf= self;
//        
//        [self.countDown countDownWithPER_SECBlock:^{
//            //倒计时方法，每毫秒调用一次
//            weakSelf.timeLabel.text = [self getNowTimeWithString:_str];
//            
//        }];
//    }
//
//}
- (void)setCountDownTime:(NSInteger)countDownTime {
    if (_countDownTime != countDownTime ) {
        
        _countDownTime = countDownTime;
        if (self.countDown) {
            [self.countDown destoryTimer];
        }else {
            self.countDown = [[CountDown alloc] init];
        }
//        if (_countDownTime<0) {
//            [self.countDown destoryTimer];
//            
//            if ([_announceDelegate respondsToSelector:@selector(countEnd:)]) {
//                
//                [_announceDelegate countEnd:_indexpath];
//                
//            }
//            //        self.getUserLabel.hidden = NO;
//            //        self.peopleNumLb.hidden = NO;
//            //        self.luckyLabel.hidden = NO;
//            //        self.announceTimeLb.hidden = NO;
//            //
//            //        self.timeIconView.hidden = YES;
//            //        self.timeLabel.hidden = YES;
//            //        self.unveilLabel.hidden = YES;
//            return;
//        }
        __weak __typeof(self) weakSelf= self;
        [self.countDown countDownWithTimeStamp:countDownTime completeBlock:^(NSInteger hour, NSInteger minute, NSInteger second, NSInteger millisecond) {
            //倒计时方法，每毫秒调用一次
            if (hour<=0&&minute<=0&&second<=0&&millisecond<=0) {
                
                [weakSelf.countDown destoryTimer];
                if (_countDownTime < 0) {
                        _getUserLabel.hidden = NO;
                        _peopleNumLb.hidden = NO;
                        _luckyLabel.hidden = NO;
                        _announceTimeLb.hidden = NO;
                        _timeIconView.hidden = YES;
                        _timeLabel.hidden = YES;
                        _unveilLabel.hidden = YES;
//                    weakSelf.timeLabel.text = @"正在计算开奖结果";
                }else {
                    
                    weakSelf.timeLabel.text = @"正在计算开奖结果";
                    if ([_announceDelegate respondsToSelector:@selector(countEnd:)]) {
                        
                        [_announceDelegate countEnd:_indexpath];
                        
                    }
                    NSLogZS(@"%ld",_indexpath.row);
                }
                
                
            }else {
                
                _getUserLabel.hidden = YES;
                _peopleNumLb.hidden = YES;
                _luckyLabel.hidden = YES;
                _announceTimeLb.hidden = YES;
                
                _timeIconView.hidden = NO;
                _timeLabel.hidden = NO;
                _unveilLabel.hidden = NO;
                if (hour>0) {
                    
                    weakSelf.timeLabel.text = [NSString stringWithFormat:@"%02ld : %02ld : %02ld ",hour , minute,second];
                    
                }else {
                    
                    weakSelf.timeLabel.text = [NSString stringWithFormat:@"%02ld : %02ld : %02ld", minute,second,millisecond];
                }
            }
        }];
    }
}

////得到时间间隔
//-(NSString *)getNowTimeWithString:(NSString *)aTimeString{
//    
//    NSDateFormatter* formater = [[NSDateFormatter alloc] init];
//    [formater setDateFormat:@"yyyy-MM-dd HH:mm:ss:SSS"];
//    
//    NSDateFormatter* formater2 = [[NSDateFormatter alloc] init];
//    [formater2 setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//    // 截止时间date格式
//    NSDate  *expireDate = [formater2 dateFromString:aTimeString];
//    NSDate  *nowDate = [NSDate date];
//    // 当前时间字符串格式
//    NSString *nowDateStr = [formater stringFromDate:nowDate];
//    // 当前时间date格式
//    nowDate = [formater dateFromString:nowDateStr];
//    //传入时间与现在时间的间隔
//    NSTimeInterval timeInterval =[expireDate timeIntervalSinceDate:nowDate]*1000;
//    
//    int hours = (int)(timeInterval/1000/3600);
//    int minutes = (int)(timeInterval/1000-hours*3600)/60;
//    int seconds = timeInterval/1000-hours*3600-minutes*60;
//    int millisecond = (int)timeInterval-(hours*3600+minutes*60+seconds)*1000;
//    NSString *hoursStr;NSString *minutesStr;NSString *secondsStr; NSString *millisecondStr;
//    
//    //小时
//    hoursStr = [NSString stringWithFormat:@"%d",hours];
//    //分钟
//    if(minutes<10)
//        minutesStr = [NSString stringWithFormat:@"0%d",minutes];
//    else
//        minutesStr = [NSString stringWithFormat:@"%d",minutes];
//    //秒
//    if(seconds < 10)
//        secondsStr = [NSString stringWithFormat:@"0%d", seconds];
//    else
//        secondsStr = [NSString stringWithFormat:@"%d",seconds];
//    
//    if (millisecond<100) {
//        millisecondStr = [NSString stringWithFormat:@"0%d",millisecond/10];
//    }else if (millisecond<10) {
//        millisecondStr = [NSString stringWithFormat:@"00%d",millisecond/10];
//    }else{
//        millisecondStr = [NSString stringWithFormat:@"%d",millisecond/10];
//    }
//    if (hours<=0&&minutes<=0&&seconds<=0&&millisecond<=0) {
//        
//        [self.countDown destoryTimer];
//        
//        if ([_announceDelegate respondsToSelector:@selector(countEnd:)]) {
//            
//            [_announceDelegate countEnd:_indexpath];
//        
//        }
//        NSLogZS(@"%ld",_indexpath.row);
//        return @"正在计算开奖结果";
//        
//    }else {
//        
//        _getUserLabel.hidden = YES;
//        _peopleNumLb.hidden = YES;
//        _luckyLabel.hidden = YES;
//        _announceTimeLb.hidden = YES;
//        
//        _timeIconView.hidden = NO;
//        _timeLabel.hidden = NO;
//        _unveilLabel.hidden = NO;
//        
//        if (hours>0) {
//            
//            return [NSString stringWithFormat:@"%@ : %@ : %@ ",hoursStr , minutesStr,secondsStr];
//            
//        }
//        
//        return [NSString stringWithFormat:@"%@ : %@ : %@", minutesStr,secondsStr,millisecondStr];
//    }
//    
//}

@end

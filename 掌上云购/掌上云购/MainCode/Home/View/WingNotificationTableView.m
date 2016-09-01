//
//  WingNotificationTableView.m
//  掌上云购
//
//  Created by coco船长 on 16/8/15.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import "WingNotificationTableView.h"

/*
 此视图用于展示首页获奖提醒栏
 start功能：开启定时器，改变tableView的当前偏移量
 stop功能：关闭定时器，并隐藏视图
 当传入数组时，开启定时器。（重写数组的set方法）
 */

@implementation WingNotificationTableView
//重写实例化方法
- (instancetype)init{

    self = [super init];
    if (self) {
        [self initView];
    }
    return self;
    
}

- (instancetype)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;

}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{

    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initView];
    }
    return self;

}

- (void)initView{

    self.userInteractionEnabled = NO;
    
    self.delegate = self;
    self.dataSource = self;
    
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self registerNib:[UINib nibWithNibName:@"WingNotificationCell"
                                     bundle:[NSBundle mainBundle]]
forCellReuseIdentifier:@"WingNotification_Cell"];
    
}

//重写set方法
- (void)setDataArr:(NSArray *)dataArr{

    if (_dataArr != dataArr) {
        
        _dataArr = dataArr;
        [self reloadData];
        self.alpha = 1;
        _currentProcess = 0;
        _timer = [NSTimer scheduledTimerWithTimeInterval:3
                                                  target:self
                                                selector:@selector(timeAction)
                                                userInfo:nil
                                                 repeats:YES];
        
    }

}

//定时器方法
- (void)timeAction{

    //定时器终止条件
    if (_currentProcess  == _dataArr.count) {
        
        [_timer invalidate];
        [UIView animateWithDuration:0.5
                         animations:^{
                             
                             self.alpha = 0;
                             if ([_timerDelegate respondsToSelector:@selector(WingNotificationTableViewTimerInvalidate)]) {
                                 
                                 [_timerDelegate WingNotificationTableViewTimerInvalidate];
                             }
                             
                         }completion:^(BOOL finished) {
                             
                             self.contentOffset = CGPointMake(0, 0);
                             
                         }];
        
    }
    
    //定时器跑的方法
    [UIView animateWithDuration:0.5
                     animations:^{
                         
                        self.contentOffset = CGPointMake(0, _currentProcess * 20);
                         
                     }];

    _currentProcess ++;

}

#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _dataArr.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    WingNotificationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WingNotification_Cell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.notificationLabel.text = _dataArr[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 20;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
}

@end

//
//  AnnounceViewController.m
//  掌上云购
//
//  Created by coco船长 on 16/8/3.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import "AnnounceViewController.h"
#import "AnnounceCell.h"
#import "CountDown.h"


@interface AnnounceViewController ()

@property (nonatomic,strong)UICollectionView *collectionView;
@property (nonatomic,strong)NSArray *data;
@property (nonatomic,copy)NSString *identify;

@property (strong, nonatomic)  CountDown *countDown;

@end

@implementation AnnounceViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //请求数据
    [self requestData];
}
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    //销毁定时器
    [self.countDown destoryTimer];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"正在揭晓";
    
    //创建collectionView
    [self createCollectionView];
}
//请求数据
- (void)requestData {
    self.data= @[@"2016-08-05 14:23:45",@"2016-08-06 14:23:45",@"2016-08-07 14:14:41",@"2016-08-08 14:23:50",@"2016-08-09 14:23:45",@"2016-08-10 14:15:42",@"2016-08-11 14:23:51",@"2016-08-12 14:28:45",@"2016-08-13 14:16:43",@"2016-08-14 14:23:52",@"2016-08-15 14:29:45",@"2016-08-16 14:17:44",@"2016-08-17 14:23:53",@"2016-08-18 14:30:45",@"2016-08-19 14:18:45",@"2016-08-20 14:23:54",@"2016-08-21 14:31:01",@"2016-08-22 14:19:30",@"2016-08-23 14:23:55",@"2016-08-24 14:32:02",@"2016-08-25 14:20:31",@"2016-08-26 14:23:56",@"2016-08-27 14:33:03",@"2016-08-28 14:21:12",@"2016-08-29 14:23:45",@"2016-08-30 14:34:04",@"2016-08-31 14:23:32",@"2016-09-01 14:23:49",@"2016-09-02 14:04:05",@"2016-09-03 14:23:05",@"2016-09-04 14:24:09",@"2016-09-05 14:14:06",@"2016-09-06 14:24:02",@"2016-09-07 14:24:10",@"2016-09-08 14:24:07",@"2016-09-09 14:25:01",@"2016-09-10 14:24:11",@"2016-09-11 14:34:08",@"2016-09-12 14:26:03",];
    
    self.countDown = [[CountDown alloc] init];
    __weak __typeof(self) weakSelf= self;
    ///每秒回调一次
    [self.countDown countDownWithPER_SECBlock:^{
        NSLog(@"倒计时");
        [weakSelf.collectionView reloadData];
    }];
}
//得到时间间隔
-(NSString *)getNowTimeWithString:(NSString *)aTimeString{
    NSDateFormatter* formater = [[NSDateFormatter alloc] init];
    [formater setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    // 截止时间date格式
    NSDate  *expireDate = [formater dateFromString:aTimeString];
    NSDate  *nowDate = [NSDate date];
    // 当前时间字符串格式
    NSString *nowDateStr = [formater stringFromDate:nowDate];
    // 当前时间date格式
    nowDate = [formater dateFromString:nowDateStr];
    //传入时间与现在时间的间隔
    NSTimeInterval timeInterval =[expireDate timeIntervalSinceDate:nowDate];
    
    int days = (int)(timeInterval/(3600*24));
    int hours = (int)((timeInterval-days*24*3600)/3600);
    int minutes = (int)(timeInterval-days*24*3600-hours*3600)/60;
    int seconds = timeInterval-days*24*3600-hours*3600-minutes*60;
    
    NSString *dayStr;NSString *hoursStr;NSString *minutesStr;NSString *secondsStr;
    //天
    dayStr = [NSString stringWithFormat:@"%d",days];
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
    if (hours<=0&&minutes<=0&&seconds<=0) {
        return @"已经结束！";
    }
    if (days) {
        return [NSString stringWithFormat:@"%@天%@:%@:%@", dayStr,hoursStr, minutesStr,secondsStr];
    }
    return [NSString stringWithFormat:@"%@:%@:%@",hoursStr , minutesStr,secondsStr];
}

//创建collectionView
- (void)createCollectionView {
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(KScreenWidth/2-0.5, KScreenWidth*1.2/2);
    layout.minimumLineSpacing = 1;
    layout.minimumInteritemSpacing = 1;
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight-self.tabBarController.tabBar.height-64) collectionViewLayout:layout];
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:_collectionView];
    
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    
    _identify = @"AnnounceCell";
    UINib *nib = [UINib nibWithNibName:@"AnnounceCell" bundle:nil];
    [_collectionView registerNib:nib forCellWithReuseIdentifier:_identify];
    
    
}

#pragma mark - collectionViewDelegate,collectViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.data.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    AnnounceCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:_identify forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    
    cell.timeLabel.text = [self getNowTimeWithString:_data[indexPath.row]];
    if ([cell.timeLabel.text isEqualToString:@"已经结束！"]) {
        cell.timeLabel.textColor = [UIColor redColor];
    }else{
        cell.timeLabel.textColor = [UIColor orangeColor];
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

@end

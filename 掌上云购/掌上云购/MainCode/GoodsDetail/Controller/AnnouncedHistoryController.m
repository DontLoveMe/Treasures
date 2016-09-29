//
//  AnnouncedHistoryController.m
//  掌上云购
//
//  Created by coco船长 on 16/8/18.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import "AnnouncedHistoryController.h"

@interface AnnouncedHistoryController ()

@end

@implementation AnnouncedHistoryController
- (void)initNavBar{
    
    self.navigationItem.backBarButtonItem = nil;
    UIButton *leftButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 20.f, 25.f)];
    leftButton.tag = 101;
    [leftButton setBackgroundImage:[UIImage imageNamed:@"返回.png"]
                          forState:UIControlStateNormal];
    [leftButton addTarget:self
                   action:@selector(NavAction:)
         forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftItem;
    
}

- (void)NavAction:(UIButton *)button{
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"往期揭晓";
    
    _announceHistoryArr = [NSMutableArray array];
    _pageIndex = 1;
    
    [self initNavBar];

    [self initViews];
    
    [self requestData:_pageIndex];
    
}

- (void)initViews{

    _announcedTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight - kNavigationBarHeight)];
    _announcedTableView.delegate = self;
    _announcedTableView.dataSource = self;
    _announcedTableView.backgroundColor = [UIColor whiteColor];
    _announcedTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_announcedTableView registerNib:[UINib nibWithNibName:@"AnnounceHistoryCell"
                                                    bundle:[NSBundle mainBundle]]
              forCellReuseIdentifier:@"AnnounceHistory_Cell"];
    //下拉时动画
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        
        _pageIndex = 1;
        _announceHistoryArr = [NSMutableArray array];
        [self requestData:_pageIndex];
        
        
    }];
    
    //下拉时图片
    NSMutableArray *gifWhenPullDown = [NSMutableArray array];
    for (NSInteger i = 1 ; i <= 30; i++) {
        
        if (i / 100 > 0) {
            [gifWhenPullDown addObject:[UIImage imageNamed:[NSString stringWithFormat:@"dropdown_zsyg_%ld",i]]];
        }else if (i / 10){
            [gifWhenPullDown addObject:[UIImage imageNamed:[NSString stringWithFormat:@"dropdown_zsyg_0%ld",i]]];
        }else{
            [gifWhenPullDown addObject:[UIImage imageNamed:[NSString stringWithFormat:@"dropdown_zsyg_00%ld",i]]];
        }
        
    }
    
    [header setImages:gifWhenPullDown
             duration:1 forState:MJRefreshStatePulling];
    
    //正在刷新时图片
    NSMutableArray *gifWhenRefresh = [NSMutableArray array];
    for (NSInteger i = 31 ; i <= 112; i++) {
        
        if (i / 100 > 0) {
            [gifWhenRefresh addObject:[UIImage imageNamed:[NSString stringWithFormat:@"dropdown_zsyg_%ld",i]]];
        }else if (i / 10){
            [gifWhenRefresh addObject:[UIImage imageNamed:[NSString stringWithFormat:@"dropdown_zsyg_0%ld",i]]];
        }else{
            [gifWhenRefresh addObject:[UIImage imageNamed:[NSString stringWithFormat:@"dropdown_zsyg_00%ld",i]]];
        }
        
    }
    
    [header setImages:gifWhenRefresh
             duration:2 forState:MJRefreshStateRefreshing];
    
    header.lastUpdatedTimeLabel.hidden = YES;
    header.stateLabel.hidden = NO;
    header.stateLabel.textColor = [UIColor colorFromHexRGB:ThemeColor];
    [header setTitle:@"下拉刷新。" forState:MJRefreshStateIdle];
    [header setTitle:@"松手即可刷新" forState:MJRefreshStatePulling];
    [header setTitle:@"正在刷新..." forState:MJRefreshStateRefreshing];
    _announcedTableView.mj_header = header;
    
    
    MJRefreshBackStateFooter *footer = [MJRefreshBackStateFooter footerWithRefreshingBlock:^{
        if (_pageIndex == 1) {
            _pageIndex = 2;
        }
        [self requestData:_pageIndex];
    }];
    _announcedTableView.mj_footer = footer;
    
    [self.view addSubview:_announcedTableView];
    
}

#pragma mark - UITableViewDelegate,UItableViewDatasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _announceHistoryArr.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    AnnounceHistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AnnounceHistory_Cell"
                                                                forIndexPath:indexPath];
    NSDictionary *dic = [_announceHistoryArr objectAtIndex:indexPath.row];

    cell.goodsMsgLabel.text = [NSString stringWithFormat:@"期号：%@(揭晓时间：%@)",[dic objectForKey:@"drawTimes"],[dic objectForKey:@"drawDate"]];
    
    if (![dic[@"photoUrl"] isKindOfClass:[NSNull class]]){
        NSString *photoUrl = dic[@"photoUrl"];
        NSURL *imgUrl;
        if ([photoUrl hasPrefix:@"http"]) {
            imgUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@",photoUrl]];
        }else{
            imgUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",AliyunPIC_URL,photoUrl]];
        }
        [cell.picImgView setImageWithURL:imgUrl placeholderImage:[UIImage imageNamed:@"我的-头像"]];
    }else {
        [cell.picImgView setImage:[UIImage imageNamed:@"未加载图片"]];
    }
    if (![dic[@"drawUserId"] isKindOfClass:[NSNull class]]) {
        cell.picImgView.buyUserId = [dic[@"drawUserId"] integerValue];
        cell.userId.text = [NSString stringWithFormat:@"用户ID:%@",[dic objectForKey:@"drawUserId"]];
    }else {
        cell.picImgView.buyUserId = 0;
        cell.userId.text = @"";
    }
    
    if (![dic[@"nickName"] isKindOfClass:[NSNull class]]) {
        cell.userName.text = [NSString stringWithFormat:@"获奖者：%@",[dic objectForKey:@"nickName"]];
    }else {
        cell.userName.text = @"";
    }
    if (![dic[@"drawNumber"] isKindOfClass:[NSNull class]]) {
        cell.luckyNum.text = [NSString stringWithFormat:@"幸运号码：%@",[dic objectForKey:@"drawNumber"]];
    }else {
        cell.luckyNum.text = @"";
    }
    if (![dic[@"qty"] isKindOfClass:[NSNull class]]) {
        cell.joinTimes.text = [NSString stringWithFormat:@"本期参与：%@次",[dic objectForKey:@"qty"]];
    }else {
        cell.joinTimes.text = @"";
    }
    
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 122;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    NSLogZS(@"点击了第%ld个单元格",indexPath.row);
    
}

#pragma mark - 请求网络数据
- (void)requestData:(NSInteger)indexPath{

    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:@{@"productId":_goodsID}
               forKey:@"paramsMap"];
    [params setObject:@"10" forKey:@"rows"];
    [params setObject:[NSNumber numberWithInteger:indexPath]
               forKey:@"page"];
    
    NSString *url = [NSString stringWithFormat:@"%@%@",BASE_URL,GoodsHistoryPrize_URL];
    
    [ZSTools post:url
           params:params
          success:^(id json) {
              
              if ([json objectForKey:@"flag"]) {

              NSArray *dataArr = json[@"data"];
              if (_pageIndex == 1) {
                  [_announceHistoryArr removeAllObjects];
                  _announceHistoryArr = dataArr.mutableCopy;
                  
                  [_announcedTableView.mj_footer resetNoMoreData];
                  [_announcedTableView.mj_header endRefreshing];
              }
              
              if (_pageIndex != 1 && _pageIndex != 0) {
                  if (dataArr.count > 0) {
                      _pageIndex ++;
                      [_announceHistoryArr addObjectsFromArray:dataArr];
                      [_announcedTableView.mj_footer endRefreshing];
                  }else {
                      [_announcedTableView.mj_footer endRefreshingWithNoMoreData];
                  }
              }
              [_announcedTableView reloadData];
                  }
              
          } failure:^(NSError *error) {
              
          }];

}

@end

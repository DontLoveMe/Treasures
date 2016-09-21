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
    _pageIndex = 0;
    
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
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        
                _pageIndex = 1;
                _announceHistoryArr = [NSMutableArray array];
                [self requestData:_pageIndex];
        
    }];
    NSArray *gifArr = @[[UIImage imageNamed:@"下拉81"],
                        [UIImage imageNamed:@"下拉82"],
                        [UIImage imageNamed:@"下拉83"],
                        [UIImage imageNamed:@"下拉84"],
                        [UIImage imageNamed:@"下拉85"],
                        [UIImage imageNamed:@"下拉86"],
                        [UIImage imageNamed:@"下拉87"],
                        [UIImage imageNamed:@"下拉88"]];
//    NSArray *gifArr = @[[UIImage imageNamed:@"发现1"],[UIImage imageNamed:@"发现2"],[UIImage imageNamed:@"发现1"],[UIImage imageNamed:@"发现2"],[UIImage imageNamed:@"发现1"],[UIImage imageNamed:@"发现2"],[UIImage imageNamed:@"发现1"],[UIImage imageNamed:@"发现2"],[UIImage imageNamed:@"发现1"],[UIImage imageNamed:@"发现2"],[UIImage imageNamed:@"发现1"],[UIImage imageNamed:@"发现2"],[UIImage imageNamed:@"发现1"],[UIImage imageNamed:@"发现2"]]
    [header setImages:gifArr
             duration:1 forState:MJRefreshStateRefreshing];
    header.lastUpdatedTimeLabel.hidden = YES;
    header.stateLabel.hidden = YES;
    _announcedTableView.mj_header = header;

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
        [cell.picImgView setImageWithURL:[NSURL URLWithString:dic[@"photoUrl"]] placeholderImage:[UIImage imageNamed:@"未加载图片"]];
    }else {
        [cell.picImgView setImage:[UIImage imageNamed:@"未加载图片"]];
    }
    
    cell.userName.text = [NSString stringWithFormat:@"获奖者：%@",[dic objectForKey:@"nickName"]];
    cell.userId.text = [NSString stringWithFormat:@"用户ID:%@",[dic objectForKey:@"drawUserId"]];
    cell.luckyNum.text = [NSString stringWithFormat:@"幸运号码：%@次",[dic objectForKey:@"drawNumber"]];
    cell.joinTimes.text = [NSString stringWithFormat:@"本期参与：%@次",[dic objectForKey:@"qty"]];
    
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
    [params setObject:[NSNumber numberWithInteger:indexPath + 1]
               forKey:@"page"];
    
    NSString *url = [NSString stringWithFormat:@"%@%@",BASE_URL,GoodsHistoryPrize_URL];
    
    [ZSTools post:url
           params:params
          success:^(id json) {
              
              if ([json objectForKey:@"flag"]) {
              
                  _announceHistoryArr = [json objectForKey:@"data"];
                  [_announcedTableView reloadData];
                  [_announcedTableView.mj_header endRefreshing];
              }
              
          } failure:^(NSError *error) {
              
          }];

}

@end

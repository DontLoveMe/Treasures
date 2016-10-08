//
//  InordertoshareController.m
//  掌上云购
//
//  Created by 刘毅 on 16/8/15.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import "InordertoshareController.h"
#import "InordertoshareCell.h"
#import "InordertoDetailController.h"
#import "InordertoshareModel.h"
#import "LuckyRecordCell.h"
#import "RecordModel.h"
#import "AddShareController.h"

@interface InordertoshareController ()

@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,copy)NSString *identify;
@property (nonatomic,copy)NSString *identify1;

@property (nonatomic,strong)NSMutableArray *data;
@property (nonatomic,assign)NSInteger page;

@property (nonatomic,strong)NSArray *luckyData;

@end

@implementation InordertoshareController
#pragma mark - 导航栏
- (void)initNavBar{
    
    self.navigationItem.backBarButtonItem = nil;
    UIButton *leftButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 12.f, 18.f)];
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

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self requestLuckyData];
    
    [self requestData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"晒单记录";
    
    _page = 1;
    _data = [NSMutableArray array];
    
    [self initNavBar];
    
    [self createTabelView];
}
- (void)requestLuckyData {
    //取出存储的用户信息
        NSDictionary *userDic = [[NSUserDefaults standardUserDefaults] objectForKey:@"userDic"];
        NSNumber *userId = userDic[@"id"];
    [self showHUD:@"加载数据"];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:@{@"buyUserId":userId} forKey:@"paramsMap"];
    [params setObject:@1 forKey:@"page"];
    [params setObject:@200 forKey:@"rows"];
    
    NSString *url = [NSString stringWithFormat:@"%@%@",BASE_URL,LuckyNumberList_URL];
    [ZSTools post:url
           params:params
          success:^(id json) {
              
              BOOL isSuccess = [[json objectForKey:@"flag"] boolValue];
              [self hideSuccessHUD:json[@"msg"]];
              if (isSuccess) {
                  NSArray *dataArr = json[@"data"];
                  NSMutableArray *arr = [NSMutableArray array];
                  for (NSInteger i = 0; i< dataArr.count;i++) {
                      NSDictionary *dic = dataArr[i];
                      //"orderStatus": "0",//订单状态，0：已支付1：已确认收货地址2：已发货3：已签收4：已晒单5：已确认物品6：已选择方式7：已发卡密或充值到余额（虚拟商品）8：未确认地址取消订单',

                      NSInteger orderStatus = [dic[@"orderStatus"] integerValue];

                      if (orderStatus==3) {
                          if (![dic[@"sunOrder"] boolValue]) {
                                [arr addObject:dic];
                          }
                          
                      }
                      if (orderStatus==7) {
                          if (![dic[@"sunOrder"] boolValue]) {
                              [arr addObject:dic];
                          }
                      }
                  }
                  _luckyData = arr;
                  [_tableView reloadData];
              }
              
              
          } failure:^(NSError *error) {
              
              [self hideFailHUD:@"加载失败"];
              NSLogZS(@"%@",error);
          }];
}
- (void)requestData {
    //取出存储的用户信息
        NSDictionary *userDic = [[NSUserDefaults standardUserDefaults] objectForKey:@"userDic"];
        NSNumber *userId = userDic[@"id"];
    [self showHUD:@"加载数据"];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:@{@"buyUserId":userId} forKey:@"paramsMap"];
    [params setObject:@(_page) forKey:@"page"];
    [params setObject:@10 forKey:@"rows"];
    NSString *url = [NSString stringWithFormat:@"%@%@",BASE_URL,Sunsharing_URL];
    [ZSTools post:url
           params:params
          success:^(id json) {
              
              BOOL isSuccess = [[json objectForKey:@"flag"] boolValue];
              [self hideSuccessHUD:json[@"msg"]];
              if (isSuccess) {
                 
                  NSArray *dataArr = json[@"data"];
                  if (_page == 1) {
                      [_data removeAllObjects];
                      _data = dataArr.mutableCopy;
                      
                      [_tableView.mj_footer resetNoMoreData];
                      [_tableView.mj_header endRefreshing];
                  }
                  
                  if (_page != 1 && _page != 0) {
                      if (dataArr.count > 0) {
                          _page ++;
                          [_data addObjectsFromArray:dataArr];
                          [_tableView.mj_footer endRefreshing];
                      }else {
                          [_tableView.mj_footer endRefreshingWithNoMoreData];
                      }
                  }
                  [_tableView reloadData];
              }
              
          } failure:^(NSError *error) {
              
              [self hideFailHUD:@"加载失败"];
              NSLogZS(@"%@",error);
          }];
}

- (void)createTabelView {
 
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight-64) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    _tableView.separatorStyle =UITableViewCellSeparatorStyleNone ;
    
    _identify = @"InordertoshareCell";
    UINib *nib = [UINib nibWithNibName:@"InordertoshareCell" bundle:nil];
    [_tableView registerNib:nib forCellReuseIdentifier:_identify];
    
    _identify1 = @"LuckyRecordCell";
    UINib *nib1 = [UINib nibWithNibName:@"LuckyRecordCell" bundle:nil];
    [_tableView registerNib:nib1 forCellReuseIdentifier:_identify1];
   
    //下拉时动画
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        _page = 1;
        [self requestData];
        
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
    _tableView.mj_header = header;
    
    MJRefreshBackStateFooter *footer = [MJRefreshBackStateFooter footerWithRefreshingBlock:^{
        if (_page == 1) {
            _page = 2;
        }
        [self requestData];
    }];
    _tableView.mj_footer = footer;
    
}

#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return self.luckyData.count;
    }
    return self.data.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        LuckyRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:_identify1 forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.goodsButton setTitle:@"晒单奖红包" forState:UIControlStateNormal];
        RecordModel *rModel = [RecordModel mj_objectWithKeyValues:self.luckyData[indexPath.row]];
        
        cell.imgWidth.constant = 0;
        cell.lkModel = rModel;
        cell.isSunBtn.hidden = YES;
        __weak typeof(self) weakSelf = self;
        [cell setSuerBlock:^{
            AddShareController *asVC = [[AddShareController alloc] init];
            asVC.lkModel = rModel;
            [weakSelf.navigationController pushViewController:asVC animated:YES];
        }];
        
        return cell;
    }
    InordertoshareCell *cell = [tableView dequeueReusableCellWithIdentifier:_identify forIndexPath:indexPath];
    cell.iSModel = [InordertoshareModel mj_objectWithKeyValues:self.data[indexPath.row]];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 155;
    }
    //计算单元格高度
    InordertoshareModel *iSModel = [InordertoshareModel mj_objectWithKeyValues:self.data[indexPath.row]];
    NSString *content = iSModel.content;
    CGRect contentRect = [content boundingRectWithSize:CGSizeMake(KScreenWidth-57, 35) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil];
    NSArray *photoUrllist = iSModel.photoUrllist;
    CGFloat height = 0;
    if (photoUrllist.count == 0) {
        height = 0;
    }else if (photoUrllist.count <4){
        height = 90;
    }else{
        height = 90*2;
    }
    
    return (height + contentRect.size.height + 120);
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
    }else {
        InordertoshareModel *iSModel = [InordertoshareModel mj_objectWithKeyValues:self.data[indexPath.row]];
        
        InordertoDetailController *indVC = [[InordertoDetailController alloc] init];
        indVC.shareID = iSModel.ID;
        indVC.buyUserId = iSModel.buyUserId;
        [self.navigationController pushViewController:indVC animated:YES];

    }
}
/*测试数据
 self.data = @[
 @{ @"id": @5,
 @"saleOrderDetailId": @1,
 @"drawTimes": @"201423213",
 @"content": @"321adas暗色调",
 @"createDate": @"2016-08-31 14:56:03",
 @"nickName": @"22",
 @"productName": @"Apple iPhone 6s (A1700) 64G 玫瑰金色 移动联通电信4G手机",
 @"title": @"231",
 @"photoUrllist": @[
 @"http://192.168.0.252:8000/pcpfiles/png/2016/08/23/70442847a3e5483d850850f2dd3ed472.png",
 @"http://192.168.0.252:8000/pcpfiles/png/2016/08/23/70442847a3e5483d850850f2dd3ed472.png",
 @"http://192.168.0.252:8000/pcpfiles/png/2016/08/23/70442847a3e5483d850850f2dd3ed472.png"
 ]}].mutableCopy;
 */
@end

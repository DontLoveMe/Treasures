//
//  RechargeRecordController.m
//  掌上云购
//
//  Created by 刘毅 on 16/8/17.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import "RechargeRecordController.h"
#import "RechargeRecordCell.h"
#import "RechargeModel.h"

@interface RechargeRecordController ()

@property (nonatomic,strong)NSMutableArray *data;
@property (nonatomic,assign)NSInteger page;

@end

@implementation RechargeRecordController {
    
    UITableView *_tableView;
    NSString *_identify;
}

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

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"充值记录";
    
    _page = 1;
    _data = [NSMutableArray array];
    
    [self initNavBar];
    
    [self requestData];
    
    [self createTableView];
}

- (void)requestData {
    //取出存储的用户信息
        NSDictionary *userDic = [[NSUserDefaults standardUserDefaults] objectForKey:@"userDic"];
        NSNumber *userId = userDic[@"id"];
    [self showHUD:@"加载数据"];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:@{@"userId":userId} forKey:@"paramsMap"];
    [params setObject:@(_page) forKey:@"page"];
    [params setObject:@20 forKey:@"rows"];
    NSString *url = [NSString stringWithFormat:@"%@%@",BASE_URL,RechargeList_URL];
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

- (void)createTableView {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight-64) style:UITableViewStylePlain];
    _tableView.contentSize = CGSizeMake(KScreenWidth, 44);
    [self.view addSubview:_tableView];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    _identify = @"RechargeRecordCell";
    [_tableView registerNib:[UINib nibWithNibName:@"RechargeRecordCell" bundle:nil] forCellReuseIdentifier:_identify];
    
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
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _data.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    RechargeRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:_identify forIndexPath:indexPath];
    cell.raModel = [RechargeModel mj_objectWithKeyValues:self.data[indexPath.row]];
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 45;
}
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}
@end

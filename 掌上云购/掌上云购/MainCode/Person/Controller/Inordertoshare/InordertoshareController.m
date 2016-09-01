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

@interface InordertoshareController ()

@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,copy)NSString *identify;

@property (nonatomic,strong)NSMutableArray *data;
@property (nonatomic,assign)NSInteger page;

@end

@implementation InordertoshareController
#pragma mark - 导航栏
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
    
    self.title = @"晒单记录";
    
    _page = 1;
    _data = [NSMutableArray array];
    
    [self initNavBar];
    
    [self requestData];
    
    [self createTabelView];
}
- (void)requestData {
    //取出存储的用户信息
    //    NSDictionary *userDic = [[NSUserDefaults standardUserDefaults] objectForKey:@"userDic"];
    //    NSNumber *userId = userDic[@"id"];
    [self showHUD:@"加载数据"];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:@{@"userId":@1} forKey:@"paramsMap"];
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
    
    _tableView.separatorColor = [UIColor blackColor];
    
    _identify = @"InordertoshareCell";
    UINib *nib = [UINib nibWithNibName:@"InordertoshareCell" bundle:nil];
    [_tableView registerNib:nib forCellReuseIdentifier:_identify];
    
    MJRefreshNormalHeader *useHeader = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _page = 1;
        [self requestData];
        
    }];
    _tableView.mj_header = useHeader;
    
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
    return self.data.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    InordertoshareCell *cell = [tableView dequeueReusableCellWithIdentifier:_identify forIndexPath:indexPath];
    cell.iSModel = [InordertoshareModel mj_objectWithKeyValues:self.data[indexPath.row]];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    //计算单元格高度
    InordertoshareModel *iSModel = [InordertoshareModel mj_objectWithKeyValues:self.data[indexPath.row]];
    NSString *content = iSModel.content;
    CGRect contentRect = [content boundingRectWithSize:CGSizeMake(KScreenWidth-57, 35) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil];
    NSArray *photoUrllist = iSModel.photoUrllist;
    CGFloat height;
    if (photoUrllist.count == 0) {
        height = 0;
    }else if (photoUrllist.count <4){
        height = 90;
    }else if (photoUrllist.count < 7){
        height = 90*2;
    }
    
    return height + contentRect.size.height + 120;
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    InordertoshareModel *iSModel = [InordertoshareModel mj_objectWithKeyValues:self.data[indexPath.row]];
    
    InordertoDetailController *indVC = [[InordertoDetailController alloc] init];
    indVC.shareID = iSModel.ID;
    [self.navigationController pushViewController:indVC animated:YES];
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

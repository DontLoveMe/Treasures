//
//  HisCenterController.m
//  掌上云购
//
//  Created by 刘毅 on 16/8/15.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import "HisCenterController.h"
#import "HisSnatchRecordCell.h"
#import "SnatchRecordCell.h"
#import "SnatchRecordingCell.h"
#import "RecordModel.h"
#import "InordertoshareCell.h"
#import "InordertoshareModel.h"
#import "InordertoDetailController.h"

@interface HisCenterController ()
@property (nonatomic,strong)UIImageView *lineView;
@property (nonatomic,assign)NSInteger selectButtonTag;
@property (nonatomic,strong)UIImageView *bgIconView;

@property (nonatomic,strong)UIImageView *iconView;
@property (nonatomic,strong)UILabel *nikeNLabel;
//@property (nonatomic,strong)UILabel *idLabel;

//0.云购记录；1.幸运记录；2.我的晒单
@property (nonatomic,assign)NSInteger type;

@property (nonatomic,strong)NSMutableArray *dataListArr;
@property (nonatomic,assign)NSInteger page;

@end

@implementation HisCenterController

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
    
    self.title = @"TA的个人中心";
    _selectButtonTag = 200;
    _page = 1;
    _dataListArr = [NSMutableArray array];
    [self initNavBar];
    
    [self getUserInfo];
    
    [self requestSnatchData];
 
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.backgroundColor = [UIColor clearColor];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    

    UINib *nib = [UINib nibWithNibName:@"HisSnatchRecordCell" bundle:nil];
    [_tableView registerNib:nib forCellReuseIdentifier:@"HisSnatchRecordCell"];
    
    UINib *nib2 = [UINib nibWithNibName:@"SnatchRecordingCell" bundle:nil];
    [_tableView registerNib:nib2 forCellReuseIdentifier:@"SnatchRecordingCell"];
    UINib *nib3 = [UINib nibWithNibName:@"SnatchRecordCell" bundle:nil];
    [_tableView registerNib:nib3 forCellReuseIdentifier:@"SnatchRecordCell"];
    
    UINib *nib4 = [UINib nibWithNibName:@"InordertoshareCell" bundle:nil];
    [_tableView registerNib:nib4 forCellReuseIdentifier:@"InordertoshareCell"];
    
    
//    MJRefreshNormalHeader *useHeader = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        _page = 1;
//
//        if (_type == 2) {
//            [self requestShareData];
//        }
//    }];
//    _tableView.mj_header = useHeader;
    
    MJRefreshBackStateFooter *footer = [MJRefreshBackStateFooter footerWithRefreshingBlock:^{
        if (_page == 1) {
            _page = 2;
        }
        if (_type == 0){
            [self requestSnatchData];
        }else if (_type == 1) {
            [self requestLuckyData];
        }
        else if (_type == 2) {
            [self requestShareData];
        }

    }];
    _tableView.mj_footer = footer;


    //创建头视图
    [self initBgHeaderView];
    [self createTableHeaderView];
    
}
#pragma mark - 数据请求
- (void)getUserInfo {
    //取出存储的用户信息
//    [self showHUD:@"加载中"];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:@(_buyUserId) forKey:@"id"];
    
    NSString *url = [NSString stringWithFormat:@"%@%@",BASE_URL,UserInfo_URL];
    [ZSTools post:url
           params:params
          success:^(id json) {
              
              BOOL isSuccess = [[json objectForKey:@"flag"] boolValue];
//              [self hideSuccessHUD:[json objectForKey:@"msg"]];
              if (isSuccess) {
                  NSDictionary *userInfo = json[@"data"];
                  if (![userInfo[@"photoUrl"] isEqual:[NSNull null]]) {
                      
                      [_iconView setImageWithURL:[NSURL URLWithString:userInfo[@"photoUrl"]] placeholderImage:[UIImage imageNamed:@"我的-头像"]];
                      
                      [_bgIconView setImageWithURL:[NSURL URLWithString:userInfo[@"photoUrl"]] placeholderImage:[UIImage imageNamed:@"我的-头像"]];
                      
                      
                  }else {
                      _iconView.image = [UIImage imageNamed:@"我的-头像"];
                      _bgIconView.image = [UIImage imageNamed:@"我的-头像"];
                  }
                  if (![userInfo[@"nickName"] isEqual:[NSNull null]]) {
                      _nikeNLabel.text = userInfo[@"nickName"];
                  }
                  
                  
              }
              
              
          } failure:^(NSError *error) {
              
              [self hideFailHUD:@"加载失败"];
              NSLogZS(@"%@",error);
          }];
}
- (void)requestSnatchData{
    //取出存储的用户信息
    [self showHUD:@"加载数据"];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    if (drawStatus == nil) {
        [params setObject:@{@"buyUserId":@(_buyUserId)} forKey:@"paramsMap"];
//    }else {
//        [params setObject:@{@"buyUserId":@1,@"drawStatus":@1} forKey:@"paramsMap"];
//    }
    
    [params setObject:@(_page) forKey:@"page"];
    [params setObject:@10 forKey:@"rows"];
    
    NSString *url = [NSString stringWithFormat:@"%@%@",BASE_URL,UserOrderList_URL];
    [ZSTools post:url
           params:params
          success:^(id json) {
              
              BOOL isSuccess = [[json objectForKey:@"flag"] boolValue];
              [self hideSuccessHUD:json[@"msg"]];
              if (isSuccess) {
                  NSArray *dataArr = json[@"data"];
                  if (_page == 1) {
                      [_dataListArr removeAllObjects];
                      _dataListArr = dataArr.mutableCopy;
                      
//                      [_tableView.mj_footer resetNoMoreData];
//                      [_tableView.mj_header endRefreshing];
                  }
                  
                  if (_page != 1 && _page != 0) {
                      if (dataArr.count > 0) {
                          _page ++;
                          [_dataListArr addObjectsFromArray:dataArr];
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
- (void)requestLuckyData {
    //取出存储的用户信息
    [self showHUD:@"加载数据"];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:@{@"buyUserId":@(_buyUserId)} forKey:@"paramsMap"];
    [params setObject:@(_page) forKey:@"page"];
    [params setObject:@10 forKey:@"rows"];
    
    NSString *url = [NSString stringWithFormat:@"%@%@",BASE_URL,LuckyNumberList_URL];
    [ZSTools post:url
           params:params
          success:^(id json) {
              
              BOOL isSuccess = [[json objectForKey:@"flag"] boolValue];
              [self hideSuccessHUD:json[@"msg"]];
              if (isSuccess) {
                  NSArray *dataArr = json[@"data"];
                  if (_page == 1) {
                      [_dataListArr removeAllObjects];
                      _dataListArr = dataArr.mutableCopy;
                      
//                      [_tableView.mj_footer resetNoMoreData];
//                      [_tableView.mj_header endRefreshing];
                  }
                  
                  if (_page != 1 && _page != 0) {
                      if (dataArr.count > 0) {
                          _page ++;
                          [_dataListArr addObjectsFromArray:dataArr];
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
- (void)requestShareData {
    //取出存储的用户信息
    [self showHUD:@"加载数据"];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:@{@"buyUserId":@(_buyUserId)} forKey:@"paramsMap"];
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
                  NSMutableArray *sunData = [NSMutableArray array];
                  for (int i = 0; i < dataArr.count; i ++) {
                      NSDictionary *sunDic = dataArr[i];
                      NSInteger status = [sunDic[@"status"] integerValue];
                      if (status == 3) {
                          [sunData addObject:sunDic];
                      }
                  }

                  if (_page == 1) {
                      [_dataListArr removeAllObjects];
                      _dataListArr = sunData;
                      
//                      [_tableView.mj_footer resetNoMoreData];
//                      [_tableView.mj_header endRefreshing];
                  }
                  
                  if (_page != 1 && _page != 0) {
                      if (sunData.count > 0) {
                          _page ++;
                          [_dataListArr addObjectsFromArray:sunData];
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
#pragma mark - 视图创建
//创建头视图
- (void)initBgHeaderView {
    
    _bgIconView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 160)];
    [self.view insertSubview:_bgIconView belowSubview:_tableView];
    
    _bgIconView.image = [UIImage imageNamed:@"发现5"];
    //  毛玻璃样式
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    //  毛玻璃视图
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    effectView.alpha = 0.8;
    effectView.frame = _bgIconView.bounds;
    [_bgIconView addSubview:effectView];
}

- (void)createTableHeaderView {

    UIImageView *tableHeaderView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 160)];
//    tableHeaderView.backgroundColor = [UIColor colorFromHexRGB:ThemeColor];
    _iconView = [[UIImageView alloc] initWithFrame:CGRectMake((KScreenWidth-90)/2, 30, 90, 90)];
    _iconView.layer.cornerRadius = _iconView.width/2;
    _iconView.layer.masksToBounds = YES;
    _iconView.image = [UIImage imageNamed:@"发现5"];
    [tableHeaderView addSubview:_iconView];
    
    _nikeNLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_iconView.frame)+2, KScreenWidth, 20)];
    _nikeNLabel.text = @"nikeName";
    _nikeNLabel.textColor = [UIColor whiteColor];
    _nikeNLabel.textAlignment = NSTextAlignmentCenter;
    _nikeNLabel.font = [UIFont systemFontOfSize:16];
    [tableHeaderView addSubview:_nikeNLabel];
    
    _tableView.tableHeaderView = tableHeaderView;
}

#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataListArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_type == 0){
        RecordModel *rcModel = [RecordModel mj_objectWithKeyValues:_dataListArr[indexPath.row]];
        if (rcModel.saleDraw.status == 3||rcModel.saleDraw.status == 2) {
            SnatchRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SnatchRecordCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor clearColor];
            cell.rcModel = rcModel;
            return cell;
        }
        SnatchRecordingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SnatchRecordingCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
        cell.rcModel = rcModel;
        return cell;
    }else if (_type == 1) {
        RecordModel *rcModel = [RecordModel mj_objectWithKeyValues:_dataListArr[indexPath.row]];
        HisSnatchRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HisSnatchRecordCell" forIndexPath:indexPath];
        cell.userIDLb.text = [NSString stringWithFormat:@"用户ID：%ld",_buyUserId];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
//        cell.luckyView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:0.7];
        cell.rcModel = rcModel;
        return cell;
    }

    InordertoshareCell *cell = [tableView dequeueReusableCellWithIdentifier:@"InordertoshareCell" forIndexPath:indexPath];
    cell.iconButton.userInteractionEnabled = NO;
    cell.iSModel = [InordertoshareModel mj_objectWithKeyValues:_dataListArr[indexPath.row]];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_type == 0||_type == 1) {
        return 160;
    }
   
    //计算单元格高度
    InordertoshareModel *iSModel = [InordertoshareModel mj_objectWithKeyValues:_dataListArr[indexPath.row]];
    NSString *content = iSModel.content;
    CGRect contentRect = [content boundingRectWithSize:CGSizeMake(KScreenWidth-57, 35) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil];
    NSArray *photoUrllist = iSModel.photoUrllist;
    CGFloat height = 0;
    if (photoUrllist.count == 0) {
        height = 0;
    }else if (photoUrllist.count <4){
        height = 90;
    }else if (photoUrllist.count < 7){
        height = 90*2;
    }
    float returnHeight = height + contentRect.size.height + 120;
    
    return returnHeight;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc] init];
//    headerView.backgroundColor = [UIColor redColor];
    NSArray *titles = @[@"夺宝记录",@"幸运记录",@"晒单记录"];
    //按钮
    for (int i = 0; i < 3; i ++) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = 200 + i;
        button.selected = NO;
        button.frame = CGRectMake(KScreenWidth/3*i, 0, KScreenWidth/3, 30);
        button.backgroundColor = [UIColor whiteColor];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        [button setTitleColor:[UIColor colorFromHexRGB:ThemeColor] forState:UIControlStateSelected];
        [button setTitle:titles[i] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:13];
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [headerView addSubview:button];
        
        if (i == _selectButtonTag - 200) {
//            button.selected = YES;
//            _selectButtonTag = 200;
        }
    }
    UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(0, 29, KScreenWidth, 1)];
    line.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    [headerView addSubview:line];
    //按钮下方的横线
    _lineView = [[UIImageView alloc] initWithFrame:CGRectMake(KScreenWidth/3*(_selectButtonTag-200), 29, KScreenWidth/3, 1)];
    _lineView.backgroundColor = [UIColor colorFromHexRGB:ThemeColor];
    [headerView addSubview:_lineView];
    
   
    return headerView;
}
#pragma mark - 按钮的点击
- (void)buttonAction:(UIButton *)button {
    
//    UIButton *selectButton = [self.view viewWithTag:_selectButtonTag];
//    
//    if (button.tag != _selectButtonTag) {
//        selectButton.selected = NO;
//        button.selected = YES;
//    }
    
//    [UIView animateWithDuration:0.15 animations:^{
//        
        _selectButtonTag = button.tag;
//        CGRect frame = _lineView.frame;
//        frame.origin.x = button.origin.x;
//        _lineView.frame = frame;
//    }];
    [self changeStateData:button.tag];
    
}

- (void)changeStateData:(NSInteger)tag {
    switch (tag) {
        case 200:
//            [self requestData:nil];
            _type = 0;
            _page = 1;
            [_tableView.mj_footer resetNoMoreData];
            [_dataListArr removeAllObjects];
            [self requestSnatchData];
//            [_tableView reloadData];
            break;
        case 201:
//            [self requestData:@1];
            _type = 1;
            _page = 1;
            [_tableView.mj_footer resetNoMoreData];
            [_dataListArr removeAllObjects];
            [self requestLuckyData];
            break;
        case 202:
//            [self requestData:@3];
            _type = 2;
            _page = 1;
            [_tableView.mj_footer resetNoMoreData];
            [_dataListArr removeAllObjects];
            [self requestShareData];
//            [_tableView reloadData];
            break;
            
        default:
            break;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (_type == 0) {
        
    }else if (_type == 1){
        
    }else if (_type == 2) {
        InordertoshareModel *iSModel = [InordertoshareModel mj_objectWithKeyValues:_dataListArr[indexPath.row]];
        
        InordertoDetailController *indVC = [[InordertoDetailController alloc] init];
        indVC.shareID = iSModel.ID;
        [self.navigationController pushViewController:indVC animated:YES];

    }
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    //    NSLog(@"%f",-scrollView.contentOffset.y);
    
    //取得表视图的偏移量
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY <= 0) {
        //计算放大倍数
       CGFloat scale = (160+ABS(offsetY))/160;
        _bgIconView.transform = CGAffineTransformMakeScale(scale, scale);
        _bgIconView.top = 0;
    }else {
        
        _bgIconView.top = -offsetY;

    }
    
    //使titleLabel与headerImgView底部重合
    //    _titleLabel.bottom = _headerImgView.bottom;
}

@end

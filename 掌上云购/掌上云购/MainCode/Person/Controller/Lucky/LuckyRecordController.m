//
//  LuckyRecordController.m
//  掌上云购
//
//  Created by 刘毅 on 16/8/9.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import "LuckyRecordController.h"
#import "LuckyRecordCell.h"
#import "RecordModel.h"
#import "ConfirmDataController.h"
#import "ConfirmGoodsController.h"
#import "GoodsDetailController.h"

@interface LuckyRecordController ()

@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,copy)NSString *identify;
@property (nonatomic,strong)NSMutableArray *data;
@property (nonatomic,assign)NSInteger page;

@property (nonatomic,strong)LoveView *loveView;//猜你喜欢

@property (nonatomic,strong)UIView *noView;

@end

@implementation LuckyRecordController

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
    [self requestData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"幸运记录";
    _page = 1;
    [self initNavBar];

    
    [self initTableView];
    
    [self createBottomView];
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
    
    NSString *url = [NSString stringWithFormat:@"%@%@",BASE_URL,LuckyNumberList_URL];
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
                      if (_data.count >0) {
                          _noView.hidden = YES;
                          _loveView.hidden = YES;
                      }else {
                          _noView.hidden = NO;
                          _loveView.hidden = NO;
                      }
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
- (void)initTableView {
//    _data = @[@{@"name":@"iPhone6s",@"isSure":@0,@"isGoods":@1},
//              @{@"name":@"iPhone6s",@"isSure":@1,@"isGoods":@1},
//              @{@"name":@"话费20元",@"isSure":@0,@"isGoods":@0}];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight-64) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    _identify = @"LuckyRecordCell";
    UINib *nib = [UINib nibWithNibName:@"LuckyRecordCell" bundle:nil];
    [_tableView registerNib:nib forCellReuseIdentifier:_identify];

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
- (void)createBottomView {
    
    CGFloat w = (KScreenWidth-8*4)/3;
    
    _loveView = [[LoveView alloc] initWithFrame:CGRectMake(0, KScreenHeight-w*1.4-37-64, KScreenWidth, w*1.4+35)];
    [self.view addSubview:_loveView];
    
    
    _noView = [[UIView alloc] initWithFrame:CGRectMake((KScreenWidth-220)/2, (KScreenHeight-240)/2-100, 220, 240)];
    //    _noView.backgroundColor = [UIColor grayColor];
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake((_noView.width-150)/2, 15, 150, 150)];
    imgView.image = [UIImage imageNamed:@"无记录"];
    [_noView addSubview:imgView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, imgView.bottom +5, _noView.width, 16)];
    label.text = @"你还没有记录哦";
    label.textColor = [UIColor darkGrayColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:13];
    [_noView addSubview:label];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake((_noView.width-85)/2, label.bottom+5, 85, 28);
    button.titleLabel.font = [UIFont systemFontOfSize:13];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitle:@"立即夺宝" forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"按钮背景-黄"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buyAction:) forControlEvents:UIControlEventTouchUpInside];
    [_noView addSubview:button];
    
    
    [self.view addSubview:_noView];
    
}
- (void)buyAction:(UIButton *)button{
    id next = [self nextResponder];
    while (next != nil) {
        
        if ([next isKindOfClass:[TabbarViewcontroller class]]) {
            
            //获得标签控制器
            TabbarViewcontroller *tb = (TabbarViewcontroller *)next;
            //修改索引
            tb.selectedIndex = 0;
            //原选中标签修改
            tb.selectedItem.isSelected = NO;
            //选中新标签
            TabbarItem *item = (TabbarItem *)[tb.view viewWithTag:1];
            item.isSelected = YES;
            //设置为上一个选中
            tb.selectedItem = item;
            
            return;
        }
        next = [next nextResponder];
    }
    
}

#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _data.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LuckyRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:_identify forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    RecordModel *rModel = [RecordModel mj_objectWithKeyValues:_data[indexPath.row]];
    cell.lkModel = rModel;
    __weak typeof(self) weakSelf = self;
    [cell setSuerBlock:^{
        [weakSelf confirmAddress:rModel];
    }];
    cell.isSunBtn.hidden = YES;
//    NSInteger orderStatus = [rModel.orderStatus integerValue];
//    if (orderStatus == 4) {
//    [cell.isSunBtn setTitle:@"分享" forState:UIControlStateNormal];
//    cell.isSunBtn.userInteractionEnabled = NO;
//    }else {
//        [cell.isSunBtn setTitle:@"未晒单" forState:UIControlStateNormal];
//    }
    
    if ([rModel.isVirtualgoods boolValue]) {
        //"orderStatus": "0",//订单状态，0：已支付1：已确认收货地址2：已发货3：已签收4：已晒单5：已确认物品6：已选择方式7：已发卡密或充值到余额（虚拟商品）8：未确认地址取消订单',
        NSInteger orderStatus = [rModel.orderStatus integerValue];
        switch (orderStatus) {
            case 4:
                [cell.goodsButton setTitle:@"已晒单" forState:UIControlStateNormal];
                break;

            case 5:
                [cell.goodsButton setTitle:@"选择使用方式" forState:UIControlStateNormal];
                break;
            case 6:
                [cell.goodsButton setTitle:@"等待充值" forState:UIControlStateNormal];
                break;
            case 7:
                [cell.goodsButton setTitle:@"晒单奖红包" forState:UIControlStateNormal];
                break;
            case 8:
                [cell.goodsButton setTitle:@"未确认订单已失效" forState:UIControlStateNormal];
                break;
                
            default:
                 [cell.goodsButton setTitle:@"确认商品" forState:UIControlStateNormal];
                break;
        }
        
    }else {
        NSInteger orderStatus = [rModel.orderStatus integerValue];
        switch (orderStatus) {
            case 0:
                [cell.goodsButton setTitle:@"确认地址" forState:UIControlStateNormal];
                break;
            case 1:
                [cell.goodsButton setTitle:@"等待发货" forState:UIControlStateNormal];
                break;
            case 2:
                [cell.goodsButton setTitle:@"待签收" forState:UIControlStateNormal];
                break;
            case 3:
                [cell.goodsButton setTitle:@"晒单奖红包" forState:UIControlStateNormal];
                break;
            case 4:
                [cell.goodsButton setTitle:@"已晒单" forState:UIControlStateNormal];
                break;
            case 8:
                [cell.goodsButton setTitle:@"未确认地址订单已失效" forState:UIControlStateNormal];
                break;
            default:
                [cell.goodsButton setTitle:@"确认地址" forState:UIControlStateNormal];
                break;
        }
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 158;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    RecordModel *rModel = [RecordModel mj_objectWithKeyValues:_data[indexPath.row]];
    GoodsDetailController *gsDVC = [[GoodsDetailController alloc] init];
    gsDVC.goodsId = rModel.ID;
    gsDVC.drawId = [NSString stringWithFormat:@"%ld",(long)rModel.saleDraw.drawId];
    gsDVC.isAnnounced = 3;
    [self.navigationController pushViewController:gsDVC animated:YES];
}
- (void)confirmAddress:(RecordModel *)rmodel {
    
    
    
    if ([rmodel.isVirtualgoods boolValue]) {
        ConfirmGoodsController *cgVC = [[ConfirmGoodsController alloc] init];
        cgVC.rcModel = rmodel;
        [self.navigationController pushViewController:cgVC animated:YES];
    }else {
        ConfirmDataController *cdVC = [[ConfirmDataController alloc] init];
        cdVC.rcModel = rmodel;
        [self.navigationController pushViewController:cdVC animated:YES];
    }
       

    
}


@end

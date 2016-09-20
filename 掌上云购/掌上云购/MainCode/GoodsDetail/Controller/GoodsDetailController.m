//
//  GoodsDetailController.m
//  掌上云购
//
//  Created by coco船长 on 16/8/16.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import "GoodsDetailController.h"
#import "UINavigationBar+Awesome.h"

@interface GoodsDetailController ()

@end

@implementation GoodsDetailController

- (void)initNavBar{
    
    self.navigationItem.backBarButtonItem = nil;
    UIButton *leftButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 28.f, 28.f)];
    leftButton.tag = 101;
    [leftButton setBackgroundImage:[UIImage imageNamed:@"返回-黑.png"]
                          forState:UIControlStateNormal];
    [leftButton addTarget:self
                   action:@selector(NavAction:)
         forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftItem;
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView

{
    UIColor * color = [UIColor colorFromHexRGB:ThemeColor];
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY > 50) {
        CGFloat alpha = MIN(1, 1 - ((50 + 64 - offsetY) / 64));
        [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:alpha]];
    } else {
        [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:0]];
    }
    
}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar lt_reset];
    self.navigationController.navigationBar.translucent = NO;
}
- (void)NavAction:(UIButton *)button{
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
#warning 商品详情可以从父控制器传过来
//    self.title = @"商品详情";
    
    _isJoind = 0;
    _isPrized = 1;
    _pageIndex = 1;
    
    _dataDic = [NSDictionary dictionary];
    //参与记录的数组
    _joinRecordArr = [NSMutableArray array];
    
    [self initNavBar];
    [self initViews];
    
}

#pragma mark - 创建子视图
- (void)initViews{

    _bgScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight - kNavigationBarHeight)];
    _bgScrollView.backgroundColor = [UIColor whiteColor];
    _bgScrollView.delegate = self;
    [self.view addSubview:_bgScrollView];
    
    _bgScrollView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        [self requestJoinList:_pageIndex];
        UIColor * color = [UIColor colorFromHexRGB:ThemeColor];
        _bgScrollView.delegate = nil;
        self.navigationController.navigationBar.translucent = NO;
        [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:1]];
        if (!_broughtHistoryView) {
            _broughtHistoryView = [[BroughtHistoryView alloc] initWithFrame:CGRectMake(0, KScreenHeight, KScreenWidth , KScreenHeight)];
            _broughtHistoryView.backgroundColor = [UIColor whiteColor];
            _broughtHistoryView.BHdelegate = self;
            [self.view insertSubview:_broughtHistoryView belowSubview:_bottomView];
//            [self.view addSubview:_broughtHistoryView];
        }
        
        [UIView animateWithDuration:0.5
                         animations:^{
                             _bgScrollView.top = - KScreenHeight;
                             _broughtHistoryView.top = 0;
                         }completion:^(BOOL finished) {
                             [_bgScrollView.mj_footer endRefreshing];
                         }];
        
    }];
    
    [self initTopView];
    [self initCenterView];
    [self initBottonView];

}

#pragma mark - broughtHistoryDelegate
- (void)pullBack{
    
    _pageIndex = 1;
    _joinRecordArr = [NSMutableArray array];
    [UIView animateWithDuration:0.5
                     animations:^{
                         _broughtHistoryView.top = KScreenHeight ;
                         _bgScrollView.top = 0;
                         _bgScrollView.delegate = self;
                         self.navigationController.navigationBar.translucent = YES;
                         UIColor * color = [UIColor colorFromHexRGB:ThemeColor];
                         CGFloat offsetY = _bgScrollView.contentOffset.y;
                         if (offsetY > 50) {
                             CGFloat alpha = MIN(1, 1 - ((50 + 64 - offsetY) / 64));
                             [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:alpha]];
                         } else {
                             [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:0]];
                         }
                     }];

}

//分区域视图
- (void)initTopView{

    //轮播图
    _topGoodImgView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenWidth *375 / 375) imagesGroup:nil];
    _topGoodImgView.placeholderImage = [UIImage imageNamed:@"placeholder"];
    _topGoodImgView.infiniteLoop = YES;
    _topGoodImgView.autoScroll = NO;
    _topGoodImgView.delegate = self;
    _topGoodImgView.dotColor = [UIColor colorFromHexRGB:ThemeColor];
    
    _topGoodImgView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    [_bgScrollView addSubview:_topGoodImgView];
    
    //获奖公告
    _jionTable = [[WingNotificationTableView alloc] initWithFrame:CGRectMake(0, _topGoodImgView.top, KScreenWidth, 20.f)];
    _jionTable.backgroundColor = [UIColor clearColor];
    NSArray *wingArr = @[@"4点12分，王力宏购买了1次",@"5点44分，周杰伦购买了20次",@"8点03分，李小龙购买了3次",@"7点24分，王宝强购买了8次",@"9点33分，习近平购买了50次"];
    _jionTable.dataArr = wingArr;
    _jionTable.timerDelegate = self;
    [_bgScrollView addSubview:_jionTable];
    
    _markImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, _topGoodImgView.bottom - 56.f, 32.f, 32.f)];
    _markImg.image = [UIImage imageNamed:@"10元标记"];
    [_topGoodImgView addSubview:_markImg];

    
}

#pragma mark - SDCycleScrollViewDelegate,WingTableDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    
    NSLogZS(@"点击了第几个:%ld",index);
    
}

- (void)WingNotificationTableViewTimerInvalidate{
    
    NSLogZS(@"在这里重新加载网络数据");
    
}

- (void)initCenterView{
    
    _goodsName = [[UILabel alloc] initWithFrame:CGRectMake(12.f, _topGoodImgView.bottom , KScreenWidth - 24.f, 40.f)];
    _goodsName.numberOfLines = 0;
    _goodsName.textColor = [UIColor darkGrayColor];
    _goodsName.font = [UIFont systemFontOfSize:13.f];
    _goodsName.textAlignment = NSTextAlignmentLeft;
    [_bgScrollView addSubview:_goodsName];
    
#warning 这里需要根据是否参与，是否结束等状态，改变视图内容和高度
    _oherFunctionTableView = [[GoodsDetailFunctionTableView alloc] initWithFrame:CGRectMake(0, _goodsName.bottom + 4.f, KScreenWidth, 275.f)];
    _oherFunctionTableView.isJoin = _isJoind;
    _oherFunctionTableView.isAnnounced = _isAnnounced;
    _oherFunctionTableView.isPrized = _isPrized;
    _oherFunctionTableView.backgroundColor = [UIColor whiteColor];
    [_bgScrollView addSubview:_oherFunctionTableView];
    
}

- (void)initBottonView{
    
    _bottomView = [[UIImageView alloc] initWithFrame:CGRectMake(0, KScreenHeight - kTabBarHeight, KScreenWidth, kTabBarHeight)];
    _bottomView.backgroundColor = [UIColor whiteColor];
    _bottomView.image = [UIImage imageNamed:@"标签栏背景"];
    [self.view addSubview:_bottomView];
    
    if (_isAnnounced == 1) {
    
        _buyNowButton = [[UIButton alloc] initWithFrame:CGRectMake(5, 10, KScreenWidth*2 / 5-10, 30)];
        [_buyNowButton setTitle:@"立即购买" forState:UIControlStateNormal];
        [_buyNowButton setBackgroundImage:[UIImage imageNamed:@"按钮背景"] forState:UIControlStateNormal];
        [_buyNowButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_buyNowButton addTarget:self
                          action:@selector(buyNowAction:)
                forControlEvents:UIControlEventTouchUpInside];
        [_bottomView addSubview:_buyNowButton];
        
        _addToCartButton = [[UIButton alloc] initWithFrame:CGRectMake(KScreenWidth*2 / 5+10, 10, KScreenWidth*2 / 5-10, 30)];
        [_addToCartButton setTitle:@"加入清单" forState:UIControlStateNormal];
        [_addToCartButton setTitleColor:[UIColor colorFromHexRGB:ThemeColor] forState:UIControlStateNormal];
        [_addToCartButton setBackgroundImage:[UIImage imageNamed:@"按钮框_亮"] forState:UIControlStateNormal];
        [_addToCartButton addTarget:self
                             action:@selector(addToCartAction:)
                   forControlEvents:UIControlEventTouchUpInside];
        [_bottomView addSubview:_addToCartButton];
        
        _cartBottomButton = [[UIButton alloc] initWithFrame:CGRectMake(KScreenWidth*4 / 5, 0, KScreenWidth*1 / 5, kTabBarHeight)];
        [_cartBottomButton setImage:[UIImage imageNamed:@"清单-selected"] forState:UIControlStateNormal];
        [_cartBottomButton addTarget:self
                              action:@selector(gotoCartAction:)
                    forControlEvents:UIControlEventTouchUpInside];
        [_bottomView addSubview:_cartBottomButton];
        
    }else{
    
        _gotoNewOrderButton = [[UIButton alloc] initWithFrame:CGRectMake(KScreenWidth * 2 / 3+15, 10, KScreenWidth / 3-30, 30)];
        [_gotoNewOrderButton setBackgroundImage:[UIImage imageNamed:@"按钮背景"] forState:UIControlStateNormal];
        _gotoNewOrderButton.titleLabel.font = [UIFont systemFontOfSize:12];
        [_gotoNewOrderButton setTitle:@"前往购买"
                             forState:UIControlStateNormal];
        [_gotoNewOrderButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_cartBottomButton addTarget:self
                              action:@selector(addToNewOrderAction:)
                    forControlEvents:UIControlEventTouchUpInside];
        [_bottomView addSubview:_gotoNewOrderButton];
        
        _newOrderNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth * 2 / 3, kTabBarHeight)];
        _newOrderNumLabel.text = @"  新一期正在火热进行中";
        _newOrderNumLabel.textColor = [UIColor darkGrayColor];
        _newOrderNumLabel.font = [UIFont systemFontOfSize:13];
        _newOrderNumLabel.textAlignment = NSTextAlignmentLeft;
        [_bottomView addSubview:_newOrderNumLabel];
    
    }
    [self requestData];
}

- (void)buyNowAction:(UIButton *)button{

    NSLogZS(@"现在购买");

}

- (void)addToCartAction:(UIButton *)button{

    //构建购物车数据模型
    //*注：关键字段：商品id，*商品名，商品类别，商品图片，总需次数，剩余次数，购买次数，购买价格
    NSMutableArray *picArr = [[_dataDic objectForKey:@"proPictureList"] mutableCopy];
    for (int i = 0; i < picArr.count; i ++) {
        
        NSMutableDictionary *dic = [[picArr objectAtIndex:i] mutableCopy];
        for (NSInteger j = dic.allKeys.count - 1 ; j >= 0 ; j --) {
            
            if ([[dic objectForKey:dic.allKeys[j]] isEqual:[NSNull null]]) {
                
                [dic removeObjectForKey:dic.allKeys[j]];
                
            }
            
        }
        [picArr replaceObjectAtIndex:i withObject:dic];
        
    }
    
    NSDictionary *goods = @{@"id":[_dataDic objectForKey:@"id"],
                            @"name":[_dataDic objectForKey:@"name"],
                            @"proPictureList":picArr,
                            @"totalShare":[_dataDic objectForKey:@"totalShare"],
                            @"surplusShare":[_dataDic objectForKey:@"surplusShare"],
                            @"buyTimes":[NSNumber numberWithInteger:1],
                            @"singlePrice":[_dataDic objectForKey:@"singlePrice"]};

                           
    BOOL isSuccess = [CartTools addCartList:@[goods]];
    NSLogZS(@"加入清单，成功了么%d",isSuccess);
    
}

- (void)gotoCartAction:(UIButton *)button{

    NSLogZS(@"进入购物车");
    id next = [self nextResponder];
    while (next != nil) {
        
        if ([next isKindOfClass:[TabbarViewcontroller class]]) {
            
            //获得标签控制器
            TabbarViewcontroller *tb = next;
            //修改索引
            tb.selectedIndex = 3;
            //原选中标签修改
            tb.selectedItem.isSelected = NO;
            //选中新标签
            TabbarItem *item = (TabbarItem *)[tb.view viewWithTag:4];
            item.isSelected = YES;
            //设置为上一个选中
            tb.selectedItem = item;
            
            return;
        }
        next = [next nextResponder];
    }
    
}

- (void)addToNewOrderAction:(UIButton *)button{

    GoodsDetailController *GDVC = [[GoodsDetailController alloc] init];
    GDVC.isJoind = 0;
    GDVC.isAnnounced = 0;
    GDVC.isPrized = 0;
    GDVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:GDVC
                                         animated:YES];

}

#pragma mari - lifeCircle
- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    
    if (_isAnnounced == 1) {
        
        if (_isJoind == 0) {
            
            _oherFunctionTableView.height = 275.f;
            
        }else if (_isJoind == 1){
            
            _oherFunctionTableView.height = 300.f;
            
        }
        
    }else if (_isAnnounced == 2){
        
        if (_isJoind == 0) {
            
            _oherFunctionTableView.height = 260.f;
            
        }else if (_isJoind == 1){
            
            _oherFunctionTableView.height = 285.f;
            
        }
        
    }else if (_isAnnounced == 3){
    
        if (_isJoind == 0) {
            
            _oherFunctionTableView.height = 308.f;
            
        }else if (_isJoind == 1){
            
            _oherFunctionTableView.height = 335.f;
            
        }
    
    }
    
    _bgScrollView.contentSize = CGSizeMake(KScreenWidth, _oherFunctionTableView.bottom);
    //导航栏透明
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.translucent = YES;
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor clearColor]];
    
}


#pragma mark 请求网络数据
- (void)requestData{
    
    [self requestDetail];
    
}

- (void)requestDetail{

    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    //取出存储的用户信息
    NSDictionary *userDic = [[NSUserDefaults standardUserDefaults] objectForKey:@"userDic"];
    if(userDic != nil){
        
        if (_isAnnounced != 1) {
            
            NSNumber *userId = userDic[@"id"];
//            [params setObject:@{@"drawId":_drawId,
//                                @"productId":_goodsId,
//                                @"userId":userId}
//                       forKey:@"paramsMap"];
            [params setObject:@{@"drawId":_drawId,
                                @"userId":userId}
                       forKey:@"paramsMap"];
        }else{
        
            NSNumber *userId = userDic[@"id"];
            [params setObject:@{@"productId":_goodsId,
                                @"userId":userId}
                       forKey:@"paramsMap"];
        
        }
        
    }else{
    
        if (_isAnnounced != 1) {
            
            [params setObject:@{@"drawId":_drawId,
                                @"productId":_goodsId}
                       forKey:@"paramsMap"];
            
        }else{
            
            [params setObject:@{@"productId":_goodsId}
                       forKey:@"paramsMap"];
            
        }
    
    }

    NSString *url = [NSString stringWithFormat:@"%@%@",BASE_URL,GoodsDetail_URL];
    
    [ZSTools post:url
           params:params
          success:^(id json) {
              
              bool isSuccess = [[json objectForKey:@"flag"] boolValue];
              if (isSuccess) {
                  
                  //商品图片
                  _dataDic = [json objectForKey:@"data"];
                  if ([_dataDic isEqual:[NSNull null]]) {
                      return;
                  }
                  if (![[_dataDic objectForKey:@"proPictureList"] isEqual:[NSNull null]]) {
                      
                      NSArray   *picDicArr = [_dataDic objectForKey:@"proPictureList"];
                      NSMutableArray *picArr = [NSMutableArray array];
                      for (int i = 0; i < picDicArr.count ; i ++) {
                          
                          NSDictionary *dic = [picDicArr objectAtIndex:i];
                          [picArr addObject:[dic objectForKey:@"img650"]];
                          
                      }
                      dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                          _topGoodImgView.imageURLStringsGroup = picArr;
                      });
                  }
                  
                  //商品名
                  _goodsName.text = [_dataDic objectForKey:@"name"];
                  
                  //商品状态信息
                  _oherFunctionTableView.dataDic = _dataDic;
                  //进度
//                  _oherFunctionTableView.goodSID = [_dataDic objectForKey:@"drawId"];
//                  NSInteger total =  [[_dataDic objectForKey:@"totalShare"] integerValue];
//                  NSInteger now = [[_dataDic objectForKey:@"sellShare"] integerValue];
//                  _oherFunctionTableView.progress = now * 100 / total ;
                  
                  //夺宝状态
                  
                  //是否参与
                  _isJoind = [[_dataDic objectForKey:@"isBuy"] integerValue];
                  
                  _drawId = [_dataDic objectForKey:@"drawId"];
                  
                  _oherFunctionTableView.isJoin = _isJoind;
                  _oherFunctionTableView.isPrized = _isPrized;
                  [_oherFunctionTableView reloadData];
                  
              }else{
              
                  NSLog(@"后台报错了");
                  
              }
              
          } failure:^(NSError *error) {
              
          }];

}

//参与记录
- (void)requestJoinList:(NSInteger) pageIndex{

    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:@{@"drawId":_drawId} forKey:@"paramsMap"];
    [params setObject:[NSNumber numberWithInteger:_pageIndex] forKey:@"page"];
    [params setObject:@"15" forKey:@"rows"];
    
    NSString *url = [NSString stringWithFormat:@"%@%@",BASE_URL,GoodsJoinRecords_URL];
    [ZSTools post:url
           params:params
          success:^(id json) {
              
              if ([json objectForKey:@"flag"]) {
              
                  _joinRecordArr = [json objectForKey:@"data"];
                  _broughtHistoryView.dataArr = _joinRecordArr;
              
              }
              
          } failure:^(NSError *error) {
              
          }];

}

#pragma mark - 重写set方法
- (void)setIsAnnounced:(NSInteger)isAnnounced{

    if (_isAnnounced != isAnnounced) {
        
        _isAnnounced = isAnnounced;
        if (_isAnnounced == 1) {

            _oherFunctionTableView.height = 275.f;
            
        }else if (_isAnnounced == 2){

            _oherFunctionTableView.height = 260.f;
            
        }else if (_isAnnounced == 3){
            
            _oherFunctionTableView.height = 308.f;
            
        }
        _bgScrollView.contentSize = CGSizeMake(KScreenWidth, _oherFunctionTableView.bottom);
        
    }

}

- (void)setIsJoind:(NSInteger)isJoind{

    if (_isJoind != isJoind) {
        
        _isJoind = isJoind;
        
        if (_isJoind == 0) {
            return;
        }else{
            _oherFunctionTableView.height = _oherFunctionTableView.height + 25.f;
        }
        
    }

}


- (void)setDrawId:(NSString *)drawId{

    if (_drawId != drawId) {
        
        _drawId = drawId;
        
    }
    
}

@end

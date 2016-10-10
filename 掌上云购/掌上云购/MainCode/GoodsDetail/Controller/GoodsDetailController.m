//
//  GoodsDetailController.m
//  掌上云购
//
//  Created by coco船长 on 16/8/16.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import "GoodsDetailController.h"
#import "UINavigationBar+Awesome.h"
#import "BuyNowController.h"
#import "MessageController.h"

@interface GoodsDetailController ()

@end

@implementation GoodsDetailController {
    //记录导航栏的透明度
    CGFloat _navBarAalpha;
}

- (void)initNavBar{
    
    self.automaticallyAdjustsScrollViewInsets = NO;
//    self.navigationController.navigationBar.translucent = YES;
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor clearColor]];
//    self.preferredStatusBarStyle = UIStatusBarStyleDefault;
    self.navigationItem.backBarButtonItem = nil;
    UIButton *leftButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 22.f, 22.f)];
    leftButton.tag = 101;
    [leftButton setBackgroundImage:[UIImage imageNamed:@"返回-黑.png"]
                          forState:UIControlStateNormal];
    [leftButton addTarget:self
                   action:@selector(NavAction:)
         forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    UIButton *rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 25.f, 7.f)];
    rightButton.tag = 102;
    [rightButton setBackgroundImage:[UIImage imageNamed:@"三点"]
                           forState:UIControlStateNormal];
    [rightButton addTarget:self
                    action:@selector(NavAction:)
          forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightItem;
    
}
#pragma mark - 根据偏移量导航栏渐变
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    UIColor * color = [UIColor colorFromHexRGB:ThemeColor];
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY > 60) {
        
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
        CGFloat alpha = MIN(1, 1 - ((60 + 64 - offsetY) / 64));
        [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:alpha]];
        if(alpha > 0.5) {
            UIButton *leftButton = [self.navigationController.navigationBar viewWithTag:101];
            leftButton.size = CGSizeMake(12, 18);
            [leftButton setBackgroundImage:[UIImage imageNamed:@"返回.png"]
                                  forState:UIControlStateNormal];
            UIButton *rightButton = [self.navigationController.navigationBar viewWithTag:102];
            rightButton.size = CGSizeMake(24, 24);
            [rightButton setBackgroundImage:[UIImage imageNamed:@"消息.png"]
                                  forState:UIControlStateNormal];
            _navBarAalpha = alpha;
            
        }else {
           
            [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
            UIButton *leftButton = [self.navigationController.navigationBar viewWithTag:101];
            leftButton.size = CGSizeMake(22, 22);
            [leftButton setBackgroundImage:[UIImage imageNamed:@"返回-黑.png"]
                                  forState:UIControlStateNormal];
            UIButton *rightButton = [self.navigationController.navigationBar viewWithTag:102];
            rightButton.size = CGSizeMake(25, 7);
            [rightButton setBackgroundImage:[UIImage imageNamed:@"三点.png"]
                                   forState:UIControlStateNormal];
        }
    } else{
        
        UIButton *leftButton = [self.navigationController.navigationBar viewWithTag:101];
        leftButton.size = CGSizeMake(22, 22);
        [leftButton setBackgroundImage:[UIImage imageNamed:@"返回-黑.png"]
                              forState:UIControlStateNormal];
        UIButton *rightButton = [self.navigationController.navigationBar viewWithTag:102];
        rightButton.size = CGSizeMake(25, 7);
        [rightButton setBackgroundImage:[UIImage imageNamed:@"三点.png"]
                               forState:UIControlStateNormal];
        [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:0]];
    }
    
}


- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [self.navigationController.navigationBar lt_reset];
    self.navigationController.navigationBar.translucent = NO;
    if (_joinListTimer) {
        [_joinListTimer invalidate];
        _joinListTimer = nil;
    }
    
}

- (void)NavAction:(UIButton *)button{
    
    if (button.tag == 101) {
        [self.navigationController popViewControllerAnimated:YES];
    }else {
        NSDictionary *userDic = [[NSUserDefaults standardUserDefaults] objectForKey:@"userDic"];
        if (userDic == nil) {
            LoginViewController *lVC = [[LoginViewController alloc] init];
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:lVC];
            [self presentViewController:nav animated:YES completion:nil];
            return;
        }
        MessageController *msgVC = [[MessageController alloc] init];
        self.navigationController.navigationBar.hidden = NO;
        msgVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:msgVC animated:YES];
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
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

    _bgScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight - kTabBarHeight)];
    _bgScrollView.backgroundColor = [UIColor whiteColor];
    _bgScrollView.delegate = self;
    _bgScrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_bgScrollView];
    
    _bgScrollView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        if (_joinListTimer) {
            
            [_joinListTimer invalidate];
            _joinListTimer = nil;
            
        }
        [self requestJoinList:_pageIndex];
        UIColor * color = [UIColor colorFromHexRGB:ThemeColor];
        _bgScrollView.delegate = nil;
        self.navigationController.navigationBar.translucent = NO;
        [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:1]];
        if (!_broughtHistoryView) {
            _broughtHistoryView = [[BroughtHistoryView alloc] initWithFrame:CGRectMake(0, KScreenHeight, KScreenWidth , KScreenHeight-64)];
            _broughtHistoryView.backgroundColor = [UIColor whiteColor];
            _broughtHistoryView.BHdelegate = self;
            [self.view insertSubview:_broughtHistoryView belowSubview:_bottomView];
            _broughtHistoryView.recordTable.mj_footer = [MJRefreshBackFooter footerWithRefreshingBlock:^{
                if (_pageIndex == 1) {
                    _pageIndex = 2;
                }
                [self requestJoinList:_pageIndex];
            }];
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
    
    //下拉时动画
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        
      
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
    _bgScrollView.mj_header = header;
    
    [self initTopView];
    [self initCenterView];
    [self initBottonView];
    
}

#pragma mark - broughtHistoryDelegate
- (void)pullBack{
    
    [self requestData];
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
    _topGoodImgView.backgroundColor = [UIColor whiteColor];
    _topGoodImgView.placeholderImage = [UIImage imageNamed:@"placeholder"];
    _topGoodImgView.infiniteLoop = YES;
    _topGoodImgView.autoScroll = NO;
    _topGoodImgView.delegate = self;
    _topGoodImgView.dotColor = [UIColor colorFromHexRGB:ThemeColor];
    
    _topGoodImgView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    [_bgScrollView addSubview:_topGoodImgView];
    
    _markImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, _topGoodImgView.bottom - 56.f, 32.f, 32.f)];
//    _markImg.image = [UIImage imageNamed:@"10元标记"];
    [_topGoodImgView addSubview:_markImg];

    
}

#pragma mark - SDCycleScrollViewDelegate,WingTableDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    
    NSLogZS(@"点击了第几个:%ld",index);
    
}


- (void)initCenterView{
    
    _goodsName = [[UILabel alloc] initWithFrame:CGRectMake(12.f, _topGoodImgView.bottom , KScreenWidth - 24.f, 40.f)];
    _goodsName.numberOfLines = 0;
    _goodsName.textColor = [UIColor darkGrayColor];
    _goodsName.font = [UIFont systemFontOfSize:13.f];
    _goodsName.textAlignment = NSTextAlignmentLeft;
    [_bgScrollView addSubview:_goodsName];
    
    //其他功能列表
    _oherFunctionTableView = [[GoodsDetailFunctionTableView alloc] initWithFrame:CGRectMake(0, _goodsName.bottom + 4.f, KScreenWidth, 275.f)];
    _oherFunctionTableView.isJoin = _isJoind;
    _oherFunctionTableView.isAnnounced = _isAnnounced;
    _oherFunctionTableView.isPrized = _isPrized;
    _oherFunctionTableView.backgroundColor = [UIColor whiteColor];
    [_bgScrollView addSubview:_oherFunctionTableView];
    
    __weak typeof(self) weakSelf = self;
//    __weak typeof(GoodsDetailFunctionTableView *) weakGdft = _oherFunctionTableView;
    [_oherFunctionTableView setCountDownBlock:^{
        
        [weakSelf requestDetail];
        
        
    }];
    
}

- (void)initBottonView{
    
    _bottomView = [[UIImageView alloc] initWithFrame:CGRectMake(0, KScreenHeight - kTabBarHeight, KScreenWidth, kTabBarHeight)];
    _bottomView.backgroundColor = [UIColor whiteColor];
    _bottomView.image = [UIImage imageNamed:@"标签栏背景"];
    _bottomView.userInteractionEnabled = YES;
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
        [_gotoNewOrderButton addTarget:self
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

}
#pragma mark - 立即购买
- (void)buyNowAction:(UIButton *)button{
    NSDictionary *userDic = [[NSUserDefaults standardUserDefaults] objectForKey:@"userDic"];
    if (userDic == nil) {
        LoginViewController *lVC = [[LoginViewController alloc] init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:lVC];
        [self presentViewController:nav animated:YES completion:nil];
        return;
    }
    NSLogZS(@"现在购买");
    BuyNowController *bnVC = [[BuyNowController alloc] init];
    bnVC.delegate = self;
    bnVC.maxNumber = [_dataDic[@"surplusShare"] integerValue];
    bnVC.singlePrice = [[_dataDic objectForKey:@"singlePrice"] integerValue];
    [self presentViewController:bnVC animated:YES completion:nil];

}

#pragma mark - BuyNowControllerDelegate
- (void)backBuyNumber:(NSInteger)buyNumber {

    NSLog(@"buyNumber%ld",buyNumber);
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
                            @"buyTimes":[NSNumber numberWithInteger:buyNumber],
                            @"singlePrice":[_dataDic objectForKey:@"singlePrice"]};
    
    PayViewController *VC = [[PayViewController alloc]init];
    VC.isimidiately = @"2";
    VC.hidesBottomBarWhenPushed = YES;
    VC.immidiatelyArr = @[goods];
    [self.navigationController pushViewController:VC animated:YES];
    
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
    
    //强行去掉为空字段
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
    if (isSuccess) {
        
        [self getRootController].cartNum = [CartTools getCartList].count;
        [self showHUD:@"正在加入购物车"];
        [self hideSuccessHUD:@"加入购物车成功"];
   
    }
    
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
    GDVC.isAnnounced = 1;
    GDVC.goodsId = _goodsId;
    GDVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:GDVC
                                         animated:YES];

}

#pragma mari - lifeCircle
- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    [self requestData];
    
    if (_isAnnounced == 1) {
        
        if (_isJoind == 0) {
            
            _oherFunctionTableView.height = 275.f+30;
            
        }else if (_isJoind == 1){
            
            _oherFunctionTableView.height = 300.f+50;
            
        }
        
    }else if (_isAnnounced == 2){
        
        if (_isJoind == 0) {
            
            _oherFunctionTableView.height = 260.f;
            
        }else if (_isJoind == 1){
            
            _oherFunctionTableView.height = 285.f;
            
        }
        
    }else if (_isAnnounced == 3){
    
        if (_isJoind == 0) {
            
            _oherFunctionTableView.height = 308.f+70;
            
        }else if (_isJoind == 1){
            
            _oherFunctionTableView.height = 335.f+70;
            
        }
    
    }
    
    _bgScrollView.contentSize = CGSizeMake(KScreenWidth, _oherFunctionTableView.bottom);
    //导航栏透明
    self.navigationController.navigationBar.translucent = YES;
    UIColor * color = [UIColor colorFromHexRGB:ThemeColor];
    [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:_navBarAalpha]];

}

#pragma mark 请求网络数据
- (void)requestData{
    
    [self requestDetail];
    
}

- (void)requestJoinList{

    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:_drawId forKey:@"drawId"];
    
    NSString *url = [NSString stringWithFormat:@"%@%@",BASE_URL,GoodsJoinNotificate_URL];
    
    [ZSTools post:url
           params:params
          success:^(id json) {
              
              if ([[json objectForKey:@"flag"] boolValue]) {
                  
                  _joinListArr = [NSMutableArray array];
                  _joinListArr = [json objectForKey:@"data"];
                  if (_joinListArr.count > 0) {
                      
                      if (_joinListTimer) {
                          [_joinListTimer invalidate];
                          
                      }
                      _timerProcess = 0;
                      _joinListTimer = [NSTimer scheduledTimerWithTimeInterval:10
                                                                        target:self
                                                                      selector:@selector(notificationAnimation)
                                                                      userInfo:nil
                                                                       repeats:YES];
                      
                  }
                  
              }
              
          } failure:^(NSError *error) {
              
          }];

}

- (void)notificationAnimation{
    
    if (_timerProcess == _joinListArr.count) {
        [_joinListTimer invalidate];
        return;
    }
    //参与公告
    NSDictionary *dataDic = [_joinListArr objectAtIndex:_timerProcess];
    _timerProcess ++;
    _joinView = [[UIView alloc] initWithFrame:CGRectMake(0, _topGoodImgView.top + 64.f, KScreenWidth, 0)];
    _joinView.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.3];
    [self.view addSubview:_joinView];
    
//    _joinImageView = [[UIImageView alloc] initWithFrame:CGRectMake(12.f, 0.f, 24.f, 0)];
//    [_joinImageView setImageWithURL:[NSURL URLWithString:@""]
//                   placeholderImage:[UIImage imageNamed:@"我的-头像"]];
//    _joinImageView.layer.cornerRadius = 12;
//    _joinImageView.layer.masksToBounds = YES;
//    _joinImageView.layer.borderColor = [[UIColor whiteColor] CGColor];
//    _joinImageView.layer.borderWidth = 0.5;
//    [_joinView addSubview:_joinImageView];
    
    _joinLabel  = [[UILabel alloc] initWithFrame:CGRectMake(12.f, 4, KScreenWidth - 54.f, 0)];
    _joinLabel.text = [NSString stringWithFormat:@"%@参与了%@人次",[dataDic objectForKey:@"nickName"],[dataDic objectForKey:@"qty"]];
    _joinLabel.textColor = [UIColor whiteColor];
    _joinLabel.font = [UIFont systemFontOfSize:12];
    _joinLabel.textAlignment = NSTextAlignmentLeft;
    [_joinView addSubview:_joinLabel];

    [UIView animateWithDuration:0.5
                     animations:^{
                         
                         _joinView.height = 24.f;
                         _joinImageView.height = 24.f;
                         _joinLabel.height = 16.f;
                         
                     } completion:^(BOOL finished) {
                         
                         [self performSelector:@selector(cameBackAction)
                                    withObject:nil
                                    afterDelay:2];
                         
                     }];

}

- (void)cameBackAction{

    [UIView animateWithDuration:0.5
                     animations:^{
                         
                         _joinView.height = 0;
                         _joinImageView.height = 0;
                         _joinLabel.height = 0;
                         
                     } completion:nil];
    
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
    [self showHUD:@"正在加载数据"];
    [ZSTools post:url
           params:params
          success:^(id json) {
              
              bool isSuccess = [[json objectForKey:@"flag"] boolValue];
               [_bgScrollView.mj_header endRefreshing];
              if (isSuccess) {
                 
                  [self hideSuccessHUD:@"加载成功"];
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
//                      dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                          _topGoodImgView.imageURLStringsGroup = picArr;
//                      });
                  }
                  NSArray *proAttrList = [_dataDic objectForKey:@"proAttrList"];
                  if (proAttrList.count != 0) {
                      [_markImg setImageWithURL:[NSURL URLWithString:[proAttrList[0] objectForKey:@"photoUrl"]]
                                           placeholderImage:[UIImage new]];
                  }else {
                      _markImg.image = [UIImage new];
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
                  if (![_dataDic[@"saleDraw"] isKindOfClass:[NSNull class]]) {
                      self.isJoind = [[_dataDic objectForKey:@"isBuy"] integerValue];
                      
                      _drawId = [_dataDic objectForKey:@"drawId"];
                      
                      _oherFunctionTableView.isAnnounced = 3;
                      self.isAnnounced = 3;
                      _oherFunctionTableView.isJoin = _isJoind;
                      _oherFunctionTableView.isPrized = _isPrized;
                      [_oherFunctionTableView reloadData];

                  }else {
                      
                      //是否参与
                      self.isJoind = [[_dataDic objectForKey:@"isBuy"] integerValue];
                      
                      _drawId = [_dataDic objectForKey:@"drawId"];
                      
                      _oherFunctionTableView.isJoin = _isJoind;
                      _oherFunctionTableView.isPrized = _isPrized;
                      [_oherFunctionTableView reloadData];
                  }
                  
                  [self requestJoinList];
                  
              }else{
              
                  NSLogZS(@"后台报错了");
                  [self hideFailHUD:@"加载失败"];
                  [self.navigationController popViewControllerAnimated:YES];
                  
              }
              
          } failure:^(NSError *error) {
              
              [self hideFailHUD:@"加载失败"];
              
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
                  
                  NSArray *dataArr = json[@"data"];
                  if (_pageIndex == 1) {
                      [_joinRecordArr removeAllObjects];
                      _joinRecordArr = dataArr.mutableCopy;
                      
                      [_broughtHistoryView.recordTable.mj_footer resetNoMoreData];
                      
                  }
                  
                  if (_pageIndex != 1 && _pageIndex != 0) {
                      if (dataArr.count > 0) {
                          _pageIndex ++;
                          [_joinRecordArr addObjectsFromArray:dataArr];
                          [_broughtHistoryView.recordTable.mj_footer endRefreshing];
                      }else {
                          [_broughtHistoryView.recordTable.mj_footer endRefreshingWithNoMoreData];
                      }
                  }
                  _broughtHistoryView.dataArr = _joinRecordArr;
                  [_broughtHistoryView.recordTable reloadData];
              }
           
              
          } failure:^(NSError *error) {
              
          }];

}

#pragma mark - 重写set方法
- (void)setIsAnnounced:(NSInteger)isAnnounced{

    if (_isAnnounced != isAnnounced) {
        
        _isAnnounced = isAnnounced;
//        if (_isAnnounced == 1) {
//
//            _oherFunctionTableView.height = 275.f;
//            
//        }else if (_isAnnounced == 2){
//
//            _oherFunctionTableView.height = 260.f;
//            
//        }else if (_isAnnounced == 3){
//            
//            _oherFunctionTableView.height = 308.f;
//            
//        }
        if (_isAnnounced == 1) {
            
            if (_isJoind == 0) {
                
                _oherFunctionTableView.height = 275.f+30;
                
            }else if (_isJoind == 1){
                
                _oherFunctionTableView.height = 300.f+50;
                
            }
            
        }else if (_isAnnounced == 2){
            
            if (_isJoind == 0) {
                
                _oherFunctionTableView.height = 260.f;
                
            }else if (_isJoind == 1){
                
                _oherFunctionTableView.height = 285.f;
                
            }
            
        }else if (_isAnnounced == 3){
            
            if (_isJoind == 0) {
                
                _oherFunctionTableView.height = 308.f+70;
                
            }else if (_isJoind == 1){
                
                _oherFunctionTableView.height = 335.f+70;
                
            }
            
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
            _oherFunctionTableView.height = _oherFunctionTableView.height +25.f;
        }
        _bgScrollView.contentSize = CGSizeMake(KScreenWidth, _oherFunctionTableView.bottom);
        
    }

}


- (void)setDrawId:(NSString *)drawId{

    if (_drawId != drawId) {
        
        _drawId = drawId;
        
    }
    
}

- (TabbarViewcontroller *)getRootController{
    
    UIApplication *app = [UIApplication sharedApplication];
    UIWindow *windows = app.keyWindow;
    return (TabbarViewcontroller *)windows.rootViewController;
    
}

@end

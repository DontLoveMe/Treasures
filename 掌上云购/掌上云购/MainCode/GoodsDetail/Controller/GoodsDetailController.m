//
//  GoodsDetailController.m
//  掌上云购
//
//  Created by coco船长 on 16/8/16.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import "GoodsDetailController.h"

@interface GoodsDetailController ()

@end

@implementation GoodsDetailController

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
    
#warning 商品详情可以从父控制器传过来
    self.title = @"商品详情";
    
    [self initNavBar];
    [self initViews];
    
}

#pragma mark - 创建子视图
- (void)initViews{

    _bgScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight - kNavigationBarHeight - kTabBarHeight)];
    _bgScrollView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_bgScrollView];
    
    _bgScrollView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        NSLogZS(@"上拉了");
        
        if (!_broughtHistoryView) {
            _broughtHistoryView = [[BroughtHistoryView alloc] initWithFrame:CGRectMake(0, KScreenHeight - kNavigationBarHeight, KScreenWidth , KScreenHeight - kNavigationBarHeight)];
            _broughtHistoryView.backgroundColor = [UIColor whiteColor];
            _broughtHistoryView.BHdelegate = self;
            [self.view addSubview:_broughtHistoryView];
        }
        
        [UIView animateWithDuration:0.5
                         animations:^{
                             _bgScrollView.top = kNavigationBarHeight - KScreenHeight;
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
    
    [UIView animateWithDuration:0.5
                     animations:^{
                         _broughtHistoryView.top = KScreenHeight - kNavigationBarHeight;
                         _bgScrollView.top = 0;
                     }];

}

//分区域视图
- (void)initTopView{

    //轮播图
    NSArray *imgArr = @[[UIImage imageNamed:@"商品_1"],[UIImage imageNamed:@"商品_2"],[UIImage imageNamed:@"商品_3"],[UIImage imageNamed:@"商品_4"],[UIImage imageNamed:@"商品_5"]];
    _topGoodImgView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenWidth *375 / 375) imagesGroup:imgArr];
    _topGoodImgView.placeholderImage = [UIImage imageNamed:@"placeholder"];
    _topGoodImgView.infiniteLoop = YES;
    _topGoodImgView.delegate = self;
    _topGoodImgView.dotColor = [UIColor redColor];
    
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
    _goodsName.text = @"Apple iPhone6s Plus 16G \"_\" 唯一的不同，是处处不同";
    _goodsName.numberOfLines = 0;
    _goodsName.textColor = [UIColor redColor];
    _goodsName.font = [UIFont systemFontOfSize:13.f];
    _goodsName.textAlignment = NSTextAlignmentLeft;
    [_bgScrollView addSubview:_goodsName];
    
#warning 这里需要根据是否参与，是否结束等状态，改变视图内容和高度
    _oherFunctionTableView = [[GoodsDetailFunctionTableView alloc] initWithFrame:CGRectMake(0, _goodsName.bottom + 4.f, KScreenWidth, 275.f)];
//    _oherFunctionTableView = [[GoodsDetailFunctionTableView alloc] initWithFrame:CGRectMake(0, _goodsName.bottom + 4.f, KScreenWidth, 300.f)];
    _oherFunctionTableView.isJoin = _isJoind;
    _oherFunctionTableView.isAnnounced = _isAnnounced;
    _oherFunctionTableView.isPrized = _isPrized;
    _oherFunctionTableView.backgroundColor = [UIColor whiteColor];
    [_bgScrollView addSubview:_oherFunctionTableView];
    
}

- (void)initBottonView{
    
    _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, KScreenHeight - kNavigationBarHeight - kTabBarHeight, KScreenWidth, kTabBarHeight)];
    _bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_bottomView];
    
    if (_isAnnounced == 0) {
    
        _buyNowButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth / 3, kTabBarHeight)];
        [_buyNowButton setTitle:@"立即购买" forState:UIControlStateNormal];
        [_buyNowButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [_buyNowButton addTarget:self
                          action:@selector(buyNowAction:)
                forControlEvents:UIControlEventTouchUpInside];
        [_bottomView addSubview:_buyNowButton];
        
        _addToCartButton = [[UIButton alloc] initWithFrame:CGRectMake(KScreenWidth / 3, 0, KScreenWidth / 3, kTabBarHeight)];
        [_addToCartButton setTitle:@"加入清单" forState:UIControlStateNormal];
        [_addToCartButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [_addToCartButton addTarget:self
                             action:@selector(addToCartAction:)
                   forControlEvents:UIControlEventTouchUpInside];
        [_bottomView addSubview:_addToCartButton];
        
        _cartBottomButton = [[UIButton alloc] initWithFrame:CGRectMake(KScreenWidth * 2 / 3, 0, KScreenWidth / 3, kTabBarHeight)];
        [_cartBottomButton setTitle:@"进入购物车" forState:UIControlStateNormal];
        [_cartBottomButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [_cartBottomButton addTarget:self
                              action:@selector(addToCartAction:)
                    forControlEvents:UIControlEventTouchUpInside];
        [_bottomView addSubview:_cartBottomButton];
        
    }else{
    
        _gotoNewOrderButton = [[UIButton alloc] initWithFrame:CGRectMake(KScreenWidth * 2 / 3, 0, KScreenWidth / 3, kTabBarHeight)];
        [_gotoNewOrderButton setTitle:@"前往新一期"
                             forState:UIControlStateNormal];
        [_gotoNewOrderButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [_cartBottomButton addTarget:self
                              action:@selector(addToNewOrderAction:)
                    forControlEvents:UIControlEventTouchUpInside];
        [_bottomView addSubview:_gotoNewOrderButton];
        
        _newOrderNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth * 2 / 3, kTabBarHeight)];
        _newOrderNumLabel.text = @"新一期正在火热进行";
        _newOrderNumLabel.textColor = [UIColor redColor];
        _newOrderNumLabel.font = [UIFont systemFontOfSize:13];
        _newOrderNumLabel.textAlignment = NSTextAlignmentLeft;
        [_bottomView addSubview:_newOrderNumLabel];
    
    }
    
}

- (void)buyNowAction:(UIButton *)button{

    NSLogZS(@"现在购买");

}

- (void)addToCartAction:(UIButton *)button{

    NSLogZS(@"加入清单");

}

- (void)gotoCartAction:(UIButton *)button{

    NSLogZS(@"进入购物车");
    
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
    
    if (_isAnnounced == 0) {
        
        if (_isJoind == 0) {
            
            _oherFunctionTableView.height = 275.f;
            
        }else if (_isJoind == 1){
            
            _oherFunctionTableView.height = 300.f;
            
        }
        
    }else if (_isAnnounced == 1){
        
        if (_isJoind == 0) {
            
            _oherFunctionTableView.height = 260.f;
            
        }else if (_isJoind == 1){
            
            _oherFunctionTableView.height = 285.f;
            
        }
        
    }else if (_isAnnounced == 2){
    
        if (_isJoind == 0) {
            
            _oherFunctionTableView.height = 308.f;
            
        }else if (_isJoind == 1){
            
            _oherFunctionTableView.height = 335.f;
            
        }
    
    }
    
    _bgScrollView.contentSize = CGSizeMake(KScreenWidth, _oherFunctionTableView.bottom);

}

@end

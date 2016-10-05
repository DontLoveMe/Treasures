//
//  HomeViewController.m
//  掌上云购
//
//  Created by coco船长 on 16/8/3.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import "HomeViewController.h"
#import "BannerDetailController.h"


@interface HomeViewController ()

@end

@implementation HomeViewController
- (void)initNavBar{
    
    self.navigationItem.backBarButtonItem = nil;
    UIButton *leftButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 25.f, 25.f)];
    leftButton.tag = 101;
    [leftButton setBackgroundImage:[UIImage imageNamed:@"首页_搜索.png"]
                          forState:UIControlStateNormal];
    [leftButton addTarget:self
                   action:@selector(NavAction:)
         forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    UIButton *rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 24, 24)];
    rightButton.tag = 102;
    [rightButton setBackgroundImage:[UIImage imageNamed:@"消息.png"]
                           forState:UIControlStateNormal];;
    [rightButton addTarget:self
                    action:@selector(NavAction:)
          forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightItem;
    
}

- (void)NavAction:(UIButton *)button{
    
    if (button.tag == 101) {
        HomeSearchController *HSVC = [[HomeSearchController alloc] init];
        HSVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:HSVC
                                             animated:YES];
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
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //初始化数据
    _goodsArr = [NSMutableArray array];
    //banner数据
    _bannerArr = [NSMutableArray array];
    //页码
    _page = 1;
    //选的第几个
    _selectIndext = 0;
    
    [self initNavBar];
    [self initViews];
    
}

#pragma makr - initView
- (void)initViews{

    _bgScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight - kNavigationBarHeight - kTabBarHeight)];
    _bgScrollView.backgroundColor = [UIColor whiteColor];
    _bgScrollView.showsVerticalScrollIndicator = NO;
    _bgScrollView.delegate = self;
    
    //下拉时动画
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
       
        _selectIndext = 0;
        _page = 1;
        [self requestData];
        
        [self requsetBanner];
        
        [self requestPrizeList];
        
        [self performSelector:@selector(endRefreshAction)
                   withObject:nil
                   afterDelay:2.f];
        
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
    [header setTitle:@" 正在刷新... " forState:MJRefreshStateRefreshing];
    _bgScrollView.mj_header = header;
    
    //加footer及方法
    MJRefreshAutoFooter *footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        if (_page == 1) {
            
            _page = 2;
        }
        switch (_selectIndext) {
            case 0:
                [self requestGoodsList:@"3" withPage:_page];
                break;
            case 1:
                [self requestGoodsList:@"2" withPage:_page];
                break;
            case 2:
                [self requestGoodsList:@"1" withPage:_page];
                break;
            case 3:
                [self requestGoodsList:@"4" withPage:_page];
                break;
            default:
                break;
        }
        
    }];
    _bgScrollView.mj_footer = footer;
    
    [self.view addSubview:_bgScrollView];
    
    [self initTopView];
    [self initCenterView];
    [self initBottomView];

}

- (void)endRefreshAction{

    MJRefreshGifHeader *header = (MJRefreshGifHeader *)_bgScrollView.mj_header;
    [header setTitle:@"刷新成功!" forState:MJRefreshStateIdle];
    [_bgScrollView.mj_header endRefreshingWithCompletionBlock:^{
        [header setTitle:@"下拉刷新数据" forState:MJRefreshStateIdle];
    }];
    
}

#pragma mark - top，center，bottom
- (void)initTopView{

    //轮播图
    _topBannerView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenWidth *200 / 375) imagesGroup:nil];
    _topBannerView.placeholderImage = [UIImage imageNamed:@"首页轮播_1.jpg"];
    _topBannerView.infiniteLoop = YES;
    _topBannerView.delegate = self;
    _topBannerView.dotColor = [UIColor colorFromHexRGB:ThemeColor];
    _topBannerView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    [_bgScrollView addSubview:_topBannerView];

    
    //获奖公告
    _wingTable = [[WingNotificationTableView alloc] initWithFrame:CGRectMake(0, _topBannerView.bottom - 20.f, KScreenWidth, 20.f)];
    _wingTable.backgroundColor = [UIColor clearColor];
    [_bgScrollView addSubview:_wingTable];

}

#pragma mark - SDCycleScrollViewDelegate,WingTableDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    
    NSLogZS(@"点击了第几个:%ld",index);
    BannerDetailController *banner = [[BannerDetailController alloc] init];
    NSDictionary *dic = _bannerArr[index];
    if (![dic[@"linkUrl"] isKindOfClass:[NSNull class]]) {
        banner.htmlUrl = dic[@"linkUrl"];
    }
    if (![dic[@"remarks"] isKindOfClass:[NSNull class]]) {
        
        banner.title = dic[@"remarks"];
    }
    banner.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:banner animated:YES];
    
    
}

- (void)WingNotificationTableViewTimerInvalidate{
    
    [self requestPrizeList];
    
}

- (void)initCenterView{

    _functionView = [[UIView alloc] initWithFrame:CGRectMake(0, _topBannerView.bottom, KScreenWidth, 112.f)];
    _functionView.backgroundColor = [UIColor colorFromHexRGB:@"D0D0D0"];
    [_bgScrollView addSubview:_functionView];
    
    NSArray *titleArr = @[@"分类",@"十元专区",@"极速专区",@"晒单"];
    for (int i = 0; i < titleArr.count; i ++) {
        
        HomeFunctionControl *functionControl = [[HomeFunctionControl alloc] initWithFrame:CGRectMake(KScreenWidth * i / 4, 0, KScreenWidth / 4, 100.f)];
        functionControl.tag = i+300;
        functionControl.controlFlag = titleArr[i];
        [functionControl addTarget:self
                            action:@selector(controlAction:)
                  forControlEvents:UIControlEventTouchUpInside];
        [_functionView addSubview:functionControl];
        
    }
    
}

- (void)controlAction:(HomeFunctionControl *)control{

    NSLogZS(@"选择了这个功能");
    if (control.tag != 3+300) {
       
        switch (control.tag) {
            case 300:
            {
                SegmentController *SVC = [[SegmentController alloc] init];
                SVC.index = 0;
                SVC.title = control.controlFlag;
                [self.navigationController pushViewController:SVC
                                                     animated:YES];
            }
                
                break;
            case 301:
            {
                SegmentController *SVC = [[SegmentController alloc] init];
                SVC.index = 1;
                SVC.title = control.controlFlag;
                [self.navigationController pushViewController:SVC
                                                     animated:YES];
            }
                
                break;
            case 302:
            {
                SegmentController *SVC = [[SegmentController alloc] init];
                SVC.index = 2;
                 SVC.title = control.controlFlag;
                [self.navigationController pushViewController:SVC
                                                     animated:YES];
            }
                
                break;
                
            default:
                break;
        }
        
    }else{
    
        SunSharingViewController *VC = [[SunSharingViewController alloc]init];
        VC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:VC animated:YES];
        
    }

    
}

- (void)initBottomView{
    
    _segmentView = [[UIView alloc] initWithFrame:CGRectMake(0, _functionView.bottom + 4.f, KScreenWidth, 40.f)];
    _segmentView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_segmentView];
    
    NSArray *segmentArr = @[@"人气",@"最新",@"最热",@"总需人次"];
    float width = KScreenWidth / 4;
    _selectIndext = 0;
    for (int i = 0 ; i < segmentArr.count; i ++) {
        
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(width * i, 0, width, 39.f)];
        [button setTitle:segmentArr[i]
                forState:UIControlStateNormal];
        [button setTitle:segmentArr[i]
                forState:UIControlStateSelected];
        [button setTitleColor:[UIColor colorFromHexRGB:@"6F6F6F"] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorFromHexRGB:@"6F6F6F"] forState:UIControlStateSelected];
        button.titleLabel.font = [UIFont systemFontOfSize:13];
        button.tag = 100 + i;
        [button addTarget:self
                   action:@selector(selectAction:)
         forControlEvents:UIControlEventTouchUpInside];
        [_segmentView addSubview:button];
        
    }
    
    UIImageView *lineView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 39, KScreenWidth, 1)];
    lineView.backgroundColor = [UIColor colorFromHexRGB:@"EAEAEA"];
    [_segmentView addSubview:lineView];
    
    UIImageView *selectImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 39, KScreenWidth / 4, 2)];
    selectImg.backgroundColor = [UIColor colorFromHexRGB:ThemeColor];
    selectImg.tag = 50;
    [_segmentView addSubview:selectImg];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //设置滑动方向
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    //设置单元格的间隙
    layout.minimumInteritemSpacing = 1;
    layout.minimumLineSpacing = 1;
    layout.itemSize = CGSizeMake((KScreenWidth - 1) / 2  , (KScreenWidth - 1) * 11 / 20);
    _goodsList = [[UICollectionView alloc] initWithFrame:CGRectMake(0, _segmentView.bottom + 1, KScreenWidth, KScreenHeight - kNavigationBarHeight - kTabBarHeight - 40.f) collectionViewLayout:layout];
    _goodsList.scrollEnabled = NO;
    _goodsList.backgroundColor = [UIColor colorFromHexRGB:@"EAEAEA"];
    _goodsList.delegate = self;
    _goodsList.dataSource = self;
    [_goodsList registerNib:[UINib nibWithNibName:@"HomeGoodsCell"
                                           bundle:[NSBundle mainBundle]]
 forCellWithReuseIdentifier:@"HomeGoods_Cell"];
    [_goodsList registerNib:[UINib nibWithNibName:@"HomeGoodsHeadView"
                                           bundle:[NSBundle mainBundle]]
 forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
        withReuseIdentifier:@"HomeGoodsHead_View"];
    [_bgScrollView  addSubview:_goodsList];
    
}

- (void)selectAction:(UIButton *)button{

    _selectIndext= button.tag - 100;
    
    UIImageView *imageView = [self.view viewWithTag:50];
    [UIView animateWithDuration:0.5
                     animations:^{
                        
                         imageView.centerX = button.centerX;
                         
                     }];
    _page = 1;
    switch (_selectIndext) {
        case 0:
            [self requestGoodsList:@"3" withPage:_page];
            break;
        case 1:
            [self requestGoodsList:@"2" withPage:_page];
            break;
        case 2:
            [self requestGoodsList:@"1" withPage:_page];
            break;
        case 3:
            [self requestGoodsList:@"7" withPage:_page];
            break;
        default:
            break;
    }
    
}

#pragma mark -- 集合视图的数据源方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return _goodsArr.count;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    HomeGoodsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeGoods_Cell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    
    NSDictionary *dic = [_goodsArr objectAtIndex:indexPath.row];
    
    cell.goodsName.text = [dic objectForKey:@"name"];
    NSInteger progressCount = [[dic objectForKey:@"sellShare"] floatValue] * 100 / [[dic objectForKey:@"totalShare"] floatValue];
    cell.progressLabel.text = [NSString stringWithFormat:@"当前进度%ld%%",progressCount];
    cell.progressView.progress = progressCount;
    NSArray *picList = [dic objectForKey:@"proPictureList"];
    if (picList.count != 0) {
        
        [cell.goodsPic setImageWithURL:[NSURL URLWithString:[picList[0] objectForKey:@"img170"]]
                      placeholderImage:[UIImage imageNamed:@"未加载图片"]];
    
    }else {
        cell.goodsPic.image = [UIImage imageNamed:@"未加载图片"];
    }
    NSArray *proAttrList = [dic objectForKey:@"proAttrList"];
    if (proAttrList.count != 0) {
        [cell.typeMarkImgView setImageWithURL:[NSURL URLWithString:[proAttrList[0] objectForKey:@"photoUrl"]]
                             placeholderImage:[UIImage new]];
    }else {
        cell.typeMarkImgView.image = [UIImage new];
    }

    cell.nowIndexpath = indexPath;
    cell.delegate = self;
    cell.dataDic = dic;
    
    return cell;
}


- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{

    return UIEdgeInsetsMake(0, 0, 0, 0);
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    NSLogZS(@"选择了第%ld个",indexPath.row);
    NSDictionary *dic = [_goodsArr objectAtIndex:indexPath.row];
    
    GoodsDetailController *GDVC = [[GoodsDetailController alloc] init];
    GDVC.goodsId = [dic objectForKey:@"id"];
    GDVC.drawId = [dic objectForKey:@"drawId"];
    GDVC.isAnnounced = 1;
    GDVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:GDVC
                                         animated:YES];

}

#pragma mark - 加入购物车成功的动画
- (void)addToCartWithIndexpath:(NSIndexPath *)nowIndexpath{

    //数据
    NSDictionary *dic = [_goodsArr objectAtIndex:nowIndexpath.row];
    
    //设置动画图片初始位置
    HomeGoodsCell *cell = (HomeGoodsCell *)[_goodsList cellForItemAtIndexPath:nowIndexpath];
    
    UIImageView *activityImgview = [[UIImageView alloc] initWithFrame:CGRectMake(nowIndexpath.row % 2 * (cell.width + 1) + 36, nowIndexpath.row / 2 * (cell.height + 1) + 16.f + _goodsList.top, cell.goodsPic.width,cell.goodsPic.height)];
    //设置图片
    NSArray *picList = [dic objectForKey:@"proPictureList"];
    if (picList.count != 0) {
        
        [activityImgview setImageWithURL:[NSURL URLWithString:[picList[0] objectForKey:@"img650"]]];
        
    }
    
    [_bgScrollView addSubview:activityImgview];
    
    [UIView animateWithDuration:0.75
                     animations:^{
                         
                         CGAffineTransform transform = CGAffineTransformMakeTranslation(KScreenWidth * 7 / 10 - activityImgview.centerX, KScreenHeight - kNavigationBarHeight - kTabBarHeight - activityImgview.centerY + _bgScrollView.contentOffset.y);
                         transform = CGAffineTransformScale(transform, 0.01, 0.01);
                         activityImgview.transform = CGAffineTransformRotate(transform, 2 * M_PI_2);
                         //
                     }completion:^(BOOL finished) {
                         
                         //动画结束后隐藏图片
                         activityImgview.hidden = YES;
                         
                     }];

}

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    
    [self requestData];
    
    [self requsetBanner];
    
    [self requestPrizeList];

    _bgScrollView.contentSize = CGSizeMake(KScreenWidth, _goodsList.bottom);

}

#pragma mark 请求网络数据
- (void)requestData{

    switch (_selectIndext) {
        case 0:
            [self requestGoodsList:@"3" withPage:_page];
            break;
        case 1:
            [self requestGoodsList:@"2" withPage:_page];
            break;
        case 2:
            [self requestGoodsList:@"1" withPage:_page];
            break;
        case 3:
            [self requestGoodsList:@"4" withPage:_page];
            break;
        default:
            break;
    }

}

//商品列表
- (void)requestGoodsList:(NSString *)kindStr withPage:(NSInteger)page{

    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:@{@"orderType":kindStr}
               forKey:@"paramsMap"];
    [params setObject:[NSNumber numberWithInteger:page] forKey:@"page"];
    [params setObject:@"4" forKey:@"rows"];
    
    NSString *url = [NSString stringWithFormat:@"%@%@",BASE_URL,GoodsList_URL];
    
    [ZSTools post:url
           params:params
          success:^(id json) {
              
              if ([[json objectForKey:@"flag"] boolValue]) {
                  
                  [_bgScrollView.mj_footer endRefreshing];
                  if (page == 1) {
                      _goodsArr = [[json objectForKey:@"data"] mutableCopy];
                  }else{
                      NSArray *dataArr = [json objectForKey:@"data"];

                      [_goodsArr addObjectsFromArray:dataArr];
                      _page++;
                  }

                  _goodsList.height = ((KScreenWidth - 1) * 11 / 20) * (_goodsArr.count / 2 + _goodsArr.count % 2) + _goodsArr.count - 1;
                  _bgScrollView.contentSize = CGSizeMake(KScreenWidth, _goodsList.bottom);
                  [_goodsList reloadData];
              }
              
          } failure:^(NSError *error) {
              
          }];

}

//首页banner
- (void)requsetBanner{

    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:@"1" forKey:@"type"];
    
    NSString *url = [NSString stringWithFormat:@"%@%@",BASE_URL,HomeBanner_URL];
    
    [ZSTools post:url
           params:params
          success:^(id json) {
              
              if ([json objectForKey:@"flag"]) {
                  _bannerArr = [[json objectForKey:@"data"] mutableCopy];
                  NSMutableArray *picArr = [NSMutableArray array];
                  for (int i = 0; i < _bannerArr.count; i ++) {
                      
                      NSDictionary *dic = [_bannerArr objectAtIndex:i];
                      [picArr addObject:[dic objectForKey:@"imageUrl"]];
                      
                  }
                  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                      _topBannerView.imageURLStringsGroup = picArr;
                  });
              }
              
          } failure:^(NSError *error) {
              
          }];
    
}

//获奖者公告
- (void)requestPrizeList{
    
    NSString *url = [NSString stringWithFormat:@"%@%@",BASE_URL,HomePrizeList_URL];
    
    [ZSTools post:url
           params:nil
          success:^(id json) {
              
              if ([json objectForKey:@"flag"]) {
                  
                  NSArray *dataArr = [json objectForKey:@"data"];
                  NSMutableArray *msgArr = [NSMutableArray array];
                  for (int i = 0; i < dataArr.count; i ++) {
                      
                      NSDictionary *dic = [dataArr objectAtIndex:i];
                      NSString *msgStr = [NSString stringWithFormat:@"恭喜%@中了%@",[dic objectForKey:@"nickName"],[dic objectForKey:@"productName"]];
                      [msgArr addObject:msgStr];
                      
                  }
                  _wingTable.dataArr = msgArr;
                  _wingTable.wingrArr = dataArr;
                  _wingTable.timerDelegate = self;
              }
              
          } failure:^(NSError *error) {
              
          }];

}

#pragma mark - 监听bgscrollview的滑动
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{

    CGFloat offset_y = scrollView.contentOffset.y;
    if (_functionView.bottom + 4.f - offset_y < 0) {
    
        _segmentView.top = 0;
    
    }else{
    
        _segmentView.top = _functionView.bottom + 4.f  - offset_y;
        
    }
    
}

@end

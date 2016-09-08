//
//  HomeViewController.m
//  掌上云购
//
//  Created by coco船长 on 16/8/3.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import "HomeViewController.h"


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
    
}

- (void)NavAction:(UIButton *)button{
    
    NSLogZS(@"要搜索了");
    HomeSearchController *HSVC = [[HomeSearchController alloc] init];
    HSVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:HSVC
                                         animated:YES];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"夺宝首页";
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //初始化数据
    _goodsArr = [NSMutableArray array];
    //banner数据
    _bannerArr = [NSMutableArray array];
    
    [self initNavBar];
    [self initViews];
    
}

#pragma makr - initView
- (void)initViews{

    _bgScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight - kNavigationBarHeight - kTabBarHeight)];
    _bgScrollView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:_bgScrollView];
    
    [self initTopView];
    [self initCenterView];
    [self initBottomView];
    
    [self requsetBanner];

}

#pragma mark - top，center，bottom
- (void)initTopView{

    //轮播图
    _topBannerView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenWidth *200 / 375) imagesGroup:nil];
    _topBannerView.placeholderImage = [UIImage imageNamed:@"首页轮播_1.jpg"];
    _topBannerView.infiniteLoop = YES;
    _topBannerView.delegate = self;
    _topBannerView.dotColor = [UIColor whiteColor];

    _topBannerView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    [_bgScrollView addSubview:_topBannerView];
    
    //获奖公告
    _wingTable = [[WingNotificationTableView alloc] initWithFrame:CGRectMake(0, _topBannerView.bottom - 20.f, KScreenWidth, 20.f)];
    _wingTable.backgroundColor = [UIColor clearColor];
    NSArray *wingArr = @[@"张三没中奖",@"李四没中奖",@"王五没中奖",@"刘六没中奖",@"杨七没中奖"];
    _wingTable.dataArr = wingArr;
    _wingTable.timerDelegate = self;
    [_bgScrollView addSubview:_wingTable];

}

#pragma mark - SDCycleScrollViewDelegate,WingTableDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    
    NSLogZS(@"点击了第几个:%ld",index);
    
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
        functionControl.tag = i;
        functionControl.controlFlag = titleArr[i];
        [functionControl addTarget:self
                            action:@selector(controlAction:)
                  forControlEvents:UIControlEventTouchUpInside];
        [_functionView addSubview:functionControl];
        
    }
    
}

- (void)controlAction:(HomeFunctionControl *)control{

    NSLogZS(@"选择了这个功能");
    if (control.tag != 3) {
       
        SegmentController *SVC = [[SegmentController alloc] init];
        SVC.index = control.tag;
        [self.navigationController pushViewController:SVC
                                             animated:YES];
        
    }else{
    
        SunSharingViewController *VC = [[SunSharingViewController alloc]init];
        VC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:VC animated:YES];
        
    }

    
}

- (void)initBottomView{
    
    _segmentView = [[UIView alloc] initWithFrame:CGRectMake(0, _functionView.bottom + 4.f, KScreenWidth, 40.f)];
    _segmentView.backgroundColor = [UIColor whiteColor];
    [_bgScrollView addSubview:_segmentView];
    
    NSArray *segmentArr = @[@"人气",@"最新",@"最新",@"总需人次"];
    float width = KScreenWidth / 4;
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
    
    UIImageView *lineView = [[UIImageView alloc] initWithFrame:CGRectMake(0, _segmentView.bottom, KScreenWidth, 1)];
    lineView.backgroundColor = [UIColor colorFromHexRGB:@"EAEAEA"];
    [_bgScrollView addSubview:lineView];
    
    UIImageView *selectImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, _segmentView.bottom - 1, KScreenWidth / 4, 2)];
    selectImg.backgroundColor = [UIColor colorFromHexRGB:ThemeColor];
    selectImg.tag = 50;
    [_bgScrollView addSubview:selectImg];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //设置滑动方向
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    //设置单元格的间隙
    layout.minimumInteritemSpacing = 1;
    layout.minimumLineSpacing = 1;
    _goodsList = [[UICollectionView alloc] initWithFrame:CGRectMake(0, _segmentView.bottom + 1, KScreenWidth, 700.f) collectionViewLayout:layout];
    _goodsList.scrollEnabled = NO;
    _goodsList.backgroundColor = [UIColor colorFromHexRGB:@"EAEAEA"];
    _goodsList.delegate = self;
    _goodsList.dataSource = self;
    [_goodsList registerNib:[UINib nibWithNibName:@"HomeGoodsCell"
                                           bundle:[NSBundle mainBundle]]
 forCellWithReuseIdentifier:@"HomeGoods_Cell"];
//    [_goodsList registerClass:[HeaderCRView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:Identifier];
    [_bgScrollView  addSubview:_goodsList];
    
}

- (void)selectAction:(UIButton *)button{

    NSInteger selectIndext = button.tag - 100;
    
    UIImageView *imageView = [_bgScrollView viewWithTag:50];
    [UIView animateWithDuration:0.5
                     animations:^{
                        
                         imageView.centerX = button.centerX;
                         
                     }];
    
    switch (selectIndext) {
        case 0:
            [self requestGoodsList:@"3"];
            break;
        case 1:
            [self requestGoodsList:@"2"];
            break;
        case 2:
            [self requestGoodsList:@"1"];
            break;
        case 3:
            [self requestGoodsList:@"4"];
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
        
        [cell.goodsPic setImageWithURL:[NSURL URLWithString:[picList[0] objectForKey:@"img650"]]];
    
    }

    cell.nowIndexpath = indexPath;
    cell.delegate = self;
    cell.dataDic = dic;
    
    return cell;
}
//设置单元格的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake((KScreenWidth - 1) / 2  , (KScreenWidth - 1) * 11 / 20);
    
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{

    return UIEdgeInsetsMake(0, 0, 0, 0);
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{

    return CGSizeMake(KScreenWidth, 100);

}

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    
//    GoodsDetailController *GDVC = [[GoodsDetailController alloc] init];
//    [self.navigationController pushViewController:GDVC
//                                         animated:YES];
//    
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
    
    [UIView animateWithDuration:1.5
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
    
    [self requestPrizeList];

    _bgScrollView.contentSize = CGSizeMake(KScreenWidth, _goodsList.bottom);

}

#pragma mark 请求网络数据
- (void)requestData{

    [self requestGoodsList:@"3"];

}

//商品列表
- (void)requestGoodsList:(NSString *)kindStr{

    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:@{@"orderType":kindStr}
               forKey:@"paramsMap"];
    
    NSString *url = [NSString stringWithFormat:@"%@%@",BASE_URL,GoodsList_URL];
    
    [ZSTools post:url
           params:params
          success:^(id json) {
              
              if ([json objectForKey:@"flag"]) {
                  _goodsArr = [json objectForKey:@"data"];
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
                  _bannerArr = [json objectForKey:@"data"];
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
              }
              
          } failure:^(NSError *error) {
              
          }];

}

@end

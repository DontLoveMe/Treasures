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
    
    [self initNavBar];
    [self initViews];
    
    [self requestData];
    
}

#pragma makr - initView
- (void)initViews{

    _bgScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight - kNavigationBarHeight - kTabBarHeight)];
    _bgScrollView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:_bgScrollView];
    
    [self initTopView];
    [self initCenterView];
    [self initBottomView];

}

#pragma mark - top，center，bottom
- (void)initTopView{

    //轮播图
    NSArray *imgArr = @[[UIImage imageNamed:@"首页轮播_1.jpg"],[UIImage imageNamed:@"首页轮播_2.jpg"],[UIImage imageNamed:@"首页轮播_3.jpg"]];
    _topBannerView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenWidth *200 / 375) imagesGroup:imgArr];
    _topBannerView.placeholderImage = [UIImage imageNamed:@"placeholder"];
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
    
    NSLogZS(@"在这里重新加载网络数据");
    
}

- (void)initCenterView{

    _functionView = [[UIView alloc] initWithFrame:CGRectMake(0, _topBannerView.bottom, KScreenWidth, 120.f)];
    _functionView.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.3];
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
    
    SegmentController *SVC = [[SegmentController alloc] init];
    [self.navigationController pushViewController:SVC
                                         animated:YES];
    
}

- (void)initBottomView{

    _kindControl = [[UISegmentedControl alloc] initWithItems:@[@"人气",@"最新",@"进度",@"总需人次"]];
    _kindControl.frame = CGRectMake(0, _functionView.bottom + 4.f, KScreenWidth, 40.f);
    [_kindControl addTarget:self
                     action:@selector(selectAction:)
           forControlEvents:UIControlEventTouchDragInside];
    [_bgScrollView addSubview:_kindControl];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //设置滑动方向为水平
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    //设置单元格的间隙
    layout.minimumInteritemSpacing = 10;
    layout.minimumLineSpacing = 10;
    _goodsList = [[UICollectionView alloc] initWithFrame:CGRectMake(0, _kindControl.bottom + 4.f, KScreenWidth, 400.f) collectionViewLayout:layout];
    _goodsList.scrollEnabled = NO;
    _goodsList.backgroundColor = [UIColor redColor];
    _goodsList.delegate = self;
    _goodsList.dataSource = self;
    [_goodsList registerNib:[UINib nibWithNibName:@"HomeGoodsCell"
                                           bundle:[NSBundle mainBundle]]
 forCellWithReuseIdentifier:@"HomeGoods_Cell"];
    [_bgScrollView  addSubview:_goodsList];
    
}

- (void)selectAction:(UISegmentedControl *)control{

    NSInteger selectIndext = control.selectedSegmentIndex;
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
    cell.progressLabel.text = [NSString stringWithFormat:@"当前进度%@%%",[dic objectForKey:@"sellShare"]];
    NSLogZS(@"%@",dic);
    
    return cell;
}
//设置单元格的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake((KScreenWidth - 40) / 2  , 180);
    
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{

    return UIEdgeInsetsMake(10.f, 10.f, 10.f, 10.f);
    
}

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLogZS(@"选择了第%ld个",indexPath.row);
    GoodsDetailController *GDVC = [[GoodsDetailController alloc] init];
    [self.navigationController pushViewController:GDVC
                                         animated:YES];
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    NSLogZS(@"选择了第%ld个",indexPath.row);
    NSDictionary *dic = [_goodsArr objectAtIndex:indexPath.row];
    
    GoodsDetailController *GDVC = [[GoodsDetailController alloc] init];
    GDVC.goodsId = [dic objectForKey:@"id"];
    GDVC.isJoind = 0;
    GDVC.isAnnounced = 1;
    GDVC.isPrized = 0;
    GDVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:GDVC
                                         animated:YES];
    
//    if (indexPath.row == 0) {
//        
//        GoodsDetailController *GDVC = [[GoodsDetailController alloc] init];
//        GDVC.goodsId = [dic objectForKey:@"id"];
//        GDVC.isJoind = 0;
//        GDVC.isAnnounced = 1;
//        GDVC.isPrized = 0;
//        GDVC.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:GDVC
//                                             animated:YES];
//        
//    }else if (indexPath.row == 1) {
//        
//        GoodsDetailController *GDVC = [[GoodsDetailController alloc] init];
//        GDVC.goodsId = [dic objectForKey:@"id"];
//        GDVC.isJoind = 1;
//        GDVC.isAnnounced = 1;
//        GDVC.isPrized = 0;
//        GDVC.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:GDVC
//                                             animated:YES];
//        
//    }else if (indexPath.row == 2) {
//        
//        GoodsDetailController *GDVC = [[GoodsDetailController alloc] init];
//        GDVC.goodsId = [dic objectForKey:@"id"];
//        GDVC.isJoind = 0;
//        GDVC.isAnnounced = 2;
//        GDVC.isPrized = 0;
//        GDVC.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:GDVC
//                                             animated:YES];
//        
//    }else if (indexPath.row == 3) {
//        
//        GoodsDetailController *GDVC = [[GoodsDetailController alloc] init];
//        GDVC.goodsId = [dic objectForKey:@"id"];
//        GDVC.isJoind = 1;
//        GDVC.isAnnounced = 2;
//        GDVC.isPrized = 0;
//        GDVC.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:GDVC
//                                             animated:YES];
//        
//    }

}

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    
    _bgScrollView.contentSize = CGSizeMake(KScreenWidth, _goodsList.bottom);

}

#pragma mark 请求网络数据
- (void)requestData{

    [self requestGoodsList:@"3"];

}

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

@end

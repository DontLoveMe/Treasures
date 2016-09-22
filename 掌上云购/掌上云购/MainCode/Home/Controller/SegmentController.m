//
//  SegmentController.m
//  test
//
//  Created by 刘毅 on 16/7/27.
//  Copyright © 2016年 刘毅. All rights reserved.
//

#import "SegmentController.h"
#import "SegmentView.h"
#import "ProductCollectionView.h"
#import "ProductTableView.h"
#import "HomeSearchController.h"
#import "GoodsDetailController.h"

#define segmentViewWidth 60

@interface SegmentController ()<UICollectionViewDelegate>

@property (nonatomic,strong)ProductCollectionView *collectionView;
@property (nonatomic,strong)UIButton *selectBtn;

@property (nonatomic,strong)NSMutableArray *data;
@property (nonatomic,assign)NSInteger page;
@property (nonatomic,strong)NSDictionary *segmentDic;

@end

@implementation SegmentController

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
    
    UIButton *rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 25.f, 25.f)];
    rightButton.tag = 102;
    [rightButton setBackgroundImage:[UIImage imageNamed:@"首页_搜索.png"]
                          forState:UIControlStateNormal];
    [rightButton addTarget:self
                   action:@selector(NavAction:)
         forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)NavAction:(UIButton *)button{
    if(button.tag == 101){
        
        [self.navigationController popViewControllerAnimated:YES];
    }else {
        HomeSearchController *HSVC = [[HomeSearchController alloc] init];
        HSVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:HSVC
                                             animated:YES];
    }
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.title = @"掌上云购";
    
    _page = 1;
    _data = [NSMutableArray array];
    
    [self requestSegmentData];

    [self initNavBar];
    [self createSubviews];
}

- (void)createSubviews {

    //关闭对scroller偏移量的影响
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    _topKindView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 36.f)];
    _topKindView.backgroundColor = [UIColor whiteColor];
    NSArray *titleArr = @[@"类别",@"人气",@"最新",@"最热",@"总需人次⇅"];
    float width = (KScreenWidth - 4) / 5;
//    UIImageView *firstLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, 8.f, 0.5, 28.f)];
//    firstLine.backgroundColor = [UIColor darkGrayColor];
//    [_topKindView addSubview:firstLine];
    for (int i = 0; i < titleArr.count ; i ++) {
        
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake((1 + width) * i, 0, width, 36.f)];
        if (i == 0) {
            button.userInteractionEnabled = NO;
        }
        button.tag = 100 + i;
        button.titleLabel.font = [UIFont systemFontOfSize:12];
        [button setTitle:titleArr[i]
                forState:UIControlStateNormal];
        [button setTitleColor:[UIColor darkGrayColor]
                     forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorFromHexRGB:ThemeColor]
                     forState:UIControlStateSelected];
        [button addTarget:self
                   action:@selector(ButtonAction:)
         forControlEvents:UIControlEventTouchUpInside];
        [_topKindView addSubview:button];
        
        
        if (i == 1) {
            _selectBtn = button;
            _selectBtn.selected = YES;
        }
        
        if (i != titleArr.count - 1) {
            UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(button.frame)-1, 8.f, 1, 22.f)];
            line.backgroundColor = [UIColor darkGrayColor];
            [_topKindView addSubview:line];
        }
    }
    [self.view addSubview:_topKindView];
    

                       
    _collectionView = [[ProductCollectionView alloc] initWithFrame:CGRectMake(segmentViewWidth, 36, [UIScreen mainScreen].bounds.size.width-segmentViewWidth,[UIScreen mainScreen].bounds.size.height-64-36-49)];
    _collectionView.hidden = NO;
    [self.view addSubview:_collectionView];
  
    //下拉时动画
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        
        _page = 1;
        switch (_selectBtn.tag - 100) {
            case 1:
                _orderType = @"3";
                [self requestGoodsList];
                break;
            case 2:
                _orderType = @"2";
                [self requestGoodsList];
                break;
            case 3:
                _orderType = @"1";
                [self requestGoodsList];
                break;
            case 4:
                _orderType = @"4";
                [self requestGoodsList];
                
                break;
            default:
                break;
        }
        
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
    _collectionView.mj_header = header;
    
    MJRefreshBackStateFooter *footer = [MJRefreshBackStateFooter footerWithRefreshingBlock:^{
        if (_page == 1) {
            _page = 2;
        }
        switch (_selectBtn.tag - 100) {
            case 1:
                _orderType = @"3";
                [self requestGoodsList];
                break;
            case 2:
                _orderType = @"2";
                [self requestGoodsList];
                break;
            case 3:
                _orderType = @"1";
                [self requestGoodsList];
                break;
            case 4:
                _orderType = @"4";
                [self requestGoodsList];
                
                break;
            default:
                break;
        }
    }];
    _collectionView.mj_footer = footer;
    
    _collectionView.delegate = self;
    
  
}

- (void)createSegmentView {
    
    SegmentView *segView = [[SegmentView alloc] initWithFrame:CGRectMake(0, 36, segmentViewWidth, [UIScreen mainScreen].bounds.size.height-36-49-64) segmentTitles:self.segmentTitles imageNames:nil selectImgNames:nil];
    segView.backgroundColor = [UIColor whiteColor];
    
    __weak typeof(self) weakSelf = self;
    [segView setTagBlock:^(NSInteger index) {
        NSLog(@"选择竖排分类回调%ld",(long)index);
        if (_segmentData.count == 0) {
            return;
        }
        NSDictionary *dic = _segmentData[index];
        _segmentDic = dic;
        self.title = dic[@"name"];
        _page = 1;

        [weakSelf requestGoodsList];
    }];
    segView.index = _index;
    
    [self.view addSubview:segView];

}

#pragma mark - 数据请求
- (void)requestSegmentData {
    NSString *url = [NSString stringWithFormat:@"%@%@",BASE_URL,CategorysList_URL];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:@{@"showClient":@1} forKey:@"paramsMap"];
    
    [ZSTools post:url
           params:params
          success:^(id json) {
              
              self.segmentData = json[@"rows"];
              NSMutableArray *titles = [NSMutableArray array];
//              NSMutableArray *imgUrls = [NSMutableArray array];
              for (NSDictionary *dic in self.segmentData) {
                  [titles addObject:dic[@"name"]];
//                  [imgUrls addObject:[NSString stringWithFormat:@"%@%@",@"http://192.168.0.252:8000/pcpfiles/",dic[@"pictureLogo"]]];
              }
//              self.imgNames = imgUrls.copy;
              
              self.segmentTitles = titles.copy;
              [self createSegmentView];
          } failure:^(NSError *error) {
              
          }];
}

//商品列表
- (void)requestGoodsList{
    if (!_segmentDic) return;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if ([_segmentDic[@"isFixe"] boolValue]) {
        NSString *fixeType = _segmentDic[@"fixeType"];
        if (_orderType == nil) {
            _orderType = @"3";
        }
        [params setObject:@{@"orderType":_orderType,
                            @"fixeType":fixeType
                            }
                   forKey:@"paramsMap"];

    }else {
        if ([_segmentDic[@"id"] isKindOfClass:[NSNull class]]) {
            return;
        }
        if (_orderType == nil) {
            _orderType = @"3";
        }
        NSString *categoryId = _segmentDic[@"id"];
        [params setObject:@{@"orderType":_orderType,
                            @"categoryId":categoryId
                            }
                   forKey:@"paramsMap"];
    }
    [params setObject:@(_page) forKey:@"page"];
    [params setObject:@20 forKey:@"rows"];
    NSString *url = [NSString stringWithFormat:@"%@%@",BASE_URL,GoodsList_URL];
    
    [ZSTools post:url
           params:params
          success:^(id json) {
              
              if ([json objectForKey:@"flag"]) {
                  NSArray *dataArr = json[@"data"];
                  [_collectionView reloadData];
                  if (_page == 1) {
                      [_data removeAllObjects];
                      _data = dataArr.mutableCopy;
                      _collectionView.data = _data;
                      [_collectionView.mj_footer resetNoMoreData];
                      [_collectionView.mj_header endRefreshing];
                  }
                  
                  if (_page != 1 && _page != 0) {
                      if (dataArr.count > 0) {
                          _page ++;
                          [_data addObjectsFromArray:dataArr];
                          
                          _collectionView.data = _data;
                          [_collectionView.mj_footer endRefreshing];
                          
                      }else {
                          [_collectionView.mj_footer endRefreshingWithNoMoreData];
                      }
                  }
                  
                  [_collectionView reloadData];

              }
              
          } failure:^(NSError *error) {
              
          }];
    
}

- (void)ButtonAction:(UIButton *)button{
    
//    NSArray *titleArr = @[@"类别",@"人气",@"最新",@"最热",@"总需人次⇅"];
//    NSString *titleStr = [titleArr objectAtIndex:button.tag - 100];
//    NSLog(@"选择了：%@",titleStr);
    _page = 1;
    switch (button.tag - 100) {
        case 1:
            _orderType = @"3";
            [self requestGoodsList];
            break;
        case 2:
            _orderType =@"2";
            [self requestGoodsList];
            break;
        case 3:
            _orderType =@"1";
            [self requestGoodsList];
            break;
        case 4:
            if (_selectBtn.tag == button.tag) {
//                button.selected = !button.selected;
                static BOOL isAscendingOrder;
                isAscendingOrder = !isAscendingOrder;
                if (!isAscendingOrder) {
                    _orderType =@"4";
                    [self requestGoodsList];
                }else {
                    _orderType =@"5";
                    [self requestGoodsList];
                }
            }else {
                _orderType = @"4";
                [self requestGoodsList];

            }
            break;
        default:
            break;
    }
    if (_selectBtn.tag != button.tag) {
        _selectBtn.selected = NO;
        _selectBtn = button;
        _selectBtn.selected = YES;
        
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"%@",indexPath);
    NSDictionary *dic = [_collectionView.data objectAtIndex:indexPath.row];
    
    GoodsDetailController *GDVC = [[GoodsDetailController alloc] init];
    GDVC.goodsId = [dic objectForKey:@"id"];
    GDVC.drawId = [dic objectForKey:@"drawId"];
    GDVC.isAnnounced = 1;
    GDVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:GDVC
                                         animated:YES];

}

@end

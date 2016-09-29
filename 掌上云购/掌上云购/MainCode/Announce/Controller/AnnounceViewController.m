//
//  AnnounceViewController.m
//  掌上云购
//
//  Created by coco船长 on 16/8/3.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import "AnnounceViewController.h"

@interface AnnounceViewController ()

@property (nonatomic,strong)UICollectionView *collectionView;
@property (nonatomic,copy)NSString *identify;
@property (nonatomic,assign)NSInteger page;

@end

@implementation AnnounceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"正在揭晓";
    
    _dataArr = [NSMutableArray array];
    _page = 1;
    //创建collectionView
    [self createCollectionView];
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    //请求数据
    [self requestData];
    
}

//请求数据
- (void)requestData {

    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:@(_page) forKey:@"page"];
    [params setObject:@"20" forKey:@"rows"];
    
    NSString *url = [NSString stringWithFormat:@"%@%@",BASE_URL,NewnestAnnounceList_URL];
    
    [ZSTools post:url
           params:params
          success:^(id json) {
              BOOL flag = [json[@"flag"] boolValue];
              if (flag) {
                  
//                  _dataArr = [json objectForKey:@"data"];
//                  [_collectionView reloadData];
                  NSArray *dataArr = json[@"data"];
                  if (_page == 1) {
                      [_dataArr removeAllObjects];
                      _dataArr = dataArr.mutableCopy;
                      
                      [_collectionView.mj_footer resetNoMoreData];
                      [_collectionView.mj_header endRefreshing];
                  }
                  
                  if (_page != 1 && _page != 0) {
                      if (dataArr.count > 0) {
                          _page ++;
                          [_dataArr addObjectsFromArray:dataArr];
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

//创建collectionView
- (void)createCollectionView {
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(KScreenWidth/2-0.5, KScreenWidth*1.4/2);
    layout.minimumLineSpacing = 1;
    layout.minimumInteritemSpacing = 1;
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight-self.tabBarController.tabBar.height-64) collectionViewLayout:layout];
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    [self.view addSubview:_collectionView];
    
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    
    _identify = @"AnnounceCell";
    UINib *nib = [UINib nibWithNibName:@"AnnounceCell" bundle:nil];
    [_collectionView registerNib:nib forCellWithReuseIdentifier:_identify];
    
   
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
    _collectionView.mj_header = header;

    
    
    MJRefreshBackStateFooter *footer = [MJRefreshBackStateFooter footerWithRefreshingBlock:^{
        if (_page == 1) {
            _page = 2;
        }
        [self requestData];
    }];
    _collectionView.mj_footer = footer;
    
}

#pragma mark - collectionViewDelegate,collectViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return _dataArr.count;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    AnnounceCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:_identify forIndexPath:indexPath];
    if (!cell) {
        cell = [[AnnounceCell alloc] init];
    }
    cell.indexpath = indexPath;
    cell.announceDelegate = self;
    cell.backgroundColor = [UIColor whiteColor];
    NSDictionary *dic = [_dataArr objectAtIndex:indexPath.row];
    //图片
    if (![[dic objectForKey:@"productImg"] isKindOfClass:[NSNull class]]) {
        
        [cell.imgView setImageWithURL:[NSURL URLWithString:[dic objectForKey:@"productImg"]]
                     placeholderImage:[UIImage imageNamed:@"未加载图片"]];
        
    }else{
        
        [cell.imgView setImage:[UIImage imageNamed:@"未加载图片"]];
        
    }
    
    NSArray *proAttrList = [dic objectForKey:@"proAttrList"];
    if (proAttrList.count != 0) {
        [cell.typeMarkImgView setImageWithURL:[NSURL URLWithString:[proAttrList[0] objectForKey:@"photoUrl"]]
                             placeholderImage:[UIImage new]];
    }else {
        cell.typeMarkImgView.image = [UIImage new];
    }
    //商品名
    cell.titleLabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"productName"]];
    //期号
    cell.numberLabel.text = [NSString stringWithFormat:@"期号：%@",[dic objectForKey:@"drawTimes"]];
#warning 是否进入倒计时，这个判断条件需要更改
    if ([[dic objectForKey:@"drawNumber"] isKindOfClass:[NSNull class]]) {
        
        //倒计时时间
        if (![[dic objectForKey:@"countdownEndDate"] isKindOfClass:[NSNull class]]) {
            cell.str = [dic objectForKey:@"countdownEndDate"];
        }

        cell.getUserLabel.hidden = YES;
        cell.peopleNumLb.hidden = YES;
        cell.luckyLabel.hidden = YES;
        cell.announceTimeLb.hidden = YES;
        
        cell.timeIconView.hidden = NO;
        cell.timeLabel.hidden = NO;
        cell.unveilLabel.hidden = NO;
        
    }else{
    
        if (cell.countDown) {
            [cell.countDown destoryTimer];
        }
        if (![[dic objectForKey:@"countdownEndDate"] isKindOfClass:[NSNull class]]) {
            cell.str = [dic objectForKey:@"countdownEndDate"];
        }
        cell.getUserLabel.hidden = NO;
        cell.peopleNumLb.hidden = NO;
        cell.luckyLabel.hidden = NO;
        cell.announceTimeLb.hidden = NO;
        
        cell.timeIconView.hidden = YES;
        cell.timeLabel.hidden = YES;
        cell.unveilLabel.hidden = YES;
        
        cell.getUserLabel.text = [NSString stringWithFormat:@"获奖用户 %@",[dic objectForKey:@"nickName"]];
        cell.peopleNumLb.text = [NSString stringWithFormat:@"参与次数 %ld",[[dic objectForKey:@"sellShare"] integerValue]];
        cell.luckyLabel.text = [NSString stringWithFormat:@"幸运号码 %ld",[[dic objectForKey:@"drawNumber"] integerValue]];
        cell.announceTimeLb.text = [NSString stringWithFormat:@"揭晓时间 %@",[dic objectForKey:@"drawDate"]];
        
    }
//    [cell setNeedsLayout];
//    [cell layoutIfNeeded];
    return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
   
    NSDictionary *dic = [_dataArr objectAtIndex:indexPath.row];
    GoodsDetailController *GDVC = [[GoodsDetailController alloc] init];
    GDVC.goodsId = [dic objectForKey:@"productId"];
    
    GDVC.drawId = [dic objectForKey:@"drawId"];
    if ([[dic objectForKey:@"drawNumber"] isKindOfClass:[NSNull class]]) {
    
        GDVC.isAnnounced = 2;
    }else {
        
        GDVC.isAnnounced = 3;
    }
    GDVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:GDVC
                                         animated:YES];
    
}

- (void)countEnd:(NSIndexPath *)indexPath{

    AnnounceCell *cell = (AnnounceCell *)[_collectionView cellForItemAtIndexPath:indexPath];
    
    NSDictionary *dic = [_dataArr objectAtIndex:indexPath.row];
    
    [self requestAnnouncedWithCell:cell
                           withDic:dic];
    
}

- (void)requestAnnouncedWithCell:(AnnounceCell *)cell withDic:(NSDictionary *)dic{

    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:[dic objectForKey:@"id"] forKey:@"id"];
    
    NSString *url = [NSString stringWithFormat:@"%@%@",BASE_URL,NewnestAnnounceDetail_URL];
    
    [ZSTools post:url
           params:params
          success:^(id json) {
              
              if ([[json objectForKey:@"data"] isKindOfClass:[NSNull class]]) {
                  return ;
              }
              
              NSDictionary *dataDic = [json objectForKey:@"data"];
              cell.getUserLabel.hidden = NO;
              cell.peopleNumLb.hidden = NO;
              cell.luckyLabel.hidden = NO;
              cell.announceTimeLb.hidden = NO;
              
              cell.timeIconView.hidden = YES;
              cell.timeLabel.hidden = YES;
              cell.unveilLabel.hidden = YES;
              
              cell.getUserLabel.text = [NSString stringWithFormat:@"获奖用户 %@",[dataDic objectForKey:@"nickName"]];
              cell.peopleNumLb.text = [NSString stringWithFormat:@"参与次数 %ld",[[dataDic objectForKey:@"sellShare"] integerValue]];
              cell.luckyLabel.text = [NSString stringWithFormat:@"幸运号码 %ld",[[dataDic objectForKey:@"drawNumber"] integerValue]];
              cell.announceTimeLb.text = [NSString stringWithFormat:@"揭晓时间 %@",[dataDic objectForKey:@"drawDate"]];
              
              
          } failure:^(NSError *error) {
              
          }];
    
}

@end

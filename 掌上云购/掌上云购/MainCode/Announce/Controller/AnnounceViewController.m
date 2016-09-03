//
//  AnnounceViewController.m
//  掌上云购
//
//  Created by coco船长 on 16/8/3.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import "AnnounceViewController.h"
#import "AnnounceCell.h"


@interface AnnounceViewController ()

@property (nonatomic,strong)UICollectionView *collectionView;
@property (nonatomic,strong)NSMutableArray *data;
@property (nonatomic,copy)NSString *identify;

@end

@implementation AnnounceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"正在揭晓";
    
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
    
//    self.data= @[@"2016-09-03 09:43:56:000",@"2016-08-26 16:50:56:000",@"2016-08-26 16:40:56:000",@"2016-08-26 16:30:56:000",@"2016-08-26 16:20:56:000",@"2016-08-26 14:15:56:000",@"2016-08-26 14:10:56:000",@"2016-08-26 14:10:56:000",@"2016-08-26 14:10:56:000",@"2016-08-26 14:10:56:000"];
    _dataArr = [NSMutableArray array];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:@"1" forKey:@"page"];
    [params setObject:@"20" forKey:@"rows"];
    
    NSString *url = [NSString stringWithFormat:@"%@%@",BASE_URL,NewnestAnnounceList_URL];
    
    [ZSTools post:url
           params:params
          success:^(id json) {
              
              _dataArr = [json objectForKey:@"data"];
              _data = [NSMutableArray array];
              for (NSInteger i = 1; i < _dataArr.count ; i ++) {
                  
                  NSDictionary *dataDic = [_dataArr objectAtIndex:i];
                  [_data addObject:[dataDic objectForKey:@"countdownEndDate"]];
                  
              }
              [_collectionView reloadData];
              
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
    _collectionView.backgroundColor = [UIColor colorWithWhite:0.8 alpha:1];
    [self.view addSubview:_collectionView];
    
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    
    _identify = @"AnnounceCell";
    UINib *nib = [UINib nibWithNibName:@"AnnounceCell" bundle:nil];
    [_collectionView registerNib:nib forCellWithReuseIdentifier:_identify];
    
    
}

#pragma mark - collectionViewDelegate,collectViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.data.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    AnnounceCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:_identify forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    cell.str = _data[indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
   
    NSDictionary *dic = [_dataArr objectAtIndex:indexPath.row];
    GoodsDetailController *GDVC = [[GoodsDetailController alloc] init];
    GDVC.goodsId = [dic objectForKey:@"id"];
    
    
    
//    GDVC.drawId = [dic objectForKey:@"drawId"];
    GDVC.isAnnounced = 2;
    GDVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:GDVC
                                         animated:YES];
    
}

@end

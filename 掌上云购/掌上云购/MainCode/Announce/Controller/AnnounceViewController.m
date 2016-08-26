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
@property (nonatomic,strong)NSArray *data;
@property (nonatomic,copy)NSString *identify;

@end

@implementation AnnounceViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //请求数据
    [self requestData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"正在揭晓";
    
    //创建collectionView
    [self createCollectionView];
}
//请求数据
- (void)requestData {
    self.data= @[@"2016-08-26 17:30:56:000",@"2016-08-26 16:50:56:000",@"2016-08-26 16:40:56:000",@"2016-08-26 16:30:56:000",@"2016-08-26 16:20:56:000",@"2016-08-26 14:15:56:000",@"2016-08-26 14:10:56:000",@"2016-08-26 14:10:56:000",@"2016-08-26 14:10:56:000",@"2016-08-26 14:10:56:000"];
//    self.data = @[@"2016-08-26 14:03:56:000"];
    
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
   
}

@end

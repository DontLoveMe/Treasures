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
    
    return _dataArr.count;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    AnnounceCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:_identify forIndexPath:indexPath];
    if (cell.countDown) {
        [cell.countDown destoryTimer];
    }
    cell.indexpath = indexPath;
    cell.announceDelegate = self;
    cell.backgroundColor = [UIColor whiteColor];
    NSDictionary *dic = [_dataArr objectAtIndex:indexPath.row];
    //图片
    if (![[dic objectForKey:@"productImg"] isKindOfClass:[NSNull class]]) {
        
        [cell.imgView setImageWithURL:[NSURL URLWithString:[dic objectForKey:@"productImg"]]
                     placeholderImage:[UIImage imageNamed:@"揭晓-图片.jpg"]];
        
    }else{
        
        [cell.imgView setImage:[UIImage imageNamed:@"揭晓-图片.jpg"]];
        
    }
    //商品名
    cell.titleLabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"productName"]];
    //期号
    cell.numberLabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"drawTimes"]];
    
    if ([[dic objectForKey:@"drawNumber"] isKindOfClass:[NSNull class]]) {
        
        //倒计时时间
        cell.str = [dic objectForKey:@"countdownEndDate"];
        
        cell.getUserLabel.hidden = YES;
        cell.peopleNumLb.hidden = YES;
        cell.luckyLabel.hidden = YES;
        cell.announceTimeLb.hidden = YES;
        
        cell.timeIconView.hidden = NO;
        cell.timeLabel.hidden = NO;
        cell.unveilLabel.hidden = NO;
        
    }else{
    
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
    
    //    @property (weak, nonatomic) IBOutlet UIImageView *imgView;
    //    @property (weak, nonatomic) IBOutlet UILabel *titleLabel;
    //    @property (weak, nonatomic) IBOutlet UILabel *numberLabel;
    //    @property (weak, nonatomic) IBOutlet UILabel *timeLabel;
    //    @property (weak, nonatomic) IBOutlet UIImageView *timeIconView;
    //    @property (weak, nonatomic) IBOutlet UILabel *unveilLabel;
    //    @property (weak, nonatomic) IBOutlet UILabel *getUserLabel;
    //    @property (weak, nonatomic) IBOutlet UILabel *peopleNumLb;
    //    @property (weak, nonatomic) IBOutlet UILabel *luckyLabel;
    //    @property (weak, nonatomic) IBOutlet UILabel *announceTimeLb;
    
    return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
   
    NSDictionary *dic = [_dataArr objectAtIndex:indexPath.row];
    GoodsDetailController *GDVC = [[GoodsDetailController alloc] init];
    GDVC.goodsId = [dic objectForKey:@"productId"];
    
//    GDVC.drawId = [dic objectForKey:@"drawId"];
    GDVC.isAnnounced = 2;
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

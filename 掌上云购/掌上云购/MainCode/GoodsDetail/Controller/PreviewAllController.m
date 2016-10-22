//
//  PreviewAllController.m
//  掌上云购
//
//  Created by coco船长 on 16/9/8.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import "PreviewAllController.h"

@interface PreviewAllController ()

@property(nonatomic,assign)NSInteger page;

@end

@implementation PreviewAllController

- (void)initNavBar{
    
    self.navigationItem.backBarButtonItem = nil;
    UIButton *leftButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, kNavigationBarItemWidth, kNavigationBarItemHight)];
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
    self.title = @"夺宝记录";
    self.view.backgroundColor = [UIColor colorFromHexRGB:@"F2F2F2"];
    [self initNavBar];
    
//    CollectionViewLeftAlignedLayout *layout = [[CollectionViewLeftAlignedLayout alloc] init];
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.sectionInset = UIEdgeInsetsMake(8, 8, 8, 8);
    layout.minimumLineSpacing = 8;
    layout.minimumInteritemSpacing = 8;
    layout.itemSize = CGSizeMake((KScreenWidth-32)/3, 20);
    
    joinRecordCollectionView.collectionViewLayout = layout;
    joinRecordCollectionView.backgroundColor = [UIColor whiteColor];
    joinRecordCollectionView.delegate = self;
    joinRecordCollectionView.dataSource = self;
    
    [joinRecordCollectionView registerNib:[UINib nibWithNibName:@"HotCollectionCell" bundle:nil] forCellWithReuseIdentifier:@"HotCollection_Cell"];
    
    joinRecordCollectionView.mj_footer = [MJRefreshBackFooter footerWithRefreshingBlock:^{
        if (_page == 1) {
            _page = 2;
        }
        [self requestBuyuserList];
        
    }];
    
}

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    goodName.text = [NSString stringWithFormat:@"商品名:%@",[_dataDic objectForKey:@"name"]];
    
    drawNum.text = [NSString stringWithFormat:@"期号:%@",[_dataDic objectForKey:@"drawTimes"]];
    
    if (![[_dataDic objectForKey:@"countdownEndDate"] isKindOfClass:[NSNull class]]) {
        NSString *timeString = [NSString stringWithFormat:@"%@",[_dataDic objectForKey:@"countdownEndDate"]];
        NSDateFormatter* formater = [[NSDateFormatter alloc] init];
        [formater setDateFormat:@"yyyy-MM-dd HH:mm:ss.0"];
        NSDate *oldDate = [formater dateFromString:timeString];
        [formater setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        
        timeString = [formater stringFromDate:oldDate];
        drawTime.text = [NSString stringWithFormat:@"揭晓时间：%@",timeString];
    }else{
        
        drawTime.text = @"该商品尚未筹满";
        
    }
    
    if (![[_dataDic objectForKey:@"countdownEndDate"] isKindOfClass:[NSNull class]]) {
        NSString *timeString = [NSString stringWithFormat:@"%@",[_dataDic objectForKey:@"countdownEndDate"]];
        NSDateFormatter* formater = [[NSDateFormatter alloc] init];
        [formater setDateFormat:@"yyyy-MM-dd HH:mm:ss.0"];
        NSDate *oldDate = [formater dateFromString:timeString];
        [formater setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        
        timeString = [formater stringFromDate:oldDate];
        drawTime.text = [NSString stringWithFormat:@"揭晓时间：%@",timeString];
    }else{
        
        drawTime.text = @"揭晓时间：该商品尚未筹满";
    }
    NSDictionary *saleDraw = [_dataDic objectForKey:@"saleDraw"];
    if (![saleDraw isKindOfClass:[NSNull class]]) {
        luckyNum.text = [NSString stringWithFormat:@"本期幸运号码：%@",[saleDraw objectForKey:@"drawNumber"]];
    }else{
        
        luckyNum.text = @"本期幸运号码:尚未开奖";
    }
    drawListLabel.text = [NSString stringWithFormat:@"已参与%@人次，以下是所有夺宝记录",[_dataDic objectForKey:@"buyNumberCount"]];
//    NSMutableString *joinNumStr = [[_dataDic objectForKey:@"buyNumbers"] mutableCopy];
//    
//    NSScanner *theScanner;
    
//    NSString *text = nil;
//    
//    theScanner = [NSScanner scannerWithString:joinNumStr];
//    
    _page = 1;
    joinRecordList = [NSMutableArray array];
    
//    while ([theScanner isAtEnd] == NO) {
//        
//        // find start of tag
//        
//        [theScanner scanUpToString:@"," intoString:&text] ;
//        
//        [joinRecordList addObject:text];
//        
//        if (joinNumStr.length > text.length){
//            [joinNumStr deleteCharactersInRange:NSMakeRange(0, text.length + 1)];
//        }else{
//            [joinNumStr deleteCharactersInRange:NSMakeRange(0, text.length)];
//        }
//        
//        theScanner = [NSScanner scannerWithString:joinNumStr];
//        
//    }
//    
//    NSLogZS(@"%@",joinNumStr);
//    [joinRecordCollectionView reloadData];
    [self requestBuyuserList];
}

- (void)requestBuyuserList {
    //取出存储的用户信息
    NSDictionary *userDic = [[NSUserDefaults standardUserDefaults] objectForKey:@"userDic"];
    NSNumber *userId = userDic[@"id"];
    [self showHUD:@"加载数据"];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSString *drawId = _dataDic[@"drawId"];
    [params setObject:@{@"buyUserid":userId,@"drawId":drawId} forKey:@"paramsMap"];
    [params setObject:@(_page) forKey:@"page"];
    [params setObject:@200 forKey:@"rows"];
    NSString *url = [NSString stringWithFormat:@"%@%@",BASE_URL,BuyuserList_URL];
    [ZSTools post:url
           params:params
          success:^(id json) {
              
              BOOL isSuccess = [[json objectForKey:@"flag"] boolValue];
              [self hideSuccessHUD:json[@"msg"]];
              if (isSuccess) {
                  NSArray *dataArr = json[@"data"];
                  if (_page == 1) {
                      [joinRecordList removeAllObjects];
                      joinRecordList = dataArr.mutableCopy;
                      
                      [joinRecordCollectionView.mj_footer resetNoMoreData];
                      [joinRecordCollectionView.mj_header endRefreshing];
                  }
                  
                  if (_page != 1 && _page != 0) {
                      if (dataArr.count > 0) {
                          _page ++;
                          [joinRecordList addObjectsFromArray:dataArr];
                          [joinRecordCollectionView.mj_footer endRefreshing];
                      }else {
                          [joinRecordCollectionView.mj_footer endRefreshingWithNoMoreData];
                      }
                  }
                  [joinRecordCollectionView reloadData];
              }
              
              
          } failure:^(NSError *error) {
              
              [self hideFailHUD:@"加载失败"];
              NSLogZS(@"%@",error);
          }];
}
#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return joinRecordList.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HotCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HotCollection_Cell" forIndexPath:indexPath];
//    cell.titleLabel.text = _hotData[indexPath.row][@"name"];
    cell.titleLabel.text = joinRecordList[indexPath.row][@"buyNumber"];
    return cell;
}

//#pragma mark - CollectionViewDelegateLeftAlignedLayout
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {

//    NSString *hotStr = joinRecordList[indexPath.row][@"buyNumber"];
//    CGRect strRect = [hotStr boundingRectWithSize:CGSizeMake(KScreenWidth-32, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil];
//    return CGSizeMake((KScreenWidth-32)/3, 20);
//}

@end

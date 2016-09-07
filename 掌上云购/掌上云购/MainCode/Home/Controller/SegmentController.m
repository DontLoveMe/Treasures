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

@interface SegmentController ()<UICollectionViewDelegate>

@property (nonatomic,strong)ProductCollectionView *collectionView;
@property (nonatomic,strong)UIButton *selectBtn;

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
        
        
        if (i == 0) {
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
    

                       
    _collectionView = [[ProductCollectionView alloc] initWithFrame:CGRectMake(80, 36, [UIScreen mainScreen].bounds.size.width-80,[UIScreen mainScreen].bounds.size.height-64-36-49)];
    _collectionView.hidden = NO;
    [self.view addSubview:_collectionView];
    
//    _collectionView.data = @[@"全部商品",@"全部商品",@"全部商品",@"全部商品",@"全部商品",@"全部商品",@"全部商品",@"全部商品"];
    
    _collectionView.delegate = self;
    
  
}
- (void)createSegmentView {
    SegmentView *segView = [[SegmentView alloc] initWithFrame:CGRectMake(0, 36, 80, [UIScreen mainScreen].bounds.size.height-36-49-64) segmentTitles:self.segmentTitles imageNames:self.imgNames selectImgNames:self.selectImgNames];
    segView.backgroundColor = [UIColor whiteColor];
    
    __weak typeof(self) weakSelf = self;
    [segView setTagBlock:^(NSInteger index) {
        NSLog(@"选择竖排分类回调%ld",(long)index);
        NSDictionary *dic = _segmentData[index];
        
        _segmentID = [dic[@"id"] stringValue];
        if (index == 0) {
            _segmentID = nil;
        }
        [weakSelf requestGoodsList:@"3"];
    }];
    segView.index = _index;
    [self.view addSubview:segView];
    
//    _segmentID = self.segmentData[0][@"id"];
    [self requestGoodsList:@"3"];
}
#pragma mark - 数据请求
- (void)requestSegmentData {
    NSString *url = [NSString stringWithFormat:@"%@%@",BASE_URL,CategorysList_URL];
    
    [ZSTools post:url
           params:nil
          success:^(id json) {
              
              self.segmentData = json[@"rows"];
              NSMutableArray *titles = [NSMutableArray array];
              NSMutableArray *imgUrls = [NSMutableArray array];
              for (NSDictionary *dic in self.segmentData) {
                  [titles addObject:dic[@"name"]];
                  [imgUrls addObject:[NSString stringWithFormat:@"%@%@",@"http://192.168.0.252:8000/pcpfiles/",dic[@"pictureLogo"]]];
              }
              self.imgNames = imgUrls.copy;
              
              self.segmentTitles = titles.copy;
              [self createSegmentView];
          } failure:^(NSError *error) {
              
          }];
}

//商品列表
- (void)requestGoodsList:(NSString *)kindStr{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if (_segmentID) {
        [params setObject:@{@"orderType":kindStr,
                            @"categoryId":_segmentID
                            }
                   forKey:@"paramsMap"];
    }else {
        
        [params setObject:@{@"orderType":kindStr}
                   forKey:@"paramsMap"];
    }
    
    NSString *url = [NSString stringWithFormat:@"%@%@",BASE_URL,GoodsList_URL];
    
    [ZSTools post:url
           params:params
          success:^(id json) {
              
              if ([json objectForKey:@"flag"]) {
                  _collectionView.data = json[@"data"];
                  [_collectionView reloadData];
              }
              
          } failure:^(NSError *error) {
              
          }];
    
}

- (void)ButtonAction:(UIButton *)button{
    
    
    
    
//    NSArray *titleArr = @[@"类别",@"人气",@"最新",@"最热",@"总需人次⇅"];
//    NSString *titleStr = [titleArr objectAtIndex:button.tag - 100];
//    NSLog(@"选择了：%@",titleStr);
    switch (button.tag - 100) {
        case 1:
            [self requestGoodsList:@"3"];
            break;
        case 2:
            [self requestGoodsList:@"2"];
            break;
        case 3:
            [self requestGoodsList:@"1"];
            break;
        case 4:
            if (_selectBtn.tag == button.tag) {
//                button.selected = !button.selected;
                static BOOL isAscendingOrder;
                isAscendingOrder = !isAscendingOrder;
                if (isAscendingOrder) {
                    [self requestGoodsList:@"4"];
                }else {
                    [self requestGoodsList:@"5"];
                }
            }else {
                [self requestGoodsList:@"4"];

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

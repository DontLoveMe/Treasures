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

@interface SegmentController ()<UICollectionViewDelegate>

@property (nonatomic,strong)UIView *transitionView;
@property (nonatomic,strong)ProductCollectionView *collectionView;
@property (nonatomic,strong)ProductTableView *tableView;

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
    
    self.navigationItem.backBarButtonItem = nil;
    UIButton *rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50.f, 25.f)];
    [rightButton setTitle:@"切换" forState:UIControlStateNormal];
    [rightButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [rightButton addTarget:self
                   action:@selector(RightAction:)
         forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightItem;
    
}

- (void)NavAction:(UIButton *)button{
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)RightAction:(UIButton *)button{
    //三目判断左右翻转
    UIViewAnimationOptions options = _collectionView.hidden?UIViewAnimationOptionTransitionFlipFromLeft:UIViewAnimationOptionTransitionFlipFromRight;
    
    
    //
    [UIView transitionWithView:_transitionView
                      duration:0.5
                       options:options
                    animations:nil
                    completion:nil];
    _collectionView.hidden = !_collectionView.hidden;
    _tableView.hidden = !_tableView.hidden;
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.title = @"掌上云购";
    self.segmentTitles = @[@"苹果专场",@"充值卡",@"手机平板",@"电脑数码",@"家用电器",@"运动户外",@"日用百货",@"国际潮牌",@"黄金首饰",@"个护化妆",@"新品上架",@"其他"];
    
    self.imgNames = @[@"sort0_normal",
                      @"sort100_normal",
                      @"sort104_normal",
                      @"sort106_normal",
                      @"sort222_normal",
                      @"sort2_normal",
                      @"sort312_normal",
                      @"sort0_normal",
                      @"sort0_normal",
                      @"sort0_normal",
                      @"sort0_normal",
                      @"sort0_normal"];
    self.selectImgNames = @[@"sort0_checked",
                            @"sort100_checked",
                            @"sort104_checked",
                            @"sort106_checked",
                            @"sort222_checked",
                            @"sort2_checked",
                            @"sort312_checked",
                            @"sort0_checked",
                            @"sort0_checked",
                            @"sort0_checked",
                            @"sort0_checked",
                            @"sort0_checked"];
    [self initNavBar];
    [self createSubviews];
    
}

- (void)createSubviews {

    //关闭对scroller偏移量的影响
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    _topKindView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 44.f)];
    _topKindView.backgroundColor = [UIColor whiteColor];
    NSArray *titleArr = @[@"类别",@"人气",@"最新",@"最热",@"总需人次"];
    float width = (KScreenWidth - 5) / 5;
    UIImageView *firstLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, 8.f, 0.5, 28.f)];
    firstLine.backgroundColor = [UIColor darkGrayColor];
    [_topKindView addSubview:firstLine];
    for (int i = 0; i < titleArr.count ; i ++) {
        
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake((1 + width) * i + 0.5, 4, width, 36.f)];
        button.tag = 100 + i;
        [button setTitle:titleArr[i]
                forState:UIControlStateNormal];
        [button setTitleColor:[UIColor darkGrayColor]
                     forState:UIControlStateNormal];
        [button addTarget:self
                   action:@selector(ButtonAction:)
         forControlEvents:UIControlEventTouchUpInside];
        [_topKindView addSubview:button];
        
        UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(0.5 + (width + 1) * (i + 1) - 1, 8.f, 1, 28.f)];
        line.backgroundColor = [UIColor darkGrayColor];
        [_topKindView addSubview:line];
        
        if (i == titleArr.count - 1) {
            
            UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(0.5 + (width + 1) * (i + 1) - 1, 8.f, 0.5, 28.f)];
            line.backgroundColor = [UIColor darkGrayColor];
            [_topKindView addSubview:line];
            
        }
        
    }
    [self.view addSubview:_topKindView];
    
    SegmentView *segView = [[SegmentView alloc] initWithFrame:CGRectMake(0, 44, 100, [UIScreen mainScreen].bounds.size.height - 44) segmentTitles:self.segmentTitles imageNames:self.imgNames selectImgNames:self.selectImgNames];
    segView.backgroundColor = [UIColor whiteColor];

    [segView setTagBlock:^(NSInteger index) {
        NSLog(@"选择竖排分类回调%ld",(long)index);
        NSArray *data = @[_segmentTitles[index],_segmentTitles[index],_segmentTitles[index],_segmentTitles[index],_segmentTitles[index],_segmentTitles[index],_segmentTitles[index],_segmentTitles[index],_segmentTitles[index],_segmentTitles[index],_segmentTitles[index],_segmentTitles[index]];;
        _collectionView.data = data;
    }];
    [self.view addSubview:segView];
    
    _transitionView = [[UIView alloc] initWithFrame:CGRectMake(100, 64, [UIScreen mainScreen].bounds.size.width-100,[UIScreen mainScreen].bounds.size.height-64)];
    [self.view addSubview:_transitionView];
                       
    _collectionView = [[ProductCollectionView alloc] initWithFrame:_transitionView.bounds];
    _collectionView.hidden = NO;
    [_transitionView addSubview:_collectionView];
    
    _collectionView.data = @[_segmentTitles[0],_segmentTitles[0],_segmentTitles[0],_segmentTitles[0],_segmentTitles[0],_segmentTitles[0],_segmentTitles[0],_segmentTitles[0],_segmentTitles[0],_segmentTitles[0],_segmentTitles[0],_segmentTitles[0],_segmentTitles[0],_segmentTitles[0],_segmentTitles[0],_segmentTitles[0],_segmentTitles[0],_segmentTitles[0],_segmentTitles[0],_segmentTitles[0],_segmentTitles[0],_segmentTitles[0],_segmentTitles[0],_segmentTitles[0],_segmentTitles[0],_segmentTitles[0],_segmentTitles[0],_segmentTitles[0],_segmentTitles[0],_segmentTitles[0],_segmentTitles[0],_segmentTitles[0],_segmentTitles[0],_segmentTitles[0],_segmentTitles[0],_segmentTitles[0],_segmentTitles[0]];
    
    _collectionView.delegate = self;
    
    _tableView = [[ProductTableView alloc] initWithFrame:_transitionView.bounds];
    _tableView.hidden = YES;
    [_transitionView addSubview:_tableView];
}

- (void)ButtonAction:(UIButton *)button{

    NSArray *titleArr = @[@"类别",@"人气",@"最新",@"最热",@"总需人次"];
    NSString *titleStr = [titleArr objectAtIndex:button.tag - 100];
    NSLog(@"选择了：%@",titleStr);

}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"%@",indexPath);

}

@end

//
//  PersonViewController.m
//  掌上云购
//
//  Created by coco船长 on 16/8/3.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import "PersonViewController.h"
#import "LoginViewController.h"
#import "LuckyRecordController.h"
#import "SnatchRecordController.h"
#import "InordertoshareController.h"
#import "RedEnvelopeController.h"
#import "AboutMeController.h"
#import "RechargeController.h"
#import "RechargeRecordController.h"
#import "CustomerCareController.h"
#import "SettingsController.h"
#import "PersonCell.h"
#import "PersonHeaderView.h"


@interface PersonViewController ()

@property (nonatomic,copy)NSString *identify;
@property (nonatomic,strong)NSArray *data;

@property (nonatomic,strong)UIImageView *bgIconView;
@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UIButton *msgBtn;
@property (nonatomic,strong)UIButton *setBtn;


@end

@implementation PersonViewController

#pragma mark - 导航栏
- (void)initNavBar{
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, KScreenWidth, 25)];
    label.text = @"个人中心";
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:20];
    [self.view insertSubview:label aboveSubview:_collectionView];
    _titleLabel = label;
    
    UIButton *rightButton = [[UIButton alloc]initWithFrame:CGRectMake(KScreenWidth-40, 30, 25.f, 25.f)];
    rightButton.tag = 101;
//    [rightButton setTitle:@"信息" forState:UIControlStateNormal];
    [rightButton setBackgroundImage:[UIImage imageNamed:@"消息"]
                          forState:UIControlStateNormal];
    [rightButton addTarget:self
                   action:@selector(NavAction:)
         forControlEvents:UIControlEventTouchUpInside];
    [self.view insertSubview:rightButton aboveSubview:_collectionView];
    _msgBtn = rightButton;
    
    UIButton *rightButton1 = [[UIButton alloc]initWithFrame:CGRectMake(KScreenWidth-75, 30, 25.f, 25.f)];
    rightButton1.tag = 102;
//    [rightButton1 setTitle:@"设置" forState:UIControlStateNormal];
    [rightButton1 setBackgroundImage:[UIImage imageNamed:@"我的_设置"]
                           forState:UIControlStateNormal];
    [rightButton1 addTarget:self
                    action:@selector(NavAction:)
          forControlEvents:UIControlEventTouchUpInside];

    [self.view insertSubview:rightButton1 aboveSubview:_collectionView];
    _setBtn = rightButton1;
    
}

- (void)NavAction:(UIButton *)button{
    
    if (button.tag == 101) {//信息
        
    }else if (button.tag == 102) {//设置
        
        SettingsController *setVC = [[SettingsController alloc] init];
        self.navigationController.navigationBar.hidden = NO;
        setVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:setVC animated:YES];
    }
    
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    //设置导航栏透明
//    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init]
//                       forBarMetrics:UIBarMetricsDefault];
//    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
//    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
//    self.navigationController.navigationBar.translucent = YES;
    //去掉导航下面的一条白线
//    self.navigationController.navigationBar.clipsToBounds = YES;
 
//    self.view.backgroundColor= [UIColor colorWithWhite:0.9 alpha:1];
#warning 返回动画导航栏下面视图慢些
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"个人中心";
    [self initNavBar];

    [self initCollectionView];
  
    [self initBgHeaderView];
}

- (void)initBgHeaderView {
    
    _bgIconView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 228)];
    [self.view insertSubview:_bgIconView belowSubview:_collectionView];
    
    _bgIconView.image = [UIImage imageNamed:@"发现5"];
    //  毛玻璃样式
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    //  毛玻璃视图
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    effectView.alpha = 0.85;
    effectView.frame = CGRectMake(0, 0, KScreenWidth, 228);
    [_bgIconView addSubview:effectView];
}

- (void)initCollectionView {
    self.data = @[@"云购记录",@"幸运记录",@"我的红包",@"我的晒单",@"充值记录",@"云购客服"];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor colorWithWhite:0.6 alpha:1];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake((KScreenWidth-2)/3, (KScreenWidth-2)/3);
    layout.headerReferenceSize = CGSizeMake(self.view.bounds.size.width, 268);
    layout.minimumLineSpacing = 1;
    layout.minimumInteritemSpacing = 1;
    layout.sectionInset = UIEdgeInsetsMake(1, 0, 1, 0);
    
//    _collectionView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    _collectionView.backgroundColor = [UIColor clearColor];
    _collectionView.collectionViewLayout = layout;
    _collectionView.contentInset = UIEdgeInsetsMake(0, 0, 49, 0);
    _collectionView.showsVerticalScrollIndicator = NO;
//    _collectionView.scrollEnabled = NO;
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    
    
    
    _identify = @"PersonCell";
    UINib *nib = [UINib nibWithNibName:@"PersonCell" bundle:nil];
    [_collectionView registerNib:nib forCellWithReuseIdentifier:_identify];
    
    //注册headerView
    [_collectionView registerNib:[UINib nibWithNibName:@"PersonHeaderView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"PersonHeaderView"];
    
   
}
#pragma mark - 按钮的点击
//余额
- (void)balanceAction:(UIButton *)sender {
}
//充值
- (void)rechargeAction:(UIButton *)sender {
    
    RechargeController *reVC = [[RechargeController alloc] init];
    self.navigationController.navigationBar.hidden = NO;
    reVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:reVC animated:YES];
}
//积分
- (void)integralAction:(UIButton *)sender {
}
- (void)tapAction:(UITapGestureRecognizer *)tap {
    
    AboutMeController *amVC = [[AboutMeController alloc] init];
    self.navigationController.navigationBar.hidden = NO;
    amVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:amVC animated:YES];
}

#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.data.count+3;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PersonCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:_identify forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    if (indexPath.row < self.data.count) {
        
        cell.titleLabel.text = self.data[indexPath.row];
        cell.iconView.image = [UIImage imageNamed:self.data[indexPath.row]];
    }
    
    return cell;
}
#pragma mark 设置header
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (kind == UICollectionElementKindSectionHeader) {
        // 去重用队列取可用的header
        PersonHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"PersonHeaderView" forIndexPath:indexPath];
        headerView.backgroundColor = [UIColor clearColor];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [headerView.iconView addGestureRecognizer:tap];
        
        [headerView.balanceButton addTarget:self action:@selector(balanceAction:) forControlEvents:UIControlEventTouchUpInside];
        [headerView.rechargeButton addTarget:self action:@selector(rechargeAction:) forControlEvents:UIControlEventTouchUpInside];
        [headerView.integralButton addTarget:self action:@selector(integralAction:) forControlEvents:UIControlEventTouchUpInside];
        
        return headerView;
    }
    return nil;
}

//#pragma mark 设置header高度
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
//{
//    return CGSizeMake(self.view.bounds.size.width, 268);
//}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.row) {
        case 0://云购记录
        {
//            SnatchRecordController *seVC = [[SnatchRecordController alloc] init];
//            self.navigationController.navigationBar.hidden = NO;
//            seVC.hidesBottomBarWhenPushed = YES;
//
//            [self.navigationController pushViewController:seVC animated:YES];

//           LoginViewController *lVC = [[LoginViewController alloc] init];
            LoginViewController *LLVC = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:[NSBundle mainBundle]];
//            (LoginViewController *)[[BaseViewController alloc] initWithNibName:@"LoginViewController" bundle:[NSBundle mainBundle]];
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:LLVC];
            [self presentViewController:nav animated:YES completion:nil];
        }
            break;
        case 1://幸运记录
        {
            LuckyRecordController *lrVC = [[LuckyRecordController alloc] init];
            self.navigationController.navigationBar.hidden = NO;
            lrVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:lrVC animated:YES];
        }
            break;
        case 2://我的红包
        {
            RedEnvelopeController *reVC = [[RedEnvelopeController alloc] init];
            self.navigationController.navigationBar.hidden = NO;
            reVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:reVC animated:YES];
        }
            break;
        case 3://我的晒单
        {
            InordertoshareController *ishVC = [[InordertoshareController alloc] init];
            self.navigationController.navigationBar.hidden = NO;
            ishVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:ishVC animated:YES];
        }
            break;
        case 4://充值记录
        {
            RechargeRecordController *rrVC = [[RechargeRecordController alloc] init];
            self.navigationController.navigationBar.hidden = NO;
            rrVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:rrVC animated:YES];
        }
            break;
        case 5://云购客服
        {
            CustomerCareController *ccVC = [[CustomerCareController alloc] init];
            self.navigationController.navigationBar.hidden = NO;
            ccVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:ccVC animated:YES];
        }
            break;
            
        default:
            break;
    }
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    NSLog(@"%f",-scrollView.contentOffset.y);
    
    //取得表视图的偏移量
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY <= 0) {
        //计算放大倍数
        CGFloat scale = (170+ABS(offsetY))/170;
        
        _bgIconView.transform = CGAffineTransformMakeScale(scale, scale);
        _bgIconView.top = 0;
        _titleLabel.top = 30;
        _msgBtn.top = 30;
        _setBtn.top = 30;

        
    }else {
        
        _bgIconView.top = -offsetY;
        _titleLabel.top = -offsetY + 30;
        _msgBtn.top = -offsetY + 30;
        _setBtn.top = -offsetY + 30;
    }
   
    //使titleLabel与headerImgView底部重合
//    _titleLabel.bottom = _headerImgView.bottom;
}


@end

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


@interface PersonViewController ()

@property (nonatomic,copy)NSString *identify;
@property (nonatomic,strong)NSArray *data;

@end

@implementation PersonViewController

#pragma mark - 导航栏
- (void)initNavBar{
    
    
    UIButton *rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40.f, 25.f)];
    rightButton.tag = 101;
    [rightButton setTitle:@"信息" forState:UIControlStateNormal];
//    [rightButton setBackgroundImage:[UIImage imageNamed:@""]
//                          forState:UIControlStateNormal];
    [rightButton addTarget:self
                   action:@selector(NavAction:)
         forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    
    UIButton *rightButton1 = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40.f, 25.f)];
    rightButton1.tag = 102;
    [rightButton1 setTitle:@"设置" forState:UIControlStateNormal];
//    [rightButton1 setBackgroundImage:[UIImage imageNamed:@""]
//                           forState:UIControlStateNormal];
    [rightButton1 addTarget:self
                    action:@selector(NavAction:)
          forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem1 = [[UIBarButtonItem alloc]initWithCustomView:rightButton1];
    self.navigationItem.rightBarButtonItems = @[rightItem,rightItem1];
    
}

- (void)NavAction:(UIButton *)button{
    
    if (button.tag == 101) {//信息
        
    }else if (button.tag == 102) {//设置
        
        SettingsController *setVC = [[SettingsController alloc] init];
        setVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:setVC animated:YES];
    }
    
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    self.navigationController.navigationBar.hidden = YES;
    //去掉导航栏下方的线
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init]
                       forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"个人中心";
    [self initNavBar];
    
    self.data = @[@"云购记录",@"幸运记录",@"我的红包",@"我的晒单",@"充值记录",@"云购客服"];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake((KScreenWidth-12*4)/3, (KScreenWidth-12*4)/3);
    layout.minimumLineSpacing = 10;
    layout.sectionInset = UIEdgeInsetsMake(12, 12, 12, 12);
    
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.collectionViewLayout = layout;
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    
    _identify = @"PersonCell";
    UINib *nib = [UINib nibWithNibName:@"PersonCell" bundle:nil];
    [_collectionView registerNib:nib forCellWithReuseIdentifier:_identify];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [_iconView addGestureRecognizer:tap];
}
#pragma mark - 按钮的点击
//余额
- (IBAction)balanceAction:(UIButton *)sender {
}
//充值
- (IBAction)rechargeAction:(UIButton *)sender {
    
    RechargeController *reVC = [[RechargeController alloc] init];
    reVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:reVC animated:YES];
}
//积分
- (IBAction)integralAction:(UIButton *)sender {
}
- (void)tapAction:(UITapGestureRecognizer *)tap {
    
    AboutMeController *amVC = [[AboutMeController alloc] init];
    amVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:amVC animated:YES];
}

#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.data.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PersonCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:_identify forIndexPath:indexPath];
    
    cell.titleLabel.text = self.data[indexPath.row];
    cell.iconView.image = [UIImage imageNamed:self.data[indexPath.row]];
    
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.row) {
        case 0://云购记录
        {
            SnatchRecordController *seVC = [[SnatchRecordController alloc] init];
            seVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:seVC animated:YES];
            //UIWindow *window = [UIApplication sharedApplication].keyWindow;
            //window.rootViewController = [[LoginViewController alloc] init];
        }
            break;
        case 1://幸运记录
        {
            LuckyRecordController *lrVC = [[LuckyRecordController alloc] init];
            lrVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:lrVC animated:YES];
        }
            break;
        case 2://我的红包
        {
            RedEnvelopeController *reVC = [[RedEnvelopeController alloc] init];
            reVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:reVC animated:YES];
        }
            break;
        case 3://我的晒单
        {
            InordertoshareController *ishVC = [[InordertoshareController alloc] init];
            ishVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:ishVC animated:YES];
        }
            break;
        case 4://充值记录
        {
            RechargeRecordController *rrVC = [[RechargeRecordController alloc] init];
            rrVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:rrVC animated:YES];
        }
            break;
        case 5://云购客服
        {
            CustomerCareController *ccVC = [[CustomerCareController alloc] init];
            ccVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:ccVC animated:YES];
        }
            break;
            
        default:
            break;
    }
}



@end

//
//  PersonalCenterController.m
//  掌上云购
//
//  Created by 杨浩斌 on 16/8/22.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import "PersonalCenterController.h"
#import "UIView+SDAutoLayout.h"
#import "SelectView.h"
#import "IndianaViewController.h"
#import "LuckViewController.h"
#import "SunViewController.h"
@interface PersonalCenterController ()<UIPageViewControllerDelegate,UIPageViewControllerDataSource>

{

    UIViewController *_willVC;
    
    SelectView *_selectView;

}

@property(nonatomic)UIPageViewController *pvc;
@property(nonatomic)NSMutableArray *subVCArray;

@end

@implementation PersonalCenterController
{


}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"TA的个人中心";
    
    _subVCArray = [NSMutableArray array];

   
    
    UIImage *image =[[UIImage imageNamed:@"返回"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIBarButtonItem *imageButton =[[UIBarButtonItem alloc]initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(leftClick:)];
    
    self.navigationItem.leftBarButtonItem = imageButton;
    
    //创建UI
    [self creatherderView];
    
    //创建页面
    [self creatControllers];
}

-(void)creatherderView
{

    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 100)];
    
    view.backgroundColor = [UIColor orangeColor];
    
    [self.view addSubview:view];
    
    
    //头像
    UIImageView *headerImg = [[UIImageView alloc]init];
    
    headerImg.layer.masksToBounds = YES;
    
    headerImg.layer.cornerRadius = 10;
    
    headerImg.image = [UIImage imageNamed:@"QQlogo"];
    
    [view addSubview:headerImg];
    
    headerImg.sd_layout
    .leftSpaceToView(view,20)
    .topSpaceToView(view,20)
    .widthIs(65)
    .heightIs(65);
    
    //用户名
    UILabel *userLabel = [[UILabel alloc]init];
    
    userLabel.text = @"无极剑圣";
    
    
    [view addSubview:userLabel];
    
    userLabel.sd_layout
    .leftSpaceToView(headerImg,30)
    .topEqualToView(headerImg)
    .widthIs(150)
    .heightIs(30);
    
    //用户ID
    UILabel *userID = [[UILabel alloc]init];
    
    userID.text = @"UID2313131";
    
    [view addSubview:userID];
    
    userID.sd_layout
    .leftEqualToView(userLabel)
    .topSpaceToView(userLabel,15)
    .widthIs(150)
    .heightIs(30);
    
    
}

-(void)creatControllers
{

 
    
    NSArray *subClasses = @[[IndianaViewController class],[LuckViewController class],[SunViewController class]];
    
    for (NSInteger i=0; i<3; i++) {
        
        UIViewController *vc = [[subClasses[i] alloc]init];
        
        [_subVCArray addObject:vc];
        
    }
    
    UIView * subView = [[UIView alloc] initWithFrame:self.view.bounds];

    subView.userInteractionEnabled = YES;
    
    [self.view addSubview:subView];
    
    _selectView = [[SelectView  alloc] initWithFrame:CGRectMake(0, 100, subView.frame.size.width, 50)];
    
    //_selectView.backgroundColor = [UIColor redColor];
    [subView addSubview:_selectView];
    
    _pvc = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    _pvc.view.frame = CGRectMake(0, 150, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 150);
    [self.view addSubview:_pvc.view];
    
    _pvc.dataSource = self;
    _pvc.delegate = self;
    
    [_pvc setViewControllers:@[_subVCArray[0]] direction:UIPageViewControllerNavigationDirectionReverse animated:NO completion:^(BOOL finished) {
        
    }];
    
    // 弱引用变量防止循环引用
    __weak typeof(self) weakSelf = self;
    [_selectView setCallbackBlock:^(NSInteger index) {
        [weakSelf.pvc setViewControllers:@[weakSelf.subVCArray[index]] direction:UIPageViewControllerNavigationDirectionReverse animated:NO completion:nil];
    }];

  
    
  
    
    
    


}





-(void)leftClick:(UIButton *)btn
{

    [self.navigationController popViewControllerAnimated:YES];

}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    
    for (NSInteger i = 0; i < 3; i++) {
        UIViewController * vc = _subVCArray[i];
        if (vc == viewController) {
            if (i < 2) {
                return _subVCArray[i + 1];
            }
        }
    }
    return nil;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    
    for (NSInteger i = 0; i < 3; i++) {
        UIViewController * vc = _subVCArray[i];
        if (vc == viewController) {
            if (i > 0) {
                return _subVCArray[i - 1];
            }
        }
    }
    return nil;
}

- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray *)pendingViewControllers {
    _willVC = pendingViewControllers[0];
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed {
    if (completed) {
        for (NSInteger i = 0; i < 3; i++) {
            UIViewController * vc = _subVCArray[i];
            if (vc == _willVC) {
                [_selectView selectBtn:i];
            }
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

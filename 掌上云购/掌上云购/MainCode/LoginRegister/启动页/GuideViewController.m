//
//  GuideViewController.m
//  掌上云购
//
//  Created by coco船长 on 2016/11/3.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import "GuideViewController.h"

@interface GuideViewController ()

@end

@implementation GuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    //轮播图
//    _bgScrollview = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, KScreenWidth , KScreenHeight) imagesGroup:@[[UIImage imageNamed:@"引导页-1"],[UIImage imageNamed:@"引导页-2"],[UIImage imageNamed:@"引导页-3"],[UIImage imageNamed:@"引导页-4"]]];
//    _bgScrollview.placeholderImage = [UIImage imageNamed:@"首页轮播_1.jpg"];
//    _bgScrollview.infiniteLoop = NO;
//    _bgScrollview.autoScroll = NO;
//    _bgScrollview.dotColor = [UIColor darkGrayColor];
//    _bgScrollview.titleLabelBackgroundColor = [UIColor lightGrayColor];
//    _bgScrollview.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
//    [self.view addSubview:_bgScrollview];
    
    _bgScrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth , KScreenHeight)];
    _bgScrollview.backgroundColor = [UIColor clearColor];
    _bgScrollview.delegate = self;
    _bgScrollview.pagingEnabled = YES;
    _bgScrollview.showsHorizontalScrollIndicator = NO;
    _bgScrollview.contentSize = CGSizeMake(KScreenWidth * 4, KScreenHeight);
    [self.view addSubview:_bgScrollview];
    
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(KScreenWidth / 4, KScreenHeight - 56, KScreenWidth /2 , 20.f)];
    _pageControl.numberOfPages = 4;
    //当前圆点的颜色
    _pageControl.currentPageIndicatorTintColor = [UIColor darkGrayColor];
    //圆点的默认颜色
    _pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    [self.view addSubview:_pageControl];
    
    for (int i = 0 ; i < 4; i ++) {
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(KScreenWidth * i , 0 , KScreenWidth, KScreenHeight)];
        imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"引导页-%d",i + 1]];
        [_bgScrollview addSubview:imageView];
        
    }
    
    _actionButton = [[UIButton alloc] initWithFrame:CGRectMake(KScreenWidth * 10 / 3, KScreenHeight - 110, KScreenWidth / 3 , 30.f)];
    [_actionButton setBackgroundImage:[UIImage imageNamed:@"引导页-按钮"]
                             forState:UIControlStateNormal];
    [_actionButton setTitle:@"立即夺宝"
                   forState:UIControlStateNormal];
    [_actionButton addTarget:self
                      action:@selector(acionAction:)
            forControlEvents:UIControlEventTouchUpInside];
    [_bgScrollview addSubview:_actionButton];
    
}

- (void)acionAction:(UIButton *)button{

    id next = [self nextResponder];
    while (next != nil) {
        
        if ([next isKindOfClass:[UIWindow class]]) {
            
            UIWindow *window = next;
            TabbarViewcontroller *tb = [[TabbarViewcontroller alloc]init];
            window.rootViewController = tb;
            return;
        }
        next = [next nextResponder];
    }
    
}

#pragma mark - scrollViewDelegeta
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    //根据偏移量计算页码
    NSInteger page = scrollView.contentOffset.x / KScreenWidth;
    _pageControl.currentPage = page;
    
}

@end

//
//  TabbarViewcontroller.m
//  掌上云购
//
//  Created by coco船长 on 16/8/3.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import "TabbarViewcontroller.h"

@interface TabbarViewcontroller ()

@end

@implementation TabbarViewcontroller

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self _createTabbarView];
    
    [self _createViewControllers];
    
    self.automaticallyAdjustsScrollViewInsets = YES;
    
}

//创建标签页
- (void)_createTabbarView{
    
    // 按钮的图片数组
    NSArray *imageArray = @[@"首页",@"揭晓",@"发现",@"购物车",@"我的"];
    
    // 按钮的标题数组
    NSArray *titleArray = @[@"首页",@"揭晓",@"发现",@"购物车",@"我的"];
    
    // 按钮的宽、高
    CGFloat width = KScreenWidth / (float)titleArray.count;
    CGFloat height = self.tabBar.frame.size.height;
    
    for (int i = 0; i < titleArray.count; i++) {
        
        CGRect frame = CGRectMake(width * i, 0, width, height);
        //使用自定义的按钮样式
        TabbarItem *item = [[TabbarItem alloc] initWithFrame:frame
                                                   imageName:imageArray[i]
                                                       title:titleArray[i]];
        item.tag = i + 1;
        if (i == 0) {
            item.isSelected = YES;
            _selectedItem = item;
        }
        
        [item addTarget:self action:@selector(selectAction:)
       forControlEvents:UIControlEventTouchUpInside];
        [self.tabBar addSubview:item];
    }
    
}

- (void)selectAction:(TabbarItem *)item {
    
    // 更改选中按钮的状态
    if (item != _selectedItem) {
        
        item.isSelected = YES;
        _selectedItem.isSelected = NO;
        _selectedItem = item;
        //跳转至对应的控制器
        self.selectedIndex = item.tag - 1;
    }
}

//创建子控制器
- (void)_createViewControllers{
    
    _controllers = [NSMutableArray array];
    
    HomeViewController *HVC = [[HomeViewController alloc] init];
    UINavigationController *HNVC = [[UINavigationController alloc] initWithRootViewController:HVC];
    [_controllers addObject:HNVC];
    
    AnnounceViewController *AVC = [[AnnounceViewController alloc] init];
    UINavigationController  *ANVC = [[UINavigationController alloc] initWithRootViewController:AVC];
    [_controllers addObject:ANVC];
    
    DiscoverViewController *DVC = [[DiscoverViewController alloc] init];
    UINavigationController  *DNVC = [[UINavigationController alloc] initWithRootViewController:DVC];
    [_controllers addObject:DNVC];
    
    CartViewController *CVC = [[CartViewController alloc] init];
    UINavigationController *CNVC = [[UINavigationController alloc] initWithRootViewController:CVC];
    [_controllers addObject:CNVC];
    
    PersonViewController *PVC = [[PersonViewController alloc] init];
    UINavigationController *PNVC = [[UINavigationController alloc] initWithRootViewController:PVC];
    [_controllers addObject:PNVC];
    
    self.viewControllers = _controllers;
    
}

//去掉原有标签控制器按钮
- (void)viewWillLayoutSubviews{
    
    [super viewWillLayoutSubviews];
    
    NSArray *subViews = self.tabBar.subviews;
    for (UIView *view in subViews) {
        
        Class cla = NSClassFromString(@"UITabBarButton");
        if ([view isKindOfClass:cla]) {
            
            [view removeFromSuperview];
            
        }
    }
}

@end

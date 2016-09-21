//
//  TabbarViewcontroller.h
//  掌上云购
//
//  Created by coco船长 on 16/8/3.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HomeViewController.h"
#import "AnnounceViewController.h"
#import "DiscoverViewController.h"
#import "PersonViewController.h"
#import "CartViewController.h"
#import "TabbarItem.h"

@interface TabbarViewcontroller : UITabBarController{

    UILabel *_countLabel;

}

@property (nonatomic,strong)TabbarItem *selectedItem;
@property (nonatomic ,strong)NSMutableArray *controllers;

@property (nonatomic, assign)NSInteger cartNum;

@end

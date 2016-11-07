//
//  GuideViewController.h
//  掌上云购
//
//  Created by coco船长 on 2016/11/3.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SDCycleScrollView.h"
#import "TabbarViewcontroller.h"

@interface GuideViewController : UIViewController<UIScrollViewDelegate>{

    UIScrollView    *_bgScrollview;
    UIPageControl   *_pageControl;
    
    UIButton        *_actionButton;
    
}

@end

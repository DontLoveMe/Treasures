//
//  HomeViewController.h
//  掌上云购
//
//  Created by coco船长 on 16/8/3.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import "BaseViewController.h"

#import "SDCycleScrollView.h"
#import "SegmentController.h"
#import "WingNotificationTableView.h"
#import "HomeFunctionControl.h"
#import "HomeGoodsCell.h"

#import "GoodsDetailController.h"
#import "HomeSearchController.h"

@interface HomeViewController : BaseViewController<SDCycleScrollViewDelegate,WingTableDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,homeGoodsCellDelegate>{
 
    //背景
    UIScrollView        *_bgScrollView;
    
    //顶部banner
    SDCycleScrollView   *_topBannerView;
    
    //中奖提示
    WingNotificationTableView *_wingTable;
    
    //四大功能
    UIView              *_functionView;
    
    //商品展示
    UIView              *_segmentView;
    UICollectionView    *_goodsList;
    
    //数据
    NSMutableArray      *_goodsArr;
    
    //banner数据
    NSMutableArray      *_bannerArr;

}
@end

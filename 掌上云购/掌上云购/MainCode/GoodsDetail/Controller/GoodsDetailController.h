//
//  GoodsDetailController.h
//  掌上云购
//
//  Created by coco船长 on 16/8/16.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import "BaseViewController.h"

#import "TabbarViewController.h"
#import "TabbarItem.h"

#import "SDCycleScrollView.h"
#import "WingNotificationTableView.h"
#import "GoodsDetailFunctionTableView.h"
#import "BroughtHistoryView.h"

#import "UIScrollView+MJRefresh.h"

@interface GoodsDetailController : BaseViewController<SDCycleScrollViewDelegate,WingTableDelegate,BroughtHistoryDelegate,UIScrollViewDelegate>{

    //背景
    UIScrollView        *_bgScrollView;
    
    //顶部banner
    SDCycleScrollView   *_topGoodImgView;
    //中奖提示
    WingNotificationTableView *_jionTable;
    //购物车按钮
    UIButton            *_cartButton;
    //消息中心按钮
    UIButton            *_messageCenterButton;
    //商品类别标记
    UIImageView         *_markImg;
    
    //商品名
    UILabel             *_goodsName;

    //其他功能
    GoodsDetailFunctionTableView *_oherFunctionTableView;
    
    //底部视图
    UIImageView         *_bottomView;
    //立即购买按钮
    UIButton            *_buyNowButton;
    //加入清单按钮
    UIButton            *_addToCartButton;
    //购物车按钮
    UIButton            *_cartBottomButton;
    //（揭晓或者开奖后）
    UILabel             *_newOrderNumLabel;
    //前往新一期按钮
    UIButton            *_gotoNewOrderButton;
    
    //购买记录页面
    BroughtHistoryView  *_broughtHistoryView;
    
    //商品详情字典
    NSDictionary        *_dataDic;
    
    //商品参与记录数组
    NSMutableArray      *_joinRecordArr;
    NSInteger           _pageIndex;
    
}

//标记是否参与(0:尚未参加 1:已参加)
@property (nonatomic ,assign)NSInteger isJoind;
//标记是否揭晓(1:尚未揭晓 2:正在揭晓 3:已揭晓)
@property (nonatomic ,assign)NSInteger isAnnounced;
//标记是否中奖(前置条件：已揭晓。0:尚未中奖 1:中奖)
@property (nonatomic ,assign)NSInteger isPrized;


//商品id
@property (nonatomic ,copy)NSString *goodsId;
//期数ID
@property (nonatomic ,copy)NSString *drawId;

@end

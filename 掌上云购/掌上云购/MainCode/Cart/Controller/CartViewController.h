//
//  CartViewController.h
//  掌上云购
//
//  Created by coco船长 on 16/8/3.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import "BaseViewController.h"

#import "CartTableViewCell.h"
#import "CartTools.h"
#import "UIView+SDAutoLayout.h"
#import "PayViewController.h"

@interface CartViewController :BaseViewController <UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,CartFunctionDelegate>{
    
    UIButton    *_rightbtn;
    //购物车列表
    UITableView *_tabview;
    //底部视图
    UIView      *_bottomView;
    //无列表视图
    UIView      *_backView;
    UIImageView *_carView;
    UILabel     *_textLabel;
    UIButton    *_buyBtn;
    UILabel     *_likeLabel;
    UICollectionView *_collectView;
    //商品总数
    UILabel     *_goodstotal;
    //商品总价格
    UILabel     *_pricetotal;
    //商品总钱数
    UILabel     *_pricesum;
    //警示语
    UILabel     *_warntext;
    //结算按钮
    UIButton    *_settlebtn;
    
    //购物车数据
    NSMutableArray *_dataArray;
    //单元格标示符
    NSString *_identify;
    //是否为编辑模式
    NSInteger specialTag;

    
}

@end

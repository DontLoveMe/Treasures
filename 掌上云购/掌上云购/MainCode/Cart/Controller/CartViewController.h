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
#import "TabbarViewController.h"
#import "TabbarItem.h"
#import "LoveView.h"

@interface CartViewController :BaseViewController <UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,CartFunctionDelegate>{
    
    UIButton        *_rightbtn;
    //购物车列表
    UITableView     *_tabview;
    //底部视图
    UIView          *_bottomView;
    //商品总数
    UILabel         *_goodstotal;
    //商品总价格
    UILabel         *_pricetotal;
    //商品总钱数
    UILabel         *_pricesum;
    //警示语
    UILabel         *_warntext;
    //结算按钮
    UIButton        *_settlebtn;
    
    //底部翻转视图
    UIView          *_deleteView;
    
    //全选按钮
    UIButton        *_allSelectButton;
    //全选label
    UILabel         *_allSelectLabel;
    //已选label
    UILabel         *_selectedNumLabel;
    //删除按钮
    UIButton        *_deleteButton;
    
    //无列表视图
    UIView          *_backView;
    UIImageView     *_carView;
    UILabel         *_textLabel;
    UIButton        *_buyBtn;
    UILabel         *_likeLabel;
    LoveView        *_loveView;

    //购物车数据
    NSMutableArray  *_dataArray;
    //单元格标示符
    NSString        *_identify;
    //是否为编辑模式
    NSInteger       specialTag;
    //已选数量
    NSInteger       selectNum;

}

@end

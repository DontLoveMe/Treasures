//
//  SearchGoodsController.h
//  掌上云购
//
//  Created by 刘毅 on 16/9/6.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import "BaseViewController.h"
#import "SearchGoodsCell.h"
#import "HistoryData.h"
#import "GoodsModel.h"
#import "GoodsDetailController.h"

@interface SearchGoodsController : BaseViewController<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,searchGoodsCellDelegate>

@property (nonatomic,copy)NSString *searchStr;

@end

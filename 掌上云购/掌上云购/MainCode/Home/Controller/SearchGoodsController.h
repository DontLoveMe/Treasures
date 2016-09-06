//
//  SearchGoodsController.h
//  掌上云购
//
//  Created by 刘毅 on 16/9/6.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import "BaseViewController.h"

@interface SearchGoodsController : BaseViewController<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>

@property (nonatomic,copy)NSString *searchStr;

@end

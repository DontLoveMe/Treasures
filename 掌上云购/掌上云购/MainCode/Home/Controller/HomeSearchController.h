//
//  HomeSearchController.h
//  掌上云购
//
//  Created by coco船长 on 16/8/18.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import "BaseViewController.h"

@interface HomeSearchController : BaseViewController<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>{

    UISearchBar *_searchBar;
    
    UITableView *_searchHistoryTable;
    
//    UIImageView *_separateLine;
    
    UILabel     *_hotSearchLabel;
    
    NSArray   *_historyData;
    
    UIImageView *_redPoint;
}

@end

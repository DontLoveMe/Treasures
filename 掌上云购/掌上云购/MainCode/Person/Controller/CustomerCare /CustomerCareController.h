//
//  CustomerCareController.h
//  掌上云购
//
//  Created by 刘毅 on 16/8/17.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import "BaseViewController.h"

@interface CustomerCareController : BaseViewController
<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentCtl;
@property (nonatomic, strong)NSArray *data;

@end

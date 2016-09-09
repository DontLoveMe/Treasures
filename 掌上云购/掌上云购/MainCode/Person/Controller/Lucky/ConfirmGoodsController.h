//
//  ConfirmGoodsController.h
//  掌上云购
//
//  Created by 刘毅 on 16/8/20.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import "BaseViewController.h"
#import "RecordModel.h"


@interface ConfirmGoodsController : BaseViewController<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UIButton *againButton;

@property (nonatomic,strong)RecordModel *reModel;

@end

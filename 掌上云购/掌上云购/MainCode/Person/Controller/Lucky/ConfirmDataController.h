//
//  ConfirmDataController.h
//  掌上云购
//
//  Created by 刘毅 on 16/8/19.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import "BaseViewController.h"
#import "RecordModel.h"
#import "GoodsStateCell.h"

@interface ConfirmDataController : BaseViewController<UITableViewDelegate,UITableViewDataSource,GoodsStateCellDelegate>

@property (nonatomic,assign)NSInteger state;

@property (nonatomic,strong)RecordModel *rcModel;

@end

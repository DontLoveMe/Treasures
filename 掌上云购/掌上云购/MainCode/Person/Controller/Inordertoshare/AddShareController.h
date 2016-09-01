//
//  AddShareController.h
//  掌上云购
//
//  Created by 刘毅 on 16/9/1.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import "BaseViewController.h"
#import "RecordModel.h"

@interface AddShareController : BaseViewController<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic ,strong)RecordModel *lkModel;

@end

//
//  GoodsDetailFunctionTableView.h
//  掌上云购
//
//  Created by coco船长 on 16/8/16.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AnnouncedHistoryController.h"
#import "GoodsDetailPTController.h"
#import "CountWayController.h"

@interface GoodsDetailFunctionTableView : UITableView<UITableViewDelegate,UITableViewDataSource>

//用来区分是否参加此夺宝：0为未参加，1为已参加
@property (nonatomic,assign)NSInteger isJoin;
//标记是否揭晓(0:尚未揭晓 1:正在揭晓 2:已揭晓)
@property (nonatomic ,assign)NSInteger isAnnounced;
//标记是否中奖(前置条件：已揭晓。0:尚未中奖 1:中奖)
@property (nonatomic ,assign)NSInteger isPrized;

@end

//
//  GoodsDetailFunctionTableView.h
//  掌上云购
//
//  Created by coco船长 on 16/8/16.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ProgressView.h"
#import "AnnouncedHistoryController.h"
#import "GoodsDetailPTController.h"
#import "CountWayController.h"
#import "PreviewAllController.h"
#import "SunSharingViewController.h"
#import "CountDown.h"

@interface GoodsDetailFunctionTableView : UITableView<UITableViewDelegate,UITableViewDataSource>

//用来区分是否参加此夺宝：0为未参加，1为已参加
@property (nonatomic,assign)NSInteger isJoin;
//标记是否揭晓(1:尚未揭晓 2:正在揭晓 3:已揭晓)
@property (nonatomic ,assign)NSInteger isAnnounced;
//标记是否中奖(前置条件：已揭晓。0:尚未中奖 1:中奖)
@property (nonatomic ,assign)NSInteger isPrized;

//商品信息
@property (nonatomic ,strong)NSDictionary *dataDic;
////期号
//@property (nonatomic ,copy)NSString *goodSID;
////总量
//@property (nonatomic ,assign)NSInteger  progress;
//倒计时时间
@property (nonatomic,assign) NSInteger countDownTime;

@property (strong, nonatomic)  CountDown *countDown;
//倒计时lable
@property (strong, nonatomic) UILabel *countDownLabel;

@property (copy, nonatomic)void(^countDownBlock)();

@end

//
//  WingNotificationTableView.h
//  掌上云购
//
//  Created by coco船长 on 16/8/15.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "WingNotificationCell.h"

@protocol WingTableDelegate <NSObject>

@optional
- (void)WingNotificationTableViewTimerInvalidate;

@end

@interface WingNotificationTableView : UITableView<UITableViewDelegate,UITableViewDataSource>{

    NSTimer                 *_timer;
    NSInteger               _currentProcess;

}

@property (nonatomic,strong)NSArray *dataArr;

@property (weak,nonatomic)id<WingTableDelegate> timerDelegate;

@end

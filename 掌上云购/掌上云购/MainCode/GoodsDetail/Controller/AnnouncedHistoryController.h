//
//  AnnouncedHistoryController.h
//  掌上云购
//
//  Created by coco船长 on 16/8/18.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import "BaseViewController.h"

#import "AnnounceHistoryCell.h"

@interface AnnouncedHistoryController : BaseViewController<UITableViewDelegate,UITableViewDataSource>{

    UITableView *_announcedTableView;

}

@end

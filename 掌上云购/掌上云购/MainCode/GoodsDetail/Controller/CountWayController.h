//
//  CountWayController.h
//  掌上云购
//
//  Created by coco船长 on 16/8/18.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import "BaseViewController.h"

@interface CountWayController : BaseViewController<UITableViewDelegate,UITableViewDataSource>{

    UITableView             *_descriptionTable;
    
    NSMutableDictionary     *_dataDic;
    
    NSArray                 *_titleArr;
    
    NSArray                 *_valueArr;
    
    NSInteger               _isOpen;
    
    NSMutableArray          *_AvalueArr;
    
}

@property (nonatomic,assign)NSInteger isAnnounced;
@property (nonatomic,copy)NSString *drawID;

@end

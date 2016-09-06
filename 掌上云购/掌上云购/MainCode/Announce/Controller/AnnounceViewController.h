//
//  AnnounceViewController.h
//  掌上云购
//
//  Created by coco船长 on 16/8/3.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import "BaseViewController.h"

#import "GoodsDetailController.h"

#import "AnnounceCell.h"

@interface AnnounceViewController : BaseViewController<UICollectionViewDelegate,UICollectionViewDataSource,AnnounceCellDelegate>{

    NSMutableArray *_dataArr;

}

@end

//
//  PreviewAllController.h
//  掌上云购
//
//  Created by coco船长 on 16/9/8.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import "BaseViewController.h"

#import "HotCollectionCell.h"
#import "CollectionViewLeftAlignedLayout.h"

@interface PreviewAllController : BaseViewController<UICollectionViewDelegate,UICollectionViewDataSource>{

    __weak IBOutlet UILabel *goodName;

    __weak IBOutlet UILabel *drawNum;

    __weak IBOutlet UILabel *drawTime;
    
    __weak IBOutlet UILabel *luckyNum;
    
    __weak IBOutlet UILabel *drawListLabel;
    __weak IBOutlet UICollectionView *joinRecordCollectionView;
    
    NSMutableArray  *joinRecordList;
    
//    __weak IBOutlet UILabel *joinNum;
}

@property (nonatomic ,strong)NSDictionary *dataDic;

@end

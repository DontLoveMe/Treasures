//
//  HotSearchCell.h
//  掌上云购
//
//  Created by 刘毅 on 16/8/22.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HotSearchCell : UITableViewCell<UICollectionViewDelegate,UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (nonatomic, strong) NSArray *hotData;

@property (nonatomic, copy) void(^hotSearchString)(NSString *hotString);

@end

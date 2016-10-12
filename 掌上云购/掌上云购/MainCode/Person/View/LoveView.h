//
//  LoveView.h
//  掌上云购
//
//  Created by 刘毅 on 16/9/7.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoveView : UIView<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong)UICollectionView *collectionView;
@property (nonatomic,strong)UILabel *loveLabel;
@property (nonatomic,strong)NSArray *loveData;

- (void)requestLoveData;

@end

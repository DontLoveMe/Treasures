//
//  ProductCollectionView.h
//  test
//
//  Created by 刘毅 on 16/7/28.
//  Copyright © 2016年 刘毅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductCell.h"
#import "GoodsModel.h"

@interface ProductCollectionView : UICollectionView<UICollectionViewDelegate,UICollectionViewDataSource,ProductCellDelegate>

@property (nonatomic,strong)NSArray *data;

@end

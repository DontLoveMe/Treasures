//
//  ProductCell.h
//  test
//
//  Created by 刘毅 on 16/7/28.
//  Copyright © 2016年 刘毅. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BaseViewController.h"
#import "ProgressView.h"
#import "GoodsModel.h"

@protocol ProductCellDelegate <NSObject>

@optional
- (void)addToCartWithIndexpath:(NSIndexPath *)nowIndexpath;

@end

@interface ProductCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *productImg;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UILabel *progressLb;

@property (weak, nonatomic) IBOutlet ProgressView *progressView;

@property (weak, nonatomic) IBOutlet UIButton *participateButton;
@property (weak, nonatomic) IBOutlet UIImageView *typeMarkImgView;

@property (nonatomic,strong)GoodsModel *gsModel;

@property (nonatomic ,strong)NSIndexPath *nowIndexpath;

@property (nonatomic, weak)id<ProductCellDelegate> productDelegate;

@end

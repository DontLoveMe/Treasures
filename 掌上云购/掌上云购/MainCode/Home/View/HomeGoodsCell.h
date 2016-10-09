//
//  HomeGoodsCell.h
//  掌上云购
//
//  Created by coco船长 on 16/8/15.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ProgressView.h"

@protocol homeGoodsCellDelegate <NSObject>

@optional
- (void)addToCartWithIndexpath:(NSIndexPath *)nowIndexpath;

@end

@interface HomeGoodsCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *goodsPic;

@property (weak, nonatomic) IBOutlet UILabel *goodsName;

@property (weak, nonatomic) IBOutlet UILabel *progressLabel;

@property (weak, nonatomic) IBOutlet ProgressView *progressView;
@property (weak, nonatomic) IBOutlet UIImageView *typeMarkImgView;

- (IBAction)addToCart:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *sumLabel;

@property (nonatomic,strong)UIImageView *activityImgview;

@property (nonatomic ,strong)NSDictionary *dataDic;

@property (nonatomic ,strong)NSIndexPath *nowIndexpath;

@property (weak ,nonatomic)id <homeGoodsCellDelegate> delegate;

@end

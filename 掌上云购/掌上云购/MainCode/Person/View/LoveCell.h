//
//  LoveCell.h
//  掌上云购
//
//  Created by 刘毅 on 16/9/9.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ProgressView.h"
#import "GoodsModel.h"

@interface LoveCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet ProgressView *progressView;
@property (weak, nonatomic) IBOutlet UILabel *progressLb;

@property (nonatomic,strong)GoodsModel *gsModel;

@end

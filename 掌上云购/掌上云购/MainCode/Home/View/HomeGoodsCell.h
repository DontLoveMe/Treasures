//
//  HomeGoodsCell.h
//  掌上云购
//
//  Created by coco船长 on 16/8/15.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeGoodsCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *goodsPic;

@property (weak, nonatomic) IBOutlet UILabel *goodsName;

@property (weak, nonatomic) IBOutlet UILabel *progressLabel;

@property (weak, nonatomic) IBOutlet UIImageView *progressView;

- (IBAction)addToCart:(id)sender;


@end

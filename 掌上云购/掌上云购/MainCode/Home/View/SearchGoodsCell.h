//
//  SearchGoodsCell.h
//  掌上云购
//
//  Created by 刘毅 on 16/9/6.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GoodsModel.h"
#import "ProgressView.h"

@interface SearchGoodsCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *addListBtn;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UILabel *surplusLable;
@property (weak, nonatomic) IBOutlet ProgressView *progressView;

@property (strong, nonatomic)GoodsModel *gsModel;

@end

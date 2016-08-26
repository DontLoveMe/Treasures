//
//  ProductCell.h
//  test
//
//  Created by 刘毅 on 16/7/28.
//  Copyright © 2016年 刘毅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *productImg;
@property (weak, nonatomic) IBOutlet UILabel *titleLable;


@property (weak, nonatomic) IBOutlet UIButton *participateButton;



@end

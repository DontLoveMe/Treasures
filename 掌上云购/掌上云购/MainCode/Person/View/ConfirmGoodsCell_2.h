//
//  ConfirmGoodsCell-2.h
//  掌上云购
//
//  Created by 刘毅 on 16/8/20.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ConfirmGoodsCellDelegate <NSObject>

@optional
- (void)clickButtonBackTag:(NSInteger)tag;

@end
@interface ConfirmGoodsCell_2 : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *stateView1;
@property (weak, nonatomic) IBOutlet UIImageView *stateView2;
@property (weak, nonatomic) IBOutlet UILabel *stateLabel1;
@property (weak, nonatomic) IBOutlet UILabel *stateLable2;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel1;
@property (weak, nonatomic) IBOutlet UIButton *mannerBtn1;
@property (weak, nonatomic) IBOutlet UIButton *mannerBtn2;
@property (weak, nonatomic) IBOutlet UIButton *agreeBtn;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;

@property (nonatomic,weak)id<ConfirmGoodsCellDelegate> delegate;

@end

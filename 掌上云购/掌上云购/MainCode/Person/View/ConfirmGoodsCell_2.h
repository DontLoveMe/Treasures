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
- (void)getUserName:(NSString *)userName;
- (void)selectMannerValue:(NSInteger)value;

@end
@interface ConfirmGoodsCell_2 : UITableViewCell<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *stateView1;
@property (weak, nonatomic) IBOutlet UIImageView *stateView2;
@property (weak, nonatomic) IBOutlet UILabel *stateLabel1;
@property (weak, nonatomic) IBOutlet UILabel *stateLable2;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel1;

@property (weak, nonatomic) IBOutlet UIButton *agreeBtn;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;

@property (strong, nonatomic) UITextField *userNameTF;

@property (nonatomic,weak)id<ConfirmGoodsCellDelegate> delegate;

@property (nonatomic,strong)NSArray *dicts;

@end

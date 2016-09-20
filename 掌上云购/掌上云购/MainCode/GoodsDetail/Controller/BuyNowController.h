//
//  BuyNowControllerViewController.h
//  掌上云购
//
//  Created by 刘毅 on 16/9/20.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BuyNowControllerDelegate <NSObject>

- (void)backBuyNumber:(NSInteger)buyNumber;

@end

@interface BuyNowController : UIViewController<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UITextField *buyNumberTF;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (nonatomic,assign)NSInteger money;

@property (nonatomic,assign)NSInteger maxNumber;

@property (nonatomic,weak)id<BuyNowControllerDelegate> delegate;

@end

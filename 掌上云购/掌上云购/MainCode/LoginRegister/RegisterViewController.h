//
//  RegisterViewController.h
//  掌上云购
//
//  Created by 刘毅 on 16/8/8.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import "BaseViewController.h"

@interface RegisterViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UITextField *usernameTF;

@property (weak, nonatomic) IBOutlet UITextField *validateTF;
@property (weak, nonatomic) IBOutlet UITextField *passwrodTF;
@property (weak, nonatomic) IBOutlet UITextField *rePasswordTF;
@property (weak, nonatomic) IBOutlet UIButton *validataButton;
@property (strong,nonatomic) UILabel *validataLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *vdTFHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *vdBtnHeight;
@property (weak, nonatomic) IBOutlet UIButton *userDgtBtn;

@property (weak, nonatomic) IBOutlet UIButton *actionButton;
@property (weak, nonatomic) IBOutlet UIButton *agreeButton;
@property (weak, nonatomic) IBOutlet UIView *bottomView;

//0代表注册,1代表找回密码,2代表修改密码,3第三方登录绑定手机。默认为0。
@property (nonatomic,assign)NSInteger isRegistOrmodify;

//@property (nonatomic,strong)NSDictionary *userParams;

@end

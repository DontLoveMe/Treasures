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

@property (weak, nonatomic) IBOutlet UIButton *actionButton;

//0代表注册，1代表修改密码。默认为0。
@property (nonatomic,assign)NSInteger isRegistOrmodify;

@end

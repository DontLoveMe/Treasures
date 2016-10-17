//
//  FirstGuideController.h
//  掌上云购
//
//  Created by coco船长 on 16/10/17.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import "BaseViewController.h"

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "HomeViewController.h"

@interface FirstGuideController : BaseViewController<ChangeIndexDelegeta,UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UILabel *remaindLabel;
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;

@property (weak, nonatomic) IBOutlet UIButton *enSureButton;
@property (weak, nonatomic) IBOutlet UIButton *closeButton;

- (IBAction)CloseAction:(id)sender;

- (IBAction)ensureAction:(id)sender;

@end

//
//  LoginViewController.m
//  掌上云购
//
//  Created by 刘毅 on 16/8/8.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "TabbarViewcontroller.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
//注册
- (IBAction)registerActiion:(UIButton *)sender {
    
    RegisterViewController *rVC = [[RegisterViewController alloc] init];
    rVC.isRegistOrmodify = 0;
    rVC.title = @"用户注册";
    UINavigationController *rnVC = [[UINavigationController alloc] initWithRootViewController:rVC];
    [self presentViewController:rnVC animated:YES completion:nil];
}

//忘记密码
- (IBAction)forgottenPassword:(id)sender {
    
    RegisterViewController *rVC = [[RegisterViewController alloc] init];
    rVC.isRegistOrmodify = 1;
    rVC.title = @"找回密码";
    UINavigationController *rnVC = [[UINavigationController alloc] initWithRootViewController:rVC];
    [self presentViewController:rnVC animated:YES completion:nil];
    
}


//登录
- (IBAction)loginAction:(UIButton *)sender {
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setObject:_userNameTF.text forKey:@"userAccount"];
    [params setObject:[MD5Security MD5String:_passwordTF.text] forKey:@"userPwd"];
    [params setObject:@"4" forKey:@"deviceType"];
    
    NSString *url = [NSString stringWithFormat:@"%@%@",BASE_URL,Login_URL];
    [ZSTools post:url
           params:params
          success:^(id json) {
              
              NSLog(@"返回信息:%@",[json objectForKey:@"msg"]);
              BOOL flag = [[json objectForKey:@"flag"] boolValue];
              if (flag == 1) {
                  
                  UIWindow *window = [UIApplication sharedApplication].keyWindow;
                  window.rootViewController = [[TabbarViewcontroller alloc] init];
                  
              }
              
           } failure:^(NSError *error) {
               
           }];


}
//关于
- (IBAction)aboutUsAction:(UIButton *)sender {
}
//保障说明
- (IBAction)explainAction:(UIButton *)sender {
}
//隐私协议
- (IBAction)privacyPolicAction:(UIButton *)sender {
}
//微信登录
- (IBAction)wechatLogin:(UIButton *)sender {
}
//QQ登录
- (IBAction)QQLogin:(UIButton *)sender {
}

#pragma mark - 监听键盘事件
- (void)viewWillAppear:(BOOL)animated{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHidden:) name:UIKeyboardWillHideNotification object:nil];
    
}

- (void)viewDidDisappear:(BOOL)animated{
    
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    
}

- (void)keyboardWasShown:(NSNotification*)aNotification{
    
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    if (KScreenHeight - kNavigationBarHeight - _userNameTF.bottom > kbSize.height - 60) {
            CGRect rect1 = self.view.frame;
            rect1.origin.y = kbSize.height - KScreenHeight + kNavigationBarHeight + _userNameTF.bottom - 60;
        self.view.frame = rect1;
    }

    
}

- (void)keyboardWillBeHidden:(NSNotification*)aNotification{
    
    CGRect rect1 = self.view.frame;
    rect1.origin.y = 0;
    self.view.frame = rect1;
    
}

#pragma mark - 键盘收起事件
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    if ([_userNameTF isFirstResponder]) {
        
        [_userNameTF resignFirstResponder];
        
    }
    
    if ([_passwordTF isFirstResponder]) {
        
        [_passwordTF resignFirstResponder];
        
    }
    
}

@end

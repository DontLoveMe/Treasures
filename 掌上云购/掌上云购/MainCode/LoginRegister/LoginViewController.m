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

#pragma mark - 导航栏
- (void)initNavBar{
    
    self.navigationItem.backBarButtonItem = nil;
    UIButton *leftButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40.f, 25.f)];
    leftButton.tag = 101;
    [leftButton setTitle:@"取消" forState:UIControlStateNormal];
//    [leftButton setBackgroundImage:[UIImage imageNamed:@"返回.png"]
//                          forState:UIControlStateNormal];
    [leftButton addTarget:self
                   action:@selector(NavAction:)
         forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftItem;
    
}

- (void)NavAction:(UIButton *)button{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"登录";
    self.view.backgroundColor = [UIColor colorFromHexRGB:@"E6E6E6"];
    [self initNavBar];
   
    [self setTextField];
}
//设置输入框两边的图片
- (void)setTextField {
    _userNameTF.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"用户"]];
    _userNameTF.leftViewMode = UITextFieldViewModeAlways;
    
    _passwordTF.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"密码"]];
    _passwordTF.leftViewMode = UITextFieldViewModeAlways;
    
    UIButton *plaintextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    plaintextBtn.size = CGSizeMake(40, 25);
    [plaintextBtn setImage:[UIImage imageNamed:@"明文"] forState:UIControlStateNormal];
    [plaintextBtn addTarget:self action:@selector(plaintextAction:) forControlEvents:UIControlEventTouchUpInside];
    _passwordTF.rightView = plaintextBtn;
    _passwordTF.rightViewMode = UITextFieldViewModeAlways;
}
//明暗文切换
- (void)plaintextAction:(UIButton *)button{
    _passwordTF.secureTextEntry = !_passwordTF.secureTextEntry;
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
                  //把信息存到NSUserDefaults
                  NSMutableDictionary *userDic = [[json objectForKey:@"data"] mutableCopy];
                  for (int i = 0; i < userDic.allKeys.count; i ++) {
                      
                      if ([[userDic objectForKey:userDic.allKeys[i]] isEqual:[NSNull null]]) {
                          
                          [userDic removeObjectForKey:userDic.allKeys[i]];
                          i = 0;
                      }
                      if ([userDic.allKeys[i] isEqualToString:@"userLoginDto"]) {
                          NSMutableDictionary *userLoginDic = [userDic[@"userLoginDto"] mutableCopy];
                          for (int j = 0; j< userLoginDic.allKeys.count; j ++) {
                              if ([[userLoginDic objectForKey:userLoginDic.allKeys[j]] isEqual:[NSNull null]]) {
                                  [userLoginDic removeObjectForKey:userLoginDic.allKeys[j]];
                                  j = 0;
                              }
                              userDic[@"userLoginDto"] = userLoginDic;
                          }
                          
                      }
                  }
                  
                  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                  
                  [defaults setObject:userDic forKey:@"userDic"];
                  
                  [defaults synchronize];

                  
                  [self dismissViewControllerAnimated:YES completion:nil];
                  
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
    [ShareSDK getUserInfo:SSDKPlatformTypeWechat
           onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error)
     {
         if (state == SSDKResponseStateSuccess)
         {
             
             NSLog(@"uid=%@",user.uid);
             NSLog(@"%@",user.credential);
             NSLog(@"token=%@",user.credential.token);
             NSLog(@"nickname=%@",user.nickname);
         }
         
         else
         {
             NSLog(@"%@",error);
         }
         
     }];
}
//QQ登录
- (IBAction)QQLogin:(UIButton *)sender {
    [ShareSDK getUserInfo:SSDKPlatformTypeQQ
           onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error)
     {
         if (state == SSDKResponseStateSuccess)
         {
             
             NSLog(@"uid=%@",user.uid);
             NSLog(@"%@",user.credential);
             NSLog(@"token=%@",user.credential.token);
             NSLog(@"nickname=%@",user.nickname);
         }
         
         else
         {
             NSLog(@"%@",error);
         }
         
     }];
}
//微博登录
- (IBAction)weiboLogin:(UIButton *)sender {
    [ShareSDK getUserInfo:SSDKPlatformTypeSinaWeibo
           onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error)
     {
         if (state == SSDKResponseStateSuccess)
         {
             
             NSLog(@"uid=%@",user.uid);
             NSLog(@"%@",user.credential);
             NSLog(@"token=%@",user.credential.token);
             NSLog(@"nickname=%@",user.nickname);
         }
         
         else
         {
             NSLog(@"%@",error);
         }
         
     }];
}

//#pragma mark - 监听键盘事件
//- (void)viewWillAppear:(BOOL)animated{
//    
////    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardWillShowNotification object:nil];
////    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHidden:) name:UIKeyboardWillHideNotification object:nil];
//    
//}
//
//- (void)viewDidDisappear:(BOOL)animated{
//    
//    [super viewDidDisappear:animated];
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
//    
//}

//- (void)keyboardWasShown:(NSNotification*)aNotification{
//    
//    NSDictionary* info = [aNotification userInfo];
//    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;

//    if (KScreenHeight - kNavigationBarHeight - _userNameTF.bottom > kbSize.height - 60) {
//            CGRect rect1 = self.view.frame;
//            rect1.origin.y = kbSize.height - KScreenHeight + kNavigationBarHeight + _userNameTF.bottom - 60;
//        self.view.frame = rect1;
//    }

    
//}

//- (void)keyboardWillBeHidden:(NSNotification*)aNotification{
//    
//    CGRect rect1 = self.view.frame;
//    rect1.origin.y = 0;
//    self.view.frame = rect1;
//    
//}

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

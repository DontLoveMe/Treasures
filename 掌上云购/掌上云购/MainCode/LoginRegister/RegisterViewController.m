//
//  RegisterViewController.m
//  掌上云购
//
//  Created by 刘毅 on 16/8/8.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import "RegisterViewController.h"
#import "CountDown.h"
#import "AlertController.h"
#import "HtmlTypeController.h"
#import "DelegateTxtController.h"

@interface RegisterViewController ()

@property (nonatomic,strong) CountDown *countDown;

@end

@implementation RegisterViewController

#pragma mark - 导航栏
- (void)initNavBar{
   
    self.navigationItem.backBarButtonItem = nil;
    UIButton *leftButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, kNavigationBarItemWidth, kNavigationBarItemHight)];
    leftButton.tag = 101;
    [leftButton setBackgroundImage:[UIImage imageNamed:@"返回.png"]
                          forState:UIControlStateNormal];
    [leftButton addTarget:self
                   action:@selector(NavAction:)
         forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftItem;
    
}

- (void)NavAction:(UIButton *)button{
    
//    self.presentingViewController.view.alpha = 0;
//    [self.presentingViewController.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorFromHexRGB:@"E6E6E6"];
    
    _countDown = [[CountDown alloc] init];

    [self initNavBar];
    //判断注册、找回密码、密码修改界面
    [self registOrmodify];
    //设置输入框
    [self setTextField];
}

- (void)setPhoneText:(NSString *)phoneText{

    if (_phoneText != phoneText) {
        
        _phoneText = phoneText;

    }

}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    if (_phoneText.length > 0) {
        _usernameTF.text = _phoneText;
    }
    
    [_validataButton setTitle:@"" forState:UIControlStateNormal];
    if (_validataLabel == nil) {
        
        _validataLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, _validataButton.width, _validataButton.height)];
    }
    [_validataButton addSubview:_validataLabel];
    _validataLabel.font = [UIFont systemFontOfSize:14];
    _validataLabel.textAlignment = NSTextAlignmentCenter;
    _validataLabel.text = @"获取验证码";
    _validataLabel.textColor = [UIColor whiteColor];
}
#pragma mark - 判断界面
//判断注册、找回密码、密码修改、绑定手机界面
- (void)registOrmodify {
    
    if (_isRegistOrmodify == 0) {
        
        _usernameTF.hidden = NO;
        _validateTF.hidden = NO;
        _validataButton.hidden = NO;
        
        [_actionButton setTitle:@"立即注册"
                       forState:UIControlStateNormal];
        
    }else if(_isRegistOrmodify == 1){
        
        _usernameTF.hidden = NO;
        _validateTF.hidden = NO;
        _validataButton.hidden = NO;
        
        _userDgtBtn.hidden = YES;
        _agreeButton.hidden = YES;
        
        [_actionButton setTitle:@"确认找回"
                       forState:UIControlStateNormal];
        
    }else if(_isRegistOrmodify == 2){
        
        _usernameTF.placeholder = @"请输入旧密码";
        _usernameTF.secureTextEntry = YES;
        _validateTF.hidden = YES;
        _validataButton.hidden = YES;
        
        _userDgtBtn.hidden = YES;
        _agreeButton.hidden = YES;
        _bottomView.hidden = NO;
    
        _vdTFHeight.constant = 0;
        _vdBtnHeight.constant = 0;
        
        [_actionButton setTitle:@"确认修改"
                       forState:UIControlStateNormal];
    }else if (_isRegistOrmodify == 3) {
        self.title = @"绑定手机";
        _usernameTF.placeholder = @"请输入手机号码";
        _passwrodTF.hidden = YES;
        _rePasswordTF.hidden = YES;
        _userDgtBtn.hidden = YES;
        _agreeButton.hidden = YES;
        _bottomView.hidden = NO;
        [_actionButton setTitle:@"绑定手机"
                       forState:UIControlStateNormal];
    }
}

#pragma mark - 设置输入框
- (void)setTextField {
    //输入框光标左移一点位置
    _usernameTF.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 8, 0)];
    _usernameTF.leftViewMode = UITextFieldViewModeAlways;
    
    _validateTF.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 8, 0)];
    _validateTF.leftViewMode = UITextFieldViewModeAlways;
    
    _passwrodTF.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 8, 0)];
    _passwrodTF.leftViewMode = UITextFieldViewModeAlways;
    
    //输入框左边切换明暗文按钮
    UIButton *plaintextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    plaintextBtn.tag = 200;
    plaintextBtn.size = CGSizeMake(40, 25);
    [plaintextBtn setImage:[UIImage imageNamed:@"明文"] forState:UIControlStateNormal];
    [plaintextBtn addTarget:self action:@selector(plaintextAction:) forControlEvents:UIControlEventTouchUpInside];
    _passwrodTF.rightView = plaintextBtn;
    _passwrodTF.rightViewMode = UITextFieldViewModeAlways;
    
    _rePasswordTF.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 8, 0)];
    _rePasswordTF.leftViewMode = UITextFieldViewModeAlways;
    
    UIButton *rePlaintextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rePlaintextBtn.tag = 201;
    rePlaintextBtn.size = CGSizeMake(40, 25);
    [rePlaintextBtn setImage:[UIImage imageNamed:@"明文"] forState:UIControlStateNormal];
    [rePlaintextBtn addTarget:self action:@selector(plaintextAction:) forControlEvents:UIControlEventTouchUpInside];
    _rePasswordTF.rightView = rePlaintextBtn;
    _rePasswordTF.rightViewMode = UITextFieldViewModeAlways;
    
    
    
}
//明暗文切换
- (void)plaintextAction:(UIButton *)button{
    if (button.tag == 200) {
        
        _passwrodTF.secureTextEntry = !_passwrodTF.secureTextEntry;
    }else {
        
        _rePasswordTF.secureTextEntry = !_rePasswordTF.secureTextEntry;
    }
}
#pragma mark - 按钮的点击
//获得验证码
- (IBAction)getCaptchaAction:(UIButton *)sender {
    if (_usernameTF.text.length == 0) {
        AlertController *alert = [[AlertController alloc] initWithTitle:@"温馨提示！" message:@"请输入手机号码！"];
        [alert addButtonTitleArray:@[@"知道了！"]];
        __weak typeof(AlertController *) weakAlert = alert;
        [alert setClickButtonBlock:^(NSInteger tag) {
            [weakAlert dismissViewControllerAnimated:YES completion:nil];
        }];
        
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    //    60s的倒计时
    NSTimeInterval aMinutes = 60;
    [self startWithStartDate:[NSDate date] finishDate:[NSDate dateWithTimeIntervalSinceNow:aMinutes]];
    //获得验证码
    [self getCaptcha];
    
}
//获得验证码
- (void)getCaptcha {
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    [params setObject:_userId
//               forKey:@"userId"];
    [params setObject:_usernameTF.text
               forKey:@"phone"];
    [params setObject:@"1"
               forKey:@"smsType"];
    NSString *url  = [NSString stringWithFormat:@"%@%@",BASE_URL,SendCode_URL];
    [ZSTools post:url
           params:params
          success:^(id json) {
              
              NSLog(@"返回信息:%@",[json objectForKey:@"msg"]);
              BOOL flag = [[json objectForKey:@"flag"] boolValue];
              if (flag == 1) {
                  

                  
              }
              
          } failure:^(NSError *error) {
              
          }];
}
//此方法用两个NSDate对象做参数进行倒计时
-(void)startWithStartDate:(NSDate *)strtDate finishDate:(NSDate *)finishDate{
    
    [_countDown countDownWithStratDate:strtDate finishDate:finishDate completeBlock:^(NSInteger day, NSInteger hour, NSInteger minute, NSInteger second) {
        
        NSInteger totoalSecond =day*24*60*60+hour*60*60 + minute*60+second;
        
        if (totoalSecond==0) {
            _validataButton.enabled = YES;
//            [_validataButton setTitle:@"重新获取验证码" forState:UIControlStateNormal];
            _validataLabel.text = @"重新获取验证码";
        }else{
            _validataButton.enabled = NO;
            _validataLabel.text = [NSString stringWithFormat:@"已发送（%lds）",(long)totoalSecond];
        }
        
    }];
}

//用户协议
- (IBAction)userDelegateAction:(UIButton *)sender {
    DelegateTxtController *dtVC = [[DelegateTxtController alloc] init];

    UINavigationController *dVC = [[UINavigationController alloc] initWithRootViewController:dtVC];
    [self presentViewController:dVC animated:YES completion:nil];
    
}
//注册
- (IBAction)registerAction:(UIButton *)sender {
    if ([_usernameTF isFirstResponder]) {
        
        [_usernameTF resignFirstResponder];
    }
    if ([_validateTF isFirstResponder]) {
        
        [_validateTF resignFirstResponder];
    }
    if ([_passwrodTF isFirstResponder]) {
        
        [_passwrodTF resignFirstResponder];
    }
    if ([_rePasswordTF isFirstResponder]) {
        
        [_rePasswordTF resignFirstResponder];
    }
    
    
    if (_isRegistOrmodify == 0) {
        
        [self regist];
        
    }else if (_isRegistOrmodify == 1){

        [self findPassword];
    
    }else if(_isRegistOrmodify == 2){
        
        [self changePassword];
    }else if (_isRegistOrmodify == 3) {
        
        [self bindPhone];
    }
    
}
#pragma mark - 注册
- (void)regist {

    if (_usernameTF.text.length == 0) {
        AlertController *alert = [[AlertController alloc] initWithTitle:@"温馨提示！" message:@"请输入手机号码！"];
        [alert addButtonTitleArray:@[@"知道了！"]];
        __weak typeof(AlertController *) weakAlert = alert;
        [alert setClickButtonBlock:^(NSInteger tag) {
            [weakAlert dismissViewControllerAnimated:YES completion:nil];
        }];
        
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    if (_validateTF.text.length == 0) {
        AlertController *alert = [[AlertController alloc] initWithTitle:@"温馨提示！" message:@"请输入验证码！"];
        [alert addButtonTitleArray:@[@"知道了！"]];
        __weak typeof(AlertController *) weakAlert = alert;
        [alert setClickButtonBlock:^(NSInteger tag) {
            [weakAlert dismissViewControllerAnimated:YES completion:nil];
        }];
        
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    if (_passwrodTF.text.length < 8 || _passwrodTF.text.length > 20) {
        AlertController *alert = [[AlertController alloc] initWithTitle:@"温馨提示！" message:@"请输入密码！(8-20位数)"];
        [alert addButtonTitleArray:@[@"知道了！"]];
        __weak typeof(AlertController *) weakAlert = alert;
        [alert setClickButtonBlock:^(NSInteger tag) {
            [weakAlert dismissViewControllerAnimated:YES completion:nil];
        }];
        
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    if (![_passwrodTF.text isEqualToString:_rePasswordTF.text]) {
        AlertController *alert = [[AlertController alloc] initWithTitle:@"温馨提示！" message:@"两次输入的密码不同！"];
        [alert addButtonTitleArray:@[@"知道了！"]];
        __weak typeof(AlertController *) weakAlert = alert;
        [alert setClickButtonBlock:^(NSInteger tag) {
            [weakAlert dismissViewControllerAnimated:YES completion:nil];
        }];
        
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:@{@"userAccount":_usernameTF.text,
                        @"userPwd":[MD5Security MD5String:_passwrodTF.text],
                        @"captcha":_validateTF.text}
               forKey:@"userLoginDto"];
    NSString *url  = [NSString stringWithFormat:@"%@%@",BASE_URL,Regist_URL];
    [self showHUD:@"正在注册"];
    [ZSTools specialPost:url
           params:params
          success:^(id json) {
              
              NSLog(@"返回信息:%@",[json objectForKey:@"msg"]);
              BOOL flag = [[json objectForKey:@"flag"] boolValue];
              if (flag == 1) {
                  //把信息存到NSUserDefaults
                  [self hideSuccessHUD:@"注册成功"];
                  NSMutableDictionary *userDic = [[json objectForKey:@"data"] mutableCopy];
                  [self saveDataForUserUserDefaults:userDic];
                  [self.presentingViewController.presentingViewController dismissViewControllerAnimated:YES completion:^{
                      
                      if ([_delegate respondsToSelector:@selector(firstGuideBack)]) {
                          [_delegate firstGuideBack];
                      }

                  }];
                  
              }else{
              
                  [self hideFailHUD:[json objectForKey:@"msg"]];
                  
              }
              
          } failure:^(NSError *error) {
              
              [self hideFailHUD:@"请求失败"];
              
          }];
}
#pragma mark - 找回密码
- (void)findPassword {
    
    if (_usernameTF.text.length == 0) {
        AlertController *alert = [[AlertController alloc] initWithTitle:@"温馨提示！" message:@"请输入手机号码！"];
        [alert addButtonTitleArray:@[@"知道了！"]];
        __weak typeof(AlertController *) weakAlert = alert;
        [alert setClickButtonBlock:^(NSInteger tag) {
            [weakAlert dismissViewControllerAnimated:YES completion:nil];
        }];
        
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    if (_validateTF.text.length == 0) {
        AlertController *alert = [[AlertController alloc] initWithTitle:@"温馨提示！" message:@"请输入验证码！"];
        [alert addButtonTitleArray:@[@"知道了！"]];
        __weak typeof(AlertController *) weakAlert = alert;
        [alert setClickButtonBlock:^(NSInteger tag) {
            [weakAlert dismissViewControllerAnimated:YES completion:nil];
        }];
        
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    if (_passwrodTF.text.length < 8||_passwrodTF.text.length > 20) {
        AlertController *alert = [[AlertController alloc] initWithTitle:@"温馨提示！" message:@"请输入密码！(8-20位数)"];
        [alert addButtonTitleArray:@[@"知道了！"]];
        __weak typeof(AlertController *) weakAlert = alert;
        [alert setClickButtonBlock:^(NSInteger tag) {
            [weakAlert dismissViewControllerAnimated:YES completion:nil];
        }];
        
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    if (![_passwrodTF.text isEqualToString:_rePasswordTF.text]) {
        AlertController *alert = [[AlertController alloc] initWithTitle:@"温馨提示！" message:@"两次输入的密码不同！"];
        [alert addButtonTitleArray:@[@"知道了！"]];
        __weak typeof(AlertController *) weakAlert = alert;
        [alert setClickButtonBlock:^(NSInteger tag) {
            [weakAlert dismissViewControllerAnimated:YES completion:nil];
        }];
        
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setObject:_usernameTF.text forKey:@"userAccount"];
    [params setObject:_validateTF.text forKey:@"captcha"];
    [params setObject:[MD5Security MD5String:_rePasswordTF.text] forKey:@"newUserPwd"];
    [self showHUD:@"正在找回"];
    NSString *url  = [NSString stringWithFormat:@"%@%@",BASE_URL,FindPWD_URL];
    [ZSTools post:url
           params:params
          success:^(id json) {
              
              NSLog(@"返回信息:%@",[json objectForKey:@"msg"]);
              BOOL flag = [[json objectForKey:@"flag"] boolValue];
              if (flag == 1) {
                  
                  [self dismissViewControllerAnimated:YES completion:nil];
                  
              }else{
                  [self hideFailHUD:[json objectForKey:@"msg"]];
              }
              
          } failure:^(NSError *error) {
              [self hideFailHUD:@"找回失败"];
          }];
}
#pragma mark - 修改密码
- (void)changePassword {
    
    if (_usernameTF.text.length == 0) {
        AlertController *alert = [[AlertController alloc] initWithTitle:@"温馨提示！" message:@"请输入手机号码！"];
        [alert addButtonTitleArray:@[@"知道了！"]];
        __weak typeof(AlertController *) weakAlert = alert;
        [alert setClickButtonBlock:^(NSInteger tag) {
            [weakAlert dismissViewControllerAnimated:YES completion:nil];
        }];
        
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    if (_passwrodTF.text.length < 8||_passwrodTF.text.length >20) {
        AlertController *alert = [[AlertController alloc] initWithTitle:@"温馨提示！" message:@"请输入密码！(8-20位数)"];
        [alert addButtonTitleArray:@[@"知道了！"]];
        __weak typeof(AlertController *) weakAlert = alert;
        [alert setClickButtonBlock:^(NSInteger tag) {
            [weakAlert dismissViewControllerAnimated:YES completion:nil];
        }];
        
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    if (![_passwrodTF.text isEqualToString:_rePasswordTF.text]) {
        AlertController *alert = [[AlertController alloc] initWithTitle:@"温馨提示！" message:@"两次输入的密码不同！"];
        [alert addButtonTitleArray:@[@"知道了！"]];
        __weak typeof(AlertController *) weakAlert = alert;
        [alert setClickButtonBlock:^(NSInteger tag) {
            [weakAlert dismissViewControllerAnimated:YES completion:nil];
        }];
        
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    NSDictionary *userDic = [[NSUserDefaults standardUserDefaults] objectForKey:@"userDic"];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSDictionary *userLoginDic =userDic[@"userLoginDto"];
    [params setObject:userLoginDic[@"userAccount"] forKey:@"userAccount"];
    [params setObject:[MD5Security MD5String:_usernameTF.text] forKey:@"userPwd"];
    [params setObject:[MD5Security MD5String:_rePasswordTF.text] forKey:@"newUserPwd"];
    NSString *url  = [NSString stringWithFormat:@"%@%@",BASE_URL,UpdatePWD_URL];
    [self showHUD:@"修改中"];
    [ZSTools post:url
           params:params
          success:^(id json) {
              
//              NSLog(@"返回信息:%@",[json objectForKey:@"msg"]);
              [self hideSuccessHUD:[json objectForKey:@"msg"]];
              BOOL flag = [[json objectForKey:@"flag"] boolValue];
              if (flag == 1) {
                  
                  AlertController *alert = [[AlertController alloc] initWithTitle:@"温馨提示！" message:@"修改密码成功！"];
                  [alert addButtonTitleArray:@[@"知道了！"]];
                  __weak typeof(AlertController *) weakAlert = alert;
                  [alert setClickButtonBlock:^(NSInteger tag) {
                      [weakAlert dismissViewControllerAnimated:YES completion:nil];
                      
                      [self dismissViewControllerAnimated:YES completion:nil];
                  }];
                  
                  [self presentViewController:alert animated:YES completion:nil];
                  return;
                  
              }else{
              
                  AlertController *alert = [[AlertController alloc] initWithTitle:@"温馨提示！" message:@"修改密码失败！"];
                  [alert addButtonTitleArray:@[@"知道了！"]];
                  __weak typeof(AlertController *) weakAlert = alert;
                  [alert setClickButtonBlock:^(NSInteger tag) {
                      [weakAlert dismissViewControllerAnimated:YES completion:nil];

                  }];
                  
                  [self presentViewController:alert animated:YES completion:nil];
                  return;
                  
              }
              
          } failure:^(NSError *error) {
              
              AlertController *alert = [[AlertController alloc] initWithTitle:@"温馨提示！" message:@"修改密码失败！"];
              [alert addButtonTitleArray:@[@"知道了！"]];
              __weak typeof(AlertController *) weakAlert = alert;
              [alert setClickButtonBlock:^(NSInteger tag) {
                  [weakAlert dismissViewControllerAnimated:YES completion:nil];
                  
              }];
              
              [self presentViewController:alert animated:YES completion:nil];
              return;
              
          }];
}
#pragma mark - 绑定手机
- (void)bindPhone {
    
    if (_usernameTF.text.length == 0) {
        AlertController *alert = [[AlertController alloc] initWithTitle:@"温馨提示！" message:@"请输入手机号码！"];
        [alert addButtonTitleArray:@[@"知道了！"]];
        __weak typeof(AlertController *) weakAlert = alert;
        [alert setClickButtonBlock:^(NSInteger tag) {
            [weakAlert dismissViewControllerAnimated:YES completion:nil];
        }];
        
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    if (_validateTF.text.length == 0) {
        AlertController *alert = [[AlertController alloc] initWithTitle:@"温馨提示！" message:@"请输入验证码！"];
        [alert addButtonTitleArray:@[@"知道了！"]];
        __weak typeof(AlertController *) weakAlert = alert;
        [alert setClickButtonBlock:^(NSInteger tag) {
            [weakAlert dismissViewControllerAnimated:YES completion:nil];
        }];
        
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
 
//    NSMutableDictionary *params = [_userParams mutableCopy];
    NSDictionary *dic = [[NSUserDefaults standardUserDefaults] objectForKey:@"userDic"];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:dic[@"id"] forKey:@"id"];
    [params setObject:_validateTF.text forKey:@"captcha"];
    [params setObject:_usernameTF.text forKey:@"Mobile"];

    [self showHUD:@"绑定中"];
    NSString *url  = [NSString stringWithFormat:@"%@%@",BASE_URL,ThirdLoginPhone_URL];
    [ZSTools specialPost:url
           params:params
          success:^(id json) {
              
              NSLog(@"返回信息:%@",[json objectForKey:@"msg"]);
              BOOL flag = [[json objectForKey:@"flag"] boolValue];
              if (flag == 1) {
                  [self hideSuccessHUD:[json objectForKey:@"msg"]];
                  //把信息存到NSUserDefaults
                  NSMutableDictionary *userDic = [[json objectForKey:@"data"] mutableCopy];
                  [self saveDataForUserUserDefaults:userDic];
//                 [self.presentingViewController.presentingViewController dismissViewControllerAnimated:YES completion:nil];
                  [self dismissViewControllerAnimated:YES completion:^{
                      
                  }];
                  
              }else{
                  [self hideFailHUD:[json objectForKey:@"msg"]];
              }
              
          } failure:^(NSError *error) {
              [self hideFailHUD:@"绑定失败"];
          }];
}
#pragma mark - 下方按钮的点击
//关于
- (IBAction)aboutUsAction:(UIButton *)sender {
    HtmlTypeController *htmlType = [[HtmlTypeController alloc] init];
    htmlType.htmlUrl = @"/pcpServer-inf/html/about.html";
    htmlType.title = @"关于";
    UINavigationController *htVC = [[UINavigationController alloc] initWithRootViewController:htmlType];
    [self presentViewController:htVC animated:YES completion:nil];
}
//保障说明
- (IBAction)explainAction:(UIButton *)sender {
    HtmlTypeController *htmlType = [[HtmlTypeController alloc] init];
    htmlType.htmlUrl = @"/pcpServer-inf/html/consumer_protection.html";
    htmlType.title = @"保障说明";
    UINavigationController *htVC = [[UINavigationController alloc] initWithRootViewController:htmlType];
    [self presentViewController:htVC animated:YES completion:nil];
}
//隐私协议
- (IBAction)privacyPolicAction:(UIButton *)sender {
    HtmlTypeController *htmlType = [[HtmlTypeController alloc] init];
    htmlType.htmlUrl = @"/pcpServer-inf/html/agreement.html";
    htmlType.title = @"隐私协议";
    UINavigationController *htVC = [[UINavigationController alloc] initWithRootViewController:htmlType];
    [self presentViewController:htVC animated:YES completion:nil];
}
#pragma mark - 保存信息
- (void)saveDataForUserUserDefaults:(NSMutableDictionary *)userDic {
    
        for (int i = 0; i < userDic.allKeys.count; i ++) {
            
            id ss=userDic[userDic.allKeys[i]];
            if ([ss isEqual:[NSNull null]]) {
                [userDic removeObjectForKey:userDic.allKeys[i]];
                i = 0;
            }
            
            if ([[userDic objectForKey:userDic.allKeys[i]] isEqual:[NSNull null]]||[[userDic objectForKey:userDic.allKeys[i]] isKindOfClass:[NSNull class]] || [userDic objectForKey:userDic.allKeys[i]] == nil) {
                
                [userDic removeObjectForKey:userDic.allKeys[i]];
                i = 0;
            }
            if ([userDic.allKeys[i] isEqualToString:@"userLoginDto"]) {
                NSMutableDictionary *userLoginDic = [userDic[@"userLoginDto"] mutableCopy];
                for (int j = 0; j< userLoginDic.allKeys.count; j ++) {
                    if ([[userLoginDic objectForKey:userLoginDic.allKeys[j]] isEqual:[NSNull null]]||[[userLoginDic objectForKey:userLoginDic.allKeys[j]] isKindOfClass:[NSNull class]]) {
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

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if ([_usernameTF isFirstResponder]) {
        
        [_usernameTF resignFirstResponder];
    }
    if ([_validateTF isFirstResponder]) {
        
        [_validateTF resignFirstResponder];
    }
    if ([_passwrodTF isFirstResponder]) {
        
        [_passwrodTF resignFirstResponder];
    }
    if ([_rePasswordTF isFirstResponder]) {
        
        [_rePasswordTF resignFirstResponder];
    }
}
-(void)dealloc{
    
    [_countDown destoryTimer];
    
}

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];

}

@end

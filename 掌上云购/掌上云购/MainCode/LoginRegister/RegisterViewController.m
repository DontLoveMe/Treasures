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

@interface RegisterViewController ()

@property (nonatomic,strong) CountDown *countDown;

@end

@implementation RegisterViewController

#pragma mark - 导航栏
- (void)initNavBar{
   
    self.navigationItem.backBarButtonItem = nil;
    UIButton *leftButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 20.f, 25.f)];
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
//判断注册、找回密码、密码修改界面
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
        
    }else {
        
        _usernameTF.placeholder = @"请输入旧密码";
        _validateTF.hidden = YES;
        _validataButton.hidden = YES;
        
        _userDgtBtn.hidden = YES;
        _agreeButton.hidden = YES;
        _bottomView.hidden = NO;
    
        _vdTFHeight.constant = 0;
        _vdBtnHeight.constant = 0;
        [_actionButton setTitle:@"密码修改"
                       forState:UIControlStateNormal];
    }
}


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

//获得验证码
- (IBAction)getCaptchaAction:(UIButton *)sender {
    
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
                  
                  _validateTF.text = json[@"data"];
                  
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
            [_validataButton setTitle:@"重新获取验证码" forState:UIControlStateNormal];
        }else{
            _validataButton.enabled = NO;
            [_validataButton setTitle:[NSString stringWithFormat:@"已发送（%lds）",(long)totoalSecond] forState:UIControlStateNormal];
        }
        
    }];
}

//用户协议
- (IBAction)userDelegateAction:(UIButton *)sender {
    
    
}
//注册
- (IBAction)registerAction:(UIButton *)sender {
    
    
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
    
    if (_isRegistOrmodify == 0) {
        
        [self regist];
        
    }else if (_isRegistOrmodify == 1){

        [self findPassword];
    
    }else {
        
        [self changePassword];
    }
    
}

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
    if (_passwrodTF.text.length == 0) {
        AlertController *alert = [[AlertController alloc] initWithTitle:@"温馨提示！" message:@"请输入密码！"];
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
    [ZSTools post:url
           params:params
          success:^(id json) {
              
              NSLog(@"返回信息:%@",[json objectForKey:@"msg"]);
              BOOL flag = [[json objectForKey:@"flag"] boolValue];
              if (flag == 1) {
                  
                  [self dismissViewControllerAnimated:YES completion:nil];
                  
              }
              
          } failure:^(NSError *error) {
              
          }];
}
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
    if (_passwrodTF.text.length == 0) {
        AlertController *alert = [[AlertController alloc] initWithTitle:@"温馨提示！" message:@"请输入密码！"];
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
    NSString *url  = [NSString stringWithFormat:@"%@%@",BASE_URL,FindPWD_URL];
    [ZSTools post:url
           params:params
          success:^(id json) {
              
              NSLog(@"返回信息:%@",[json objectForKey:@"msg"]);
              BOOL flag = [[json objectForKey:@"flag"] boolValue];
              if (flag == 1) {
                  
                  [self dismissViewControllerAnimated:YES completion:nil];
                  
              }
              
          } failure:^(NSError *error) {
              
          }];
}

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
    if (_passwrodTF.text.length == 0) {
        AlertController *alert = [[AlertController alloc] initWithTitle:@"温馨提示！" message:@"请输入密码！"];
        [alert addButtonTitleArray:@[@"知道了！"]];
        __weak typeof(AlertController *) weakAlert = alert;
        [alert setClickButtonBlock:^(NSInteger tag) {
            [weakAlert dismissViewControllerAnimated:YES completion:nil];
        }];
        
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
   
    
    NSDictionary *dic = [[NSUserDefaults standardUserDefaults] objectForKey:@"userDic"];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setObject:dic[@"id"] forKey:@"id"];
    [params setObject:[MD5Security MD5String:_usernameTF.text] forKey:@"userPwd"];
    [params setObject:[MD5Security MD5String:_rePasswordTF.text] forKey:@"newUserPwd"];
    NSString *url  = [NSString stringWithFormat:@"%@%@",BASE_URL,UpdatePWD_URL];
    [ZSTools post:url
           params:params
          success:^(id json) {
              
              NSLog(@"返回信息:%@",[json objectForKey:@"msg"]);
              BOOL flag = [[json objectForKey:@"flag"] boolValue];
              if (flag == 1) {
                  
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
-(void)dealloc{
    
    [_countDown destoryTimer];
    
}

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    
    

}

@end

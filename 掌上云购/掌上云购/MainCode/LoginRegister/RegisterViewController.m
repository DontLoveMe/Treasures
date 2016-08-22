//
//  RegisterViewController.m
//  掌上云购
//
//  Created by 刘毅 on 16/8/8.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import "RegisterViewController.h"
#import "CountDown.h"

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
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorFromHexRGB:@"1685FE"];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:20]};
    _countDown = [[CountDown alloc] init];
    
    [self initNavBar];
    
}
//获得验证码
- (IBAction)getCaptchaAction:(UIButton *)sender {
    
    //    60s的倒计时
    NSTimeInterval aMinutes = 60;
    [self startWithStartDate:[NSDate date] finishDate:[NSDate dateWithTimeIntervalSinceNow:aMinutes] timeButton:sender];
    
}
//此方法用两个NSDate对象做参数进行倒计时
-(void)startWithStartDate:(NSDate *)strtDate finishDate:(NSDate *)finishDate timeButton:(UIButton *)timeButton{
    
    [_countDown countDownWithStratDate:strtDate finishDate:finishDate completeBlock:^(NSInteger day, NSInteger hour, NSInteger minute, NSInteger second) {
        
        NSInteger totoalSecond =day*24*60*60+hour*60*60 + minute*60+second;
        
        if (totoalSecond==0) {
            timeButton.enabled = YES;
            [timeButton setTitle:@"重新获取验证码" forState:UIControlStateNormal];
        }else{
            timeButton.enabled = NO;
            [timeButton setTitle:[NSString stringWithFormat:@"%lds后重新获取",(long)totoalSecond] forState:UIControlStateNormal];
        }
        
    }];
}

//用户协议
- (IBAction)userDelegateAction:(UIButton *)sender {
}
//注册
- (IBAction)registerAction:(UIButton *)sender {
    
    if (_isRegistOrmodify == 0) {
        
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setObject:@{@"userAccount":_usernameTF.text,
                            @"userPwd":[MD5Security MD5String:_passwrodTF.text]}
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
        
    }else{

        NSMutableDictionary *params = [NSMutableDictionary dictionary];
//        [params setObject:@{@"userAccount":_usernameTF.text,
//                            @"userPwd":[MD5Security MD5String:_passwrodTF.text]}
//                   forKey:@"userLoginDto"];
        [params setObject:_usernameTF.text forKey:@"id"];
        [params setObject:[MD5Security MD5String:_passwrodTF.text] forKey:@"userPwd"];
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
    
    if (_isRegistOrmodify == 1) {
        
        _validateTF.hidden = YES;
        _validataButton.hidden = YES;
        [_actionButton setTitle:@"确认找回"
                       forState:UIControlStateNormal];
        
    }else{
    
        _validateTF.hidden = NO;
        _validataButton.hidden = NO;
//        _rePasswordTF.hidden = NO;
        [_actionButton setTitle:@"立即注册"
                       forState:UIControlStateNormal];
    
    }

}

@end

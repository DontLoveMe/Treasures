//
//  ChangeDataController.m
//  掌上云购
//
//  Created by 刘毅 on 16/8/17.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import "ChangeDataController.h"
#import "CountDown.h"
#import "AlertController.h"

@interface ChangeDataController ()

@property (nonatomic,strong)UITextField *nameTF;

@property (nonatomic,strong)UITextField *oldPhoneTF;
@property (nonatomic,strong)UITextField *phoneTF;
@property (nonatomic,strong)UITextField *verifyTF;

@property (nonatomic,strong)UITextField *emailTF;
@property (nonatomic,strong)UITextField *reEmailTF;

@property (nonatomic,strong) CountDown *countDown;

@end

@implementation ChangeDataController
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
    
    
    UIButton *rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40.f, 25.f)];
//    [rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [rightButton setTitle:@"确定" forState:UIControlStateNormal];
//    [rightButton setBackgroundImage:[UIImage imageNamed:@"按钮框"]
//                          forState:UIControlStateNormal];
    [rightButton addTarget:self
                   action:@selector(sureAction:)
         forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightItem;
    
}
- (void)NavAction:(UIButton *)button{
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initNavBar];
    
    
    switch (_type) {
        case 1:
            self.title = @"修改昵称";
            [self changeName];
            break;
        case 2:
            self.title = @"修改手机号码";
            [self changePhone];
            break;
        case 3:
            self.title = @"绑定邮箱";
            [self bindEmail];
            break;
            
        default:
            break;
    }
    
}
//修改昵称
- (void)changeName {
    
    NSDictionary *userDic = [[NSUserDefaults standardUserDefaults] objectForKey:@"userDic"];
    
    _nameTF = [[UITextField alloc] initWithFrame:CGRectMake(5, 10, KScreenWidth-10, 35)];
    _nameTF.text = userDic[@"nickName"];
    _nameTF.clearButtonMode = UITextFieldViewModeAlways;
    _nameTF.borderStyle = UITextBorderStyleRoundedRect;
    _nameTF.font = [UIFont systemFontOfSize:14];
    _nameTF.textColor = [UIColor blackColor];
   [self.view addSubview:_nameTF];
    
//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 50, KScreenWidth, 20)];
////    label.backgroundColor = [UIColor grayColor];
//    label.textAlignment = NSTextAlignmentCenter;
//    label.text = @"由6-20个字符、可由中文、数字、\"_\"、\"-\"组成";
//    label.textColor = [UIColor blackColor];
//    label.font = [UIFont systemFontOfSize:12];
//    [self.view addSubview:label];
}

//修改手机号码
- (void)changePhone {
    
     NSDictionary *userDic = [[NSUserDefaults standardUserDefaults] objectForKey:@"userDic"];
    
    _oldPhoneTF = [[UITextField alloc] initWithFrame:CGRectMake(5, 10, KScreenWidth-10, 35)];
    _oldPhoneTF.clearButtonMode = UITextFieldViewModeAlways;
    _oldPhoneTF.keyboardType = UIKeyboardTypeNumberPad;
    _oldPhoneTF.borderStyle = UITextBorderStyleRoundedRect;
    _oldPhoneTF.font = [UIFont systemFontOfSize:14];
    _oldPhoneTF.textColor = [UIColor blackColor];
    if (![userDic[@"mobile"] isKindOfClass:[NSNull class]]) {
        
        _oldPhoneTF.text = userDic[@"mobile"];
    }
    _oldPhoneTF.placeholder = @"请输入旧手机号码";
    [self.view addSubview:_oldPhoneTF];
    _phoneTF = [[UITextField alloc] initWithFrame:CGRectMake(5, 53, KScreenWidth-10, 35)];
    _phoneTF.keyboardType = UIKeyboardTypeNumberPad;
    _phoneTF.clearButtonMode = UITextFieldViewModeAlways;
    _phoneTF.borderStyle = UITextBorderStyleRoundedRect;
    _phoneTF.font = [UIFont systemFontOfSize:14];
    _phoneTF.textColor = [UIColor blackColor];
    _phoneTF.placeholder = @"请输入新手机号码";
    [self.view addSubview:_phoneTF];
    
    _verifyTF = [[UITextField alloc] initWithFrame:CGRectMake(5, 93, KScreenWidth/2, 35)];
    _verifyTF.keyboardType = UIKeyboardTypeNumberPad;
    _verifyTF.borderStyle = UITextBorderStyleRoundedRect;
    _verifyTF.font = [UIFont systemFontOfSize:14];
    _verifyTF.textColor = [UIColor blackColor];
    _verifyTF.placeholder = @"请输入验证码";
    [self.view addSubview:_verifyTF];
    
    UIButton *verifyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    verifyButton.frame = CGRectMake(KScreenWidth/2+5, 93, KScreenWidth/2-10, 35);
    [verifyButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [verifyButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    [verifyButton setBackgroundImage:[UIImage imageNamed:@"按钮背景"] forState:UIControlStateNormal];
    [verifyButton addTarget:self action:@selector(verifyAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:verifyButton];
    
    
    _countDown = [[CountDown alloc] init];
}
//绑定邮箱
- (void)bindEmail {
    
    _emailTF = [[UITextField alloc] initWithFrame:CGRectMake(5, 10, KScreenWidth-10, 35)];
    _emailTF.clearButtonMode = UITextFieldViewModeAlways;
    _emailTF.borderStyle = UITextBorderStyleRoundedRect;
    _emailTF.font = [UIFont systemFontOfSize:14];
    _emailTF.textColor = [UIColor blackColor];
    _emailTF.placeholder = @"请输入邮箱";
    [self.view addSubview:_emailTF];
    
    _reEmailTF = [[UITextField alloc] initWithFrame:CGRectMake(5, 53, KScreenWidth-10, 35)];
    _reEmailTF.clearButtonMode = UITextFieldViewModeAlways;
    _reEmailTF.borderStyle = UITextBorderStyleRoundedRect;
    _reEmailTF.font = [UIFont systemFontOfSize:14];
    _reEmailTF.textColor = [UIColor blackColor];
    _reEmailTF.placeholder = @"再次确认邮箱";
    [self.view addSubview:_reEmailTF];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 90, KScreenWidth, 20)];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"邮箱绑定后不可修改";
    label.textColor = [UIColor blackColor];
    label.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:label];
}


#pragma mark - 按钮点击
//验证
- (void)verifyAction:(UIButton *)button {
    if (_phoneTF.text.length==0) {
        AlertController *alert = [[AlertController alloc] initWithTitle:@"温馨提示" message:@"请填写手机号码！"];
        [alert addButtonTitleArray:@[@"好的"]];
        
        __weak typeof(AlertController *) weakAlert = alert;
        [alert setClickButtonBlock:^(NSInteger tag) {
            if (tag == 0) {
                [weakAlert dismissViewControllerAnimated:YES completion:nil];
            }
        }];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    //    60s的倒计时
    NSTimeInterval aMinutes = 60;
    [self startWithStartDate:[NSDate date] finishDate:[NSDate dateWithTimeIntervalSinceNow:aMinutes] timeButton:button];
    
    NSDictionary *userDic = [[NSUserDefaults standardUserDefaults] objectForKey:@"userDic"];
    NSNumber *userId = userDic[@"id"];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setObject:userId
                   forKey:@"userId"];
    [params setObject:_phoneTF.text
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
-(void)startWithStartDate:(NSDate *)strtDate finishDate:(NSDate *)finishDate timeButton:(UIButton *)timeButton{
    
    [_countDown countDownWithStratDate:strtDate finishDate:finishDate completeBlock:^(NSInteger day, NSInteger hour, NSInteger minute, NSInteger second) {
        
        NSInteger totoalSecond =day*24*60*60+hour*60*60 + minute*60+second;
        
        if (totoalSecond==0) {
            timeButton.enabled = YES;
            [timeButton setTitle:@"重新获取验证码" forState:UIControlStateNormal];
        }else{
            timeButton.enabled = NO;
            [timeButton setTitle:[NSString stringWithFormat:@"已发送（%lds）",(long)totoalSecond] forState:UIControlStateNormal];
        }
        
    }];
}
//确定
- (void)sureAction:(UIButton *)button {
    switch (_type) {
        case 1:
            [self getChangeName];
            break;
        case 2:
            [self getChangePhone];
            break;
        case 3:
            [self getBindEmail];
            break;
            
        default:
            break;
    }

}
- (void)getChangeName {
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    if (_nameTF.text.length>0) {
        [params setObject:_nameTF.text forKey:@"nickName"];
    }else{
        
        AlertController *alert = [[AlertController alloc] initWithTitle:@"温馨提示" message:@"请完善信息！"];
        [alert addButtonTitleArray:@[@"好的"]];
        
        __weak typeof(AlertController *) weakAlert = alert;
        [alert setClickButtonBlock:^(NSInteger tag) {
            if (tag == 0) {
                [weakAlert dismissViewControllerAnimated:YES completion:nil];
            }
        }];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    
    NSDictionary *userDic = [[NSUserDefaults standardUserDefaults] objectForKey:@"userDic"];
    NSNumber *userId = userDic[@"id"];
    [params setObject:userId forKey:@"id"];
    
    [self showHUD:@"修改中"];
    NSString *url = [NSString stringWithFormat:@"%@%@",BASE_URL,EditUserInfo_URL];
    [ZSTools post:url
           params:params
          success:^(id json) {
              
              BOOL isSuccess = [[json objectForKey:@"flag"] boolValue];
              [self hideSuccessHUD:@"绑定成功"];
              if (isSuccess) {
                  
                  [self.navigationController popViewControllerAnimated:YES];
              }
              
              
          } failure:^(NSError *error) {
              
              [self hideFailHUD:@"加载失败"];
              NSLogZS(@"%@",error);
          }];
}


- (void)getChangePhone {
//    NSLogZS(@"手机%@验证码%@",_phoneTF.text,_verifyTF.text);
    
    NSDictionary *userDic = [[NSUserDefaults standardUserDefaults] objectForKey:@"userDic"];
    NSNumber *userId = userDic[@"id"];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:userId forKey:@"id"];
    if (_verifyTF.text.length>0) {
        
        [params setObject:_verifyTF.text forKey:@"captcha"];
    }else{
        AlertController *alert = [[AlertController alloc] initWithTitle:@"温馨提示" message:@"请完善信息！"];
        [alert addButtonTitleArray:@[@"好的"]];
        
        __weak typeof(AlertController *) weakAlert = alert;
        [alert setClickButtonBlock:^(NSInteger tag) {
            if (tag == 0) {
                [weakAlert dismissViewControllerAnimated:YES completion:nil];
            }
        }];
        [self presentViewController:alert animated:YES completion:nil];
        return;
       
    }
    if (_oldPhoneTF.text.length>0) {
        [params setObject:_oldPhoneTF.text forKey:@"mobile"];
    }else{
        return;
    }
    if (_phoneTF.text.length>0) {
        [params setObject:_phoneTF.text forKey:@"newMobile"];
    }else{
        return;
    }
    [self showHUD:@"加载中"];
//    NSString *url = [NSString stringWithFormat:@"%@%@",BASE_URL,EditUserMobile_URL];
    NSString *url = @"http://192.168.0.92:8080/pcpi/user/editUserMobile";
    [ZSTools post:url
           params:params
          success:^(id json) {
              
              BOOL isSuccess = [[json objectForKey:@"flag"] boolValue];
              [self hideSuccessHUD:[json objectForKey:@"msg"]];
              if (isSuccess) {
                  
                  [self.navigationController popViewControllerAnimated:YES];
                  
              }
              
          } failure:^(NSError *error) {
              
              [self hideFailHUD:@"加载失败"];
              NSLogZS(@"%@",error);
          }];
}
- (void)getBindEmail {
    
     NSLogZS(@"邮箱%@确认邮箱%@",_emailTF.text,_reEmailTF.text);
    
    if (![_emailTF.text isEqualToString:_reEmailTF.text]) {
        AlertController *alert = [[AlertController alloc] initWithTitle:@"温馨提示" message:@"两次输入邮箱不同！请重新输入"];
        [alert addButtonTitleArray:@[@"好的"]];
        
        __weak typeof(AlertController *) weakAlert = alert;
        [alert setClickButtonBlock:^(NSInteger tag) {
            if (tag == 0) {
                [weakAlert dismissViewControllerAnimated:YES completion:nil];
            }
        }];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    
    NSDictionary *userDic = [[NSUserDefaults standardUserDefaults] objectForKey:@"userDic"];
    NSNumber *userId = userDic[@"id"];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:userId forKey:@"id"];
    
    if (_emailTF.text.length>0) {
        
        [params setObject:_emailTF.text forKey:@"email"];
    }else{
        AlertController *alert = [[AlertController alloc] initWithTitle:@"温馨提示" message:@"请完善信息！"];
        [alert addButtonTitleArray:@[@"好的"]];
        
        __weak typeof(AlertController *) weakAlert = alert;
        [alert setClickButtonBlock:^(NSInteger tag) {
            if (tag == 0) {
                [weakAlert dismissViewControllerAnimated:YES completion:nil];
            }
        }];
        [self presentViewController:alert animated:YES completion:nil];
        return;
        
    }
   
    [self showHUD:@"加载中"];
    NSString *url = [NSString stringWithFormat:@"%@%@",BASE_URL,BindingEmail_URL];
    [ZSTools post:url
           params:params
          success:^(id json) {
              
              BOOL isSuccess = [[json objectForKey:@"flag"] boolValue];
              [self hideSuccessHUD:@"绑定成功"];
              if (isSuccess) {
                  
                  [self.navigationController popViewControllerAnimated:YES];
              }
              
              
          } failure:^(NSError *error) {
              
              [self hideFailHUD:@"加载失败"];
              NSLogZS(@"%@",error);
          }];
}
@end

//
//  ChangeDataController.m
//  掌上云购
//
//  Created by 刘毅 on 16/8/17.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import "ChangeDataController.h"
#import "CountDown.h"

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
    UIButton *leftButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 20.f, 25.f)];
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
    _nameTF.placeholder = userDic[@"nickName"];
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
    _oldPhoneTF = [[UITextField alloc] initWithFrame:CGRectMake(5, 10, KScreenWidth-10, 35)];
    _oldPhoneTF.clearButtonMode = UITextFieldViewModeAlways;
    _oldPhoneTF.borderStyle = UITextBorderStyleRoundedRect;
    _oldPhoneTF.font = [UIFont systemFontOfSize:14];
    _oldPhoneTF.textColor = [UIColor blackColor];
    _oldPhoneTF.placeholder = @"请输入旧手机号码";
    [self.view addSubview:_oldPhoneTF];
    _phoneTF = [[UITextField alloc] initWithFrame:CGRectMake(5, 53, KScreenWidth-10, 35)];
    _phoneTF.clearButtonMode = UITextFieldViewModeAlways;
    _phoneTF.borderStyle = UITextBorderStyleRoundedRect;
    _phoneTF.font = [UIFont systemFontOfSize:14];
    _phoneTF.textColor = [UIColor blackColor];
    _phoneTF.placeholder = @"请输入新手机号码";
    [self.view addSubview:_phoneTF];
    
    _verifyTF = [[UITextField alloc] initWithFrame:CGRectMake(5, 93, KScreenWidth/2, 35)];
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
    //    60s的倒计时
    NSTimeInterval aMinutes = 60;
    [self startWithStartDate:[NSDate date] finishDate:[NSDate dateWithTimeIntervalSinceNow:aMinutes] timeButton:button];
    if (_phoneTF.text.length==0) {
        return;
    }
    
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
            [timeButton setTitle:[NSString stringWithFormat:@"%lds后重新获取",(long)totoalSecond] forState:UIControlStateNormal];
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
    
    NSDictionary *userDic = [[NSUserDefaults standardUserDefaults] objectForKey:@"userDic"];
    NSNumber *userId = userDic[@"id"];
    [self showHUD:@"加载中"];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:userId forKey:@"id"];
    
    if (_nameTF.text>0) {
        [params setObject:_nameTF.text forKey:@"nickName"];
    }else{
        return;
    }
    
    NSString *url = [NSString stringWithFormat:@"%@%@",BASE_URL,EditUserInfo_URL];
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
- (void)getChangePhone {
//    NSLogZS(@"手机%@验证码%@",_phoneTF.text,_verifyTF.text);
    NSDictionary *userDic = [[NSUserDefaults standardUserDefaults] objectForKey:@"userDic"];
    NSNumber *userId = userDic[@"id"];
    [self showHUD:@"加载中"];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:userId forKey:@"id"];
    if (_verifyTF.text>0) {
        
        [params setObject:_verifyTF.text forKey:@"captcha"];
    }else{
        return;
    }
    if (_phoneTF.text>0) {
        [params setObject:_phoneTF.text forKey:@"mobile"];
    }else{
        return;
    }
    
    NSString *url = [NSString stringWithFormat:@"%@%@",BASE_URL,EditUserInfo_URL];
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
        
    }
    
    NSDictionary *userDic = [[NSUserDefaults standardUserDefaults] objectForKey:@"userDic"];
    NSNumber *userId = userDic[@"id"];
    [self showHUD:@"加载中"];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:userId forKey:@"id"];
    
    if (_emailTF.text>0) {
        
        [params setObject:_emailTF.text forKey:@"email"];
    }else{
        return;
    }
   
    
    NSString *url = [NSString stringWithFormat:@"%@%@",BASE_URL,BindingEmail_URL];
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
@end

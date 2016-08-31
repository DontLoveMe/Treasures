//
//  AddAddressController.m
//  掌上云购
//
//  Created by 刘毅 on 16/8/17.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import "AddAddressController.h"
#import "AlertController.h"

@interface AddAddressController ()

@end

@implementation AddAddressController
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
    [_nameTF resignFirstResponder];
    [_addressTF resignFirstResponder];
    [_phoneTF resignFirstResponder];
    [_detailAddressTV resignFirstResponder];
    
    if (_model) {
        if (![self.nameTF.text isEqualToString:_model.receiver]
            ||![self.phoneTF.text isEqualToString:[_model.mobile stringValue]]
            ||[_provinceId integerValue] != [_model.province[@"id"] integerValue]
            ||[_cityId integerValue] != [_model.city[@"id"] integerValue]
            ||[_areaId integerValue] != [_model.area[@"id"] integerValue]
            ||![self.detailAddressTV.text isEqualToString:_model.addressDetailFull]
            ||[self.isDefaul boolValue] != [_model.isDefault boolValue]) {
            
            
            
            AlertController *alert = [[AlertController alloc] initWithTitle:@"修改了信息没有保存，确认现在返回吗？" message:@""];
            [alert addButtonTitleArray:@[@"取消",@"确认"]];
            __weak typeof(AlertController*) weakAlert = alert;
            [alert setClickButtonBlock:^(NSInteger tag) {
                if (tag == 0) {
                    [weakAlert dismissViewControllerAnimated:YES completion:nil];
                }else {
                    [weakAlert dismissViewControllerAnimated:YES completion:nil];
                    [self.navigationController popViewControllerAnimated:YES];
                }
            }];
            
            [self presentViewController:alert
                               animated:YES
                             completion:nil];
            
        }else{
            [self.navigationController popViewControllerAnimated:YES];
        }
    }else {
        
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorFromHexRGB:@"E6E6E6"];
//    self.title = @"添加地址";
    [self initNavBar];
    
    _addressTF.delegate = self;
    _detailAddressTV.delegate = self;
    
    if (_model) {
        self.nameTF.text = _model.receiver;
        self.phoneTF.text = [_model.mobile stringValue];
        if ([_model.city[@"name"]isEqualToString:_model.area[@"name"]]) {
            
            self.addressTF.text = [NSString stringWithFormat:@"%@%@",_model.province[@"name"],_model.city[@"name"]];
        }else {
            
            self.addressTF.text = [NSString stringWithFormat:@"%@%@%@",_model.province[@"name"],_model.city[@"name"],_model.area[@"name"]];
        }
        self.provinceId = _model.province[@"id"];
        self.cityId = _model.city[@"id"];
        self.areaId = _model.area[@"id"];
        self.detailAddressTV.text = _model.addressDetailFull;
        self.defaultBtn.selected = [_model.isDefault boolValue];
        self.isDefaul = _model.isDefault;
        [self.addButton setTitle:@"确认修改" forState:UIControlStateNormal];
    }
    
}
#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    [_nameTF resignFirstResponder];
    [_phoneTF resignFirstResponder];
    [_detailAddressTV resignFirstResponder];
    
    AreaPickerView *apView = [[AreaPickerView alloc] initWithFrame:CGRectMake(0, -64, KScreenWidth, KScreenHeight-64)];
    apView.delegate = self;
    [self.view addSubview:apView];
    
    return NO;
}
#pragma mark - AreaPickerViewDelegate
- (void)areaPickerViewSelectProvince:(NSDictionary *)province city:(NSDictionary *)city area:(NSDictionary *)area {
    if (area == nil) {
        _addressTF.text = [NSString stringWithFormat:@"%@%@",province[@"name"],city[@"name"]];
        NSLog(@"省%@市%@",province[@"id"],city[@"id"]);
        _provinceId = province[@"id"];
        _cityId = city[@"id"];
        _areaId = city[@"id"];
    }else {
        _addressTF.text = [NSString stringWithFormat:@"%@%@%@",province[@"name"],city[@"name"],area[@"name"]];
        NSLog(@"省%@市%@区%@",province[@"id"],city[@"id"],area[@"id"]);
        _provinceId = province[@"id"];
        _cityId = city[@"id"];
        _areaId = area[@"id"];
    }
}
#pragma mark - UITextViewDelegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]){ //判断输入的字是否是回车，即按下return
        [_detailAddressTV resignFirstResponder];
        return NO;
    }
    
    return YES;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [_nameTF resignFirstResponder];
    [_addressTF resignFirstResponder];
    [_phoneTF resignFirstResponder];
    [_detailAddressTV resignFirstResponder];
}
- (IBAction)isDefaulAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected == YES) {
        _isDefaul = @1;
    }else {
        _isDefaul = @0;
    }
    
}

- (IBAction)addAddressAction:(UIButton *)sender {
   
    if (_nameTF.text.length == 0 ||
        _phoneTF.text.length == 0 ||
        _addressTF.text.length == 0 ||
        _detailAddressTV.text.length == 0) {
        
        AlertController *alert = [[AlertController alloc] initWithTitle:@"温馨提示!" message:@"请您完善信息！"];
        [alert addButtonTitleArray:@[@"好"]];
        __weak typeof(AlertController *) weakAlert = alert;
        [alert setClickButtonBlock:^(NSInteger tag) {
            [weakAlert dismissViewControllerAnimated:YES
        completion:nil];
        }];
        
        [self presentViewController:alert
                           animated:YES
                         completion:nil];

    }else {
        if (_model) {
            [self changeAddress];
        }else{
            [self addAddress];
        }
    }
    
    
   
}
//添加地址
- (void)addAddress {
    //取出存储的用户信息
    //    NSDictionary *userDic = [[NSUserDefaults standardUserDefaults] objectForKey:@"userDic"];
    //    NSNumber *userId = userDic[@"userId"];
    [self showHUD:@"加载中"];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:@1 forKey:@"userId"];
    if (_provinceId) {
        [params setObject:@{@"id":_provinceId} forKey:@"province"];
    }
    if (_cityId) {
        [params setObject:@{@"id":_cityId} forKey:@"city"];
    }
    if (_areaId) {
        [params setObject:@{@"id":_areaId} forKey:@"area"];
    }
    
    [params setObject:_nameTF.text forKey:@"receiver"];
    [params setObject:_phoneTF.text forKey:@"mobile"];
    [params setObject:_detailAddressTV.text forKey:@"addressDetailFull"];
    [params setObject:_isDefaul forKey:@"isDefault"];
    
    
    NSString *url = [NSString stringWithFormat:@"%@%@",BASE_URL,AddArea_URL];
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
//修改地址
- (void)changeAddress {
    //取出存储的用户信息
    //    NSDictionary *userDic = [[NSUserDefaults standardUserDefaults] objectForKey:@"userDic"];
    //    NSNumber *userId = userDic[@"userId"];
    [self showHUD:@"加载中"];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:@1 forKey:@"userId"];
    [params setObject:_model.addressId forKey:@"id"];
    if (_provinceId) {
        [params setObject:@{@"id":_provinceId} forKey:@"province"];
    }
    if (_cityId) {
        [params setObject:@{@"id":_cityId} forKey:@"city"];
    }
    if (_areaId) {
        [params setObject:@{@"id":_areaId} forKey:@"area"];
    }
    
    [params setObject:_nameTF.text forKey:@"receiver"];
    [params setObject:_phoneTF.text forKey:@"mobile"];
    [params setObject:_detailAddressTV.text forKey:@"addressDetailFull"];
    [params setObject:_isDefaul forKey:@"isDefault"];
    
    
    NSString *url = [NSString stringWithFormat:@"%@%@",BASE_URL,UpdateArea_URL];
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

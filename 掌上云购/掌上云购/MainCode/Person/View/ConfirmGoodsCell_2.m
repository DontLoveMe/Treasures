//
//  ConfirmGoodsCell-2.m
//  掌上云购
//
//  Created by 刘毅 on 16/8/20.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import "ConfirmGoodsCell_2.h"

@implementation ConfirmGoodsCell_2

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _userNameTF.delegate = self;
}

- (IBAction)mannerAction:(UIButton *)sender {
    
    sender.selected = YES;
    [self.delegate clickButtonBackTag:sender.tag];
    if (sender.tag == 100) {
        
        UIButton *mannerBtn1 = [self.contentView viewWithTag:101];
        mannerBtn1.selected = NO;
        UIButton *mannerBtn2 = [self.contentView viewWithTag:102];
        mannerBtn2.selected = NO;
        
        _userNameTF.placeholder = @"请输入手机号码";
    }else if(sender.tag == 101) {
        
        UIButton *mannerBtn1 = [self.contentView viewWithTag:100];
        mannerBtn1.selected = NO;
        UIButton *mannerBtn2 = [self.contentView viewWithTag:102];
        mannerBtn2.selected = NO;
        
        _userNameTF.placeholder = @"请输入掌上元购账号";
    }else {
        UIButton *mannerBtn1 = [self.contentView viewWithTag:100];
        mannerBtn1.selected = NO;
        UIButton *mannerBtn2 = [self.contentView viewWithTag:101];
        mannerBtn2.selected = NO;
        
        _userNameTF.placeholder = @"请输入支付宝账号";

    }
    NSLog(@"%@",_userNameTF.text);
}

- (IBAction)agreeAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    [self.delegate clickButtonBackTag:sender.tag];
}

- (IBAction)sureAction:(UIButton *)sender {
    [self.delegate getUserName:_userNameTF.text];
    [_userNameTF resignFirstResponder];
    [self.delegate clickButtonBackTag:sender.tag];
  

}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [_userNameTF resignFirstResponder];
    
    [self.delegate getUserName:textField.text];
    return YES;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [_userNameTF resignFirstResponder];
    
    [self.delegate getUserName:_userNameTF.text];
}
@end

//
//  ConfirmGoodsCell-2.m
//  掌上云购
//
//  Created by 刘毅 on 16/8/20.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import "ConfirmGoodsCell_2.h"
#import "HtmlTypeController.h"
#import "DelegateTxtController.h"

@implementation ConfirmGoodsCell_2

//选择方式
- (void)setDicts:(NSArray *)dicts {
    if (_dicts != dicts) {
        _dicts = dicts;
        
        if (_dicts.count<=0||_dicts == nil) {
            return;
        }
        for (int i = 0; i<dicts.count; i++) {
            
            NSDictionary *dict = dicts[i];
            
            UIControl *control = [[UIControl alloc] initWithFrame:CGRectMake(38, 100+((37.5)*i+5), KScreenWidth-50, 38)];
            control.layer.borderWidth = 1;
            control.layer.borderColor = [UIColor grayColor].CGColor;
            control.backgroundColor = [UIColor whiteColor];
            control.tag = 200 + i;
            [control addTarget:self action:@selector(selectManner:) forControlEvents:UIControlEventTouchUpInside];
            [self.contentView addSubview:control];
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(5, 10, 15, 15);
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [button setBackgroundImage:[UIImage imageNamed:@"未选中.png"] forState:UIControlStateNormal];
            [button setBackgroundImage:[UIImage imageNamed:@"选中.png"] forState:UIControlStateSelected];
            [control addSubview:button];
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(25, 0, KScreenWidth-80, 38)];
            
            if (![dict[@"label"] isKindOfClass:[NSNull class]]) {
                
                label.text = [NSString stringWithFormat:@"充值到%@",dict[@"label"]];
            }
            label.textColor = [UIColor blackColor];
            label.textAlignment = NSTextAlignmentLeft;
            label.font = [UIFont systemFontOfSize:14];
            [control addSubview:label];
            
            if (i == dicts.count -1) {
                _userNameTF = [[UITextField alloc] initWithFrame:CGRectMake(38, 100+((37.5)*dicts.count+5), KScreenWidth-50, 38)];
                _userNameTF.delegate = self;
                _userNameTF.tag = 300;
                _userNameTF.borderStyle = UITextBorderStyleLine;
                _userNameTF.font = [UIFont systemFontOfSize:14];
                _userNameTF.textColor = [UIColor blackColor];
                [self.contentView addSubview:_userNameTF];
                
                NSDictionary *dic = dicts[0];
                NSInteger value = 0;
                if (![dic[@"value"] isKindOfClass:[NSNull class]]) {
                    value = [dic[@"value"] integerValue];
                }
                if (![dic[@"remarks"] isKindOfClass:[NSNull class]]) {
                    _userNameTF.placeholder = dic[@"remarks"];
                }
                if (value == 3) {
                    _userNameTF.placeholder = @"";
                    _userNameTF.hidden = YES;
                }else {
                    _userNameTF.hidden = NO;
                }
            }
            if (i == 0) {
                
                [self selectManner:control];
            }
        }
        
        
    }
}
- (void)layoutSubviews {
    
    
    
}
- (void)selectManner:(UIControl *)sender {
//    UIButton *mannerBtn = sender.subviews[0];
//    mannerBtn.selected = YES;
    _userNameTF.text = @"";
    for (int i = 0; i<_dicts.count; i++) {
        
        UIControl *control = [self.contentView viewWithTag:200+i];
        UIButton *mannerBtn = control.subviews[0];
        mannerBtn.selected = NO;
        if (i == sender.tag-200) {
            mannerBtn.selected = YES;
        }
        
    }
    NSDictionary *dict = _dicts[sender.tag -200];
    NSInteger value = 0;
    if (![dict[@"value"] isKindOfClass:[NSNull class]]) {
        value = [dict[@"value"] integerValue];
    }
    
    if (![dict[@"remarks"] isKindOfClass:[NSNull class]]) {
        _userNameTF.placeholder = dict[@"remarks"];
    }
    
    if (value == 3) {
        _userNameTF.placeholder = @"";
        _userNameTF.hidden = YES;
    }else {
        _userNameTF.hidden = NO;
    }
    [self.delegate selectMannerValue:value];
}

- (IBAction)agreeAction:(UIButton *)sender {
//    sender.selected = !sender.selected;
    [self.delegate clickButtonBackTag:sender.tag];
}
- (IBAction)zsygDelegate:(UIButton *)sender {
    
    DelegateTxtController *dtVC = [[DelegateTxtController alloc] init];
    
    UINavigationController *dVC = [[UINavigationController alloc] initWithRootViewController:dtVC];
    [[self viewController] presentViewController:dVC animated:YES completion:nil];
    
}
- (UIViewController *)viewController {
    
    UIResponder *next = self.nextResponder;
    
    do {
        
        if ([next isKindOfClass:[UIViewController class]]) {
            
            return (UIViewController *)next;
        }
        
        next = next.nextResponder;
        
    } while (next != nil);
    
    return nil;
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

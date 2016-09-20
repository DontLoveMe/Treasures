//
//  BuyNowControllerViewController.m
//  掌上云购
//
//  Created by 刘毅 on 16/9/20.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import "BuyNowController.h"

@interface BuyNowController ()

@end

@implementation BuyNowController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        self.view.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];

    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _buyNumberTF.delegate = self;
    
    _money = 1;
//    _maxNumber = 100;
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidEndEditing:(UITextField *)textField {
    _money = [textField.text integerValue];
   [self isOutOfRange:_money];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
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

    CGRect rect1 = self.view.frame;
    rect1.origin.y = -kbSize.height;
    self.view.frame = rect1;
   
}

- (void)keyboardWillBeHidden:(NSNotification*)aNotification{

    CGRect rect1 = self.view.frame;
    rect1.origin.y = 0;
    self.view.frame = rect1;

}

- (void)isOutOfRange:(NSInteger)range{
    if (_money<=0) {
        _money = 1;
        
    }
    else if (_money>_maxNumber) {
        _money = _maxNumber;
        
    }else {
    
    }
    _buyNumberTF.text = [NSString stringWithFormat:@"%ld",_money];
    _moneyLabel.text = [NSString stringWithFormat:@"共%ld夺宝币",_money];
}
#pragma mark - 按钮的点击事件
//关闭
- (IBAction)closeAction:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
//减
- (IBAction)subtractAction:(UIButton *)sender {
    _money--;
    [self isOutOfRange:_money];
}
//加
- (IBAction)addAction:(UIButton *)sender {
    _money++;
    [self isOutOfRange:_money];
}
//确定
- (IBAction)sureAction:(UIButton *)sender {
    
    [self.delegate backBuyNumber:_money];
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches.allObjects firstObject];
    CGPoint p = [touch locationInView:self.view];
    if (p.y<KScreenHeight-200) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }else {
        [_buyNumberTF resignFirstResponder];
    }
    
    
}

@end

//
//  PromptController.m
//  掌上云购
//
//  Created by 刘毅 on 16/9/24.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import "PromptController.h"
#import "RedEnvelopeController.h"

@interface PromptController ()

@end

@implementation PromptController

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
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    _imgView.userInteractionEnabled = YES;
    [_imgView addGestureRecognizer:tap];
}
- (IBAction)closeAction:(UIButton *)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)tapAction:(UITapGestureRecognizer*)tap {
    if (_type == 0) {
        
        RedEnvelopeController *reVC = [[RedEnvelopeController alloc] init];
        reVC.isPay = @"1";
        self.navigationController.navigationBar.hidden = NO;
        reVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:reVC animated:YES];
    }else {
        
    }
    
}

- (void)setType:(NSInteger)type{

    if (_type != type) {
        
        _type = type;
        if (_type == 0) {
            _imgView.image = [UIImage imageNamed:@"红包提示"];
        }else {
            _imgView.image = [UIImage imageNamed:@"中奖提示"];
        }
        
    }
    
}

@end

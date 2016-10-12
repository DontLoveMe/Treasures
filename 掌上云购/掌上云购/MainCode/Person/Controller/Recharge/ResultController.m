//
//  RechargeResultController.m
//  掌上云购
//
//  Created by 刘毅 on 16/9/18.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import "ResultController.h"

@interface ResultController ()

@end

@implementation ResultController
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
    
}
- (IBAction)snatchAction:(UIButton *)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    self.clickBlock(sender.tag);
}
- (IBAction)lookListAction:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    self.clickBlock(sender.tag);
}



@end

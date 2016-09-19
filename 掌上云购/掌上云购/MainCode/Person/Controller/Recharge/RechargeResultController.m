//
//  RechargeResultController.m
//  掌上云购
//
//  Created by 刘毅 on 16/9/18.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import "RechargeResultController.h"

@interface RechargeResultController ()

@end

@implementation RechargeResultController
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
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"充值结果";
    self.view.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    [self initNavBar];
}
- (IBAction)snatchAction:(UIButton *)sender {
}
- (IBAction)lookListAction:(UIButton *)sender {
}



@end

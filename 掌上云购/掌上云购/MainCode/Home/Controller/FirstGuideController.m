//
//  FirstGuideController.m
//  掌上云购
//
//  Created by coco船长 on 16/10/17.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import "FirstGuideController.h"

@interface FirstGuideController ()

@end

@implementation FirstGuideController


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

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];

     [_remaindLabel sizeToFit];
    
}

- (IBAction)CloseAction:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:^{
        
        
    }];
    
}

- (IBAction)ensureAction:(id)sender {
    
    LoginViewController *lVC = [[LoginViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:lVC];
    [self presentViewController:nav animated:YES completion:^{
        RegisterViewController *RVC= [[RegisterViewController alloc] init];
        RVC.delegate = self;
        RVC.usernameTF.text = _phoneTF.text;
        [lVC.navigationController pushViewController:RVC animated:YES];
    }];
  
}

- (void)firstGuideBack{

      //获得标签控制器
      TabbarViewcontroller *tb = (TabbarViewcontroller *)[UIApplication sharedApplication].keyWindow.rootViewController;
      //修改索引
      tb.selectedIndex = 4;
      //原选中标签修改
      tb.selectedItem.isSelected = NO;
      //选中新标签
      TabbarItem *item = (TabbarItem *)[tb.view viewWithTag:5];
      item.isSelected = YES;
      //设置为上一个选中
      tb.selectedItem = item;

}

@end

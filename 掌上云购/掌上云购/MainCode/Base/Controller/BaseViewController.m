//
//  BaseViewController.m
//  掌上云购
//
//  Created by coco船长 on 16/8/3.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setNavigationBar];
    
}

//设置导航控制器的属性
-(void)setNavigationBar{
    
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor colorFromHexRGB:@"1685FE"];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:20]};
}

#pragma mark - 设置HUD
- (void)showHUD:(NSString *)title {
    
    if (_hud == nil) {
        _hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    }
    
    _hud.labelText = title;
    
    [_hud show:YES];
}

- (void)hideSuccessHUD:(NSString *)title {
    
    if (title.length == 0) {
        [_hud hide:YES afterDelay:1.f];
    } else {
        
        _hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
        //显示模式设置为：自定义视图模式
        _hud.mode = MBProgressHUDModeCustomView;
        _hud.labelText = title;
        
        //延迟隐藏
        [_hud hide:YES afterDelay:1.5];
        [self performSelector:@selector(changgeModel)
                   withObject:nil
                   afterDelay:2.f];
    }
    
}

- (void)hideFailHUD:(NSString *)title {
    
    if (title.length == 0) {
        [_hud hide:YES afterDelay:1.5];
    } else {
        
        _hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
        //显示模式设置为：自定义视图模式
        _hud.mode = MBProgressHUDModeDeterminate;
        _hud.labelText = title;
        
        //延迟隐藏
        [_hud hide:YES afterDelay:1.5];
        [self performSelector:@selector(changgeModel)
                   withObject:nil
                   afterDelay:2.f];
    }
    
}

- (void)changgeModel{
    
    _hud.mode = MBProgressHUDModeIndeterminate;
    
}

@end

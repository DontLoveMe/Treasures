//
//  GoodsStateCell.m
//  掌上云购
//
//  Created by 刘毅 on 16/8/19.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import "GoodsStateCell.h"
#import "AddressViewController.h"
#import "AlertController.h"

@implementation GoodsStateCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
//    _timeLabel2.text = @"";
}
//确认地址
- (IBAction)sureAddress:(UIButton *)sender {
    AlertController *alert = [[AlertController alloc] initWithTitle:@"温馨提示!" message:@"是否使用默认地址?"];
    [alert addButtonTitleArray:@[@"否",@"是"]];
    __weak typeof(AlertController*) weakAlert = alert;
    __weak typeof(self) weakSelf = self;
    [alert setClickButtonBlock:^(NSInteger tag) {
        if (tag == 0) {
            [weakAlert dismissViewControllerAnimated:YES completion:nil];
        }else {
            [weakAlert dismissViewControllerAnimated:YES completion:nil];
            [weakSelf.delegate clickButtonBackTag:sender.tag-200];
        }
    }];
    [[self viewController] presentViewController:alert
                                        animated:YES
                                      completion:nil];
    
    

}
//选择地址
- (IBAction)selectAddress:(UIButton *)sender {
    AddressViewController *avc = [[AddressViewController alloc] init];
    [[self viewController].navigationController pushViewController:avc animated:YES];
}
//延期收货
- (IBAction)delayReceipt:(UIButton *)sender {
    
    
    
    AlertController *alert = [[AlertController alloc] initWithTitle:@"温馨提示!" message:@"确认延期收货么?(提供48小时延期，如有疑问请联系客服)"];
    [alert addButtonTitleArray:@[@"取消",@"确认"]];
    __weak typeof(AlertController*) weakAlert = alert;
    __weak typeof(self) weakSelf = self;
    [alert setClickButtonBlock:^(NSInteger tag) {
        if (tag == 0) {//取消
            [weakAlert dismissViewControllerAnimated:YES completion:nil];
        }else {//确认
            [weakAlert dismissViewControllerAnimated:YES completion:nil];
            [weakSelf.delegate clickButtonBackTag:sender.tag-200];
        }
    }];
    [[self viewController] presentViewController:alert
                                        animated:YES
                                      completion:nil];
}
//确认收货
- (IBAction)sureReceipt:(UIButton *)sender {
    AlertController *alert = [[AlertController alloc] initWithTitle:@"温馨提示!" message:@"确认收货么?"];
    [alert addButtonTitleArray:@[@"取消",@"确认"]];
    __weak typeof(AlertController*) weakAlert = alert;
    __weak typeof(self) weakSelf = self;
    [alert setClickButtonBlock:^(NSInteger tag) {
        if (tag == 0) {//取消
            [weakAlert dismissViewControllerAnimated:YES completion:nil];
        }else {//确认
            [weakAlert dismissViewControllerAnimated:YES completion:nil];
            [weakSelf.delegate clickButtonBackTag:sender.tag-200];
        }
    }];
    [[self viewController] presentViewController:alert
                                        animated:YES
                                      completion:nil];
    
}
//立即晒单
- (IBAction)shareAction:(UIButton *)sender {
    [self.delegate clickButtonBackTag:sender.tag-200];
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

@end

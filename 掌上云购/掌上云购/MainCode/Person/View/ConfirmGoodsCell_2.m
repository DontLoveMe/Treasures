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
}

- (IBAction)mannerAction:(UIButton *)sender {
    
    sender.selected = YES;
    [self.delegate clickButtonBackTag:sender.tag];
    if (sender.tag == 100) {
        
        UIButton *mannerBtn = [self.contentView viewWithTag:101];
        mannerBtn.selected = NO;
    }else {
        
        UIButton *mannerBtn = [self.contentView viewWithTag:100];
        mannerBtn.selected = NO;
    }
    
}

- (IBAction)agreeAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    [self.delegate clickButtonBackTag:sender.tag];
}

- (IBAction)sureAction:(UIButton *)sender {
    [self.delegate clickButtonBackTag:sender.tag];
  

}


@end

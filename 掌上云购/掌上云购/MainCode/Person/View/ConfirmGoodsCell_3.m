//
//  ConfirmGoodsCell_3.m
//  掌上云购
//
//  Created by 刘毅 on 16/8/20.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import "ConfirmGoodsCell_3.h"
#import "AddShareController.h"

@implementation ConfirmGoodsCell_3

- (void)awakeFromNib {
    [super awakeFromNib];
    
}
- (IBAction)copYAction:(UIButton *)sender {
    
}
- (IBAction)sunShareAction:(UIButton *)sender {
    
    AddShareController *addSVC = [[AddShareController alloc] init];
    
    [[self viewController].navigationController pushViewController:addSVC animated:YES];
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

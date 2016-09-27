//
//  HisIconImage.m
//  掌上云购
//
//  Created by 刘毅 on 16/9/22.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import "HisIconImageView.h"
#import "HisCenterController.h"

@implementation HisIconImageView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initView];
        
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
    
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initView];
    }
    return self;
}

- (void)initView {
    self.userInteractionEnabled = YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (_buyUserId == 0) {
        return;
    }
    HisCenterController *hcVC = [[HisCenterController alloc] init];
    hcVC.buyUserId = _buyUserId;
    [[self viewController].navigationController pushViewController:hcVC animated:YES];
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

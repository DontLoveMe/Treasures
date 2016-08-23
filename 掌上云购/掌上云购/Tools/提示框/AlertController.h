//
//  AlertController.h
//  test
//
//  Created by 刘毅 on 16/8/22.
//  Copyright © 2016年 刘毅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlertController : UIViewController

@property (nonatomic, copy) void(^sureBlock)();

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message;


@end

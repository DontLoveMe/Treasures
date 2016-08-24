//
//  AlertController.h
//  test
//
//  Created by 刘毅 on 16/8/22.
//  Copyright © 2016年 刘毅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlertController : UIViewController

/**
 *  初始化
 */
- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message;
/**
 *  添加按钮（数组传字符串数组）
 */
- (void)addButtonTitleArray:(NSArray *)titleArray;

/**
 *  点击按钮返回按钮tag的Block
 */
@property (nonatomic, copy) void(^clickButtonBlock)(NSInteger btnTag);

@end

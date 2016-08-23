//
//  SelectView.h
//  掌上云购
//
//  Created by 杨浩斌 on 16/8/23.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectView : UIView

- (void)setCallbackBlock:(void(^)(NSInteger index))block;

- (void)selectBtn:(NSInteger)index;

@end

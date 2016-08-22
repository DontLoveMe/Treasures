//
//  AreaPickerView.h
//  掌上云购
//
//  Created by 刘毅 on 16/8/18.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AreaPickerViewDelegate <NSObject>

@optional

- (void)areaPickerViewSelectProvince:(NSDictionary *)province city:(NSDictionary *)city area:(NSDictionary *)area;

@end

@interface AreaPickerView : UIView

@property (nonatomic,assign)id<AreaPickerViewDelegate> delegate;

@end

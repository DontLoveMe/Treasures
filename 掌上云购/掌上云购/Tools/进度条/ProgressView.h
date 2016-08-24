//
//  ProgressView.h
//  掌上云购
//
//  Created by coco船长 on 16/8/23.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProgressView : UIView{

    UIImageView *_bgImgView;
    UIImageView *_progressImgView;

}

//进度（小数）
@property (nonatomic ,assign)NSInteger progress;

@end

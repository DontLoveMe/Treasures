//
//  SegmentController.h
//  test
//
//  Created by 刘毅 on 16/7/27.
//  Copyright © 2016年 刘毅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface SegmentController : BaseViewController{

    UIView *_topKindView;

}

@property (nonatomic,strong)NSArray *segmentTitles;
@property (nonatomic,strong)NSArray *imgNames;
@property (nonatomic,strong)NSArray *selectImgNames;


@end

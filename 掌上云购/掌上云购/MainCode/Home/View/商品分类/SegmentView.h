//
//  SegmentView.h
//  test
//
//  Created by 刘毅 on 16/7/27.
//  Copyright © 2016年 刘毅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SegmentView : UIScrollView
/**
 * 初始化方法
 * @param frame 视图的frame
 * @param titles control的标题
 * @param names normal下图片的名字数组
 * @reture self
 */
- (instancetype)initWithFrame:(CGRect)frame
        segmentTitles:(NSArray *)titles
                   imageNames:(NSArray *)names
               selectImgNames:(NSArray *)selectNames;

/**
 * 选中返回的block
 */
@property (nonatomic,copy)void(^tagBlock)(NSInteger);
/**
 * 设置开始的索引,默认是第一个,index=0。
 */
@property (nonatomic,assign)NSInteger index;
@end

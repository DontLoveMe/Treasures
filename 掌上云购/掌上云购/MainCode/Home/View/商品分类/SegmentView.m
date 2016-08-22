//
//  SegmentView.m
//  test
//
//  Created by 刘毅 on 16/7/27.
//  Copyright © 2016年 刘毅. All rights reserved.
//

#import "SegmentView.h"

#define kNormalTag 100
#define kControlHight 40
#define kNormalColor [UIColor blackColor]
#define kSelectColor [UIColor orangeColor]

@implementation SegmentView {
    
    UIImageView *_lineView;
    NSInteger _selectTag;
    NSArray *_normalNames;
    NSArray *_selectNames;
}

- (instancetype)initWithFrame:(CGRect)frame
        segmentTitles:(NSArray *)titles
           imageNames:(NSArray *)names
               selectImgNames:(NSArray *)selectNames{
    self = [super initWithFrame:frame];
    if (self) {
        _normalNames = names;
        _selectNames = selectNames;
        //初始化子视图
        [self initSubviews:titles imageNames:names];
        
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        
    }

    return self;
}
//初始化子视图
- (void)initSubviews:(NSArray *)titles
          imageNames:(NSArray *)names {
    
    for (int i = 0; i < titles.count; i ++) {
        UIControl *control = [[UIControl alloc] initWithFrame:CGRectMake(0, kControlHight*i, self.frame.size.width, kControlHight)];
        control.tag = kNormalTag + i;
        [self addSubview:control];
        [control addTarget:self action:@selector(controlAction:) forControlEvents:UIControlEventTouchUpInside];
        
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, (kControlHight-20)/2, 20, 20)];
        imgView.tag = 200;
        imgView.image = [UIImage imageNamed:names[i]];
        [control addSubview:imgView];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imgView.frame)+3, 10, self.frame.size.width-30, 20)];
        label.tag = 201;
        label.text = titles[i];
        label.textColor = kNormalColor;
        label.font = [UIFont systemFontOfSize:15];
        [control addSubview:label];
        
        if (i == 0) {
            [self changeSelectState:control];
            _selectTag = control.tag;
        }
    }
    //创建control旁边的竖线
    _lineView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
//    _lineView.backgroundColor = kSelectColor;
    _lineView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    [self insertSubview:_lineView atIndex:0];
    
    
    self.contentSize = CGSizeMake(self.frame.size.width, kControlHight*titles.count);
}
//设置开始的索引
- (void)setIndex:(NSInteger)index {
    _index = index;
    UIControl *indexControl = [self viewWithTag:_index+kNormalTag];
    UIControl *selectControl = [self viewWithTag:_selectTag];
    [self changeNormalState:selectControl];
    [self changeSelectState:indexControl];
}
//control的点击事件
- (void)controlAction:(UIControl *)control {
    
    UIControl *selectControl = [self viewWithTag:_selectTag];
    [self changeNormalState:selectControl];
    [self changeSelectState:control];
    self.tagBlock(control.tag - kNormalTag);
}
//改变control的状态（选中）
- (void)changeSelectState:(UIControl *)control {
    
    [UIView animateWithDuration:0.2 animations:^{
        CGRect frame = _lineView.frame;
        frame.origin.y = control.frame.origin.y;
        _lineView.frame = frame;
    }];
    
    //移动视图
    CGRect frame;
    frame.origin.x = 0;
    frame.origin.y = kControlHight*(control.tag - kNormalTag);
    frame.size = self.frame.size;
    [self scrollRectToVisible:frame animated:YES];
    
    //更改图片
    UIImageView *imgView = [control viewWithTag:200];
    if (_selectNames.count>0) {
        imgView.image = [UIImage imageNamed:_selectNames[control.tag-kNormalTag]];
    }
    //更改字体颜色
    UILabel *lable = [control viewWithTag:201];
    lable.textColor = kSelectColor;
    //重设选中control的tag值
    _selectTag = control.tag;
}
//改变control的状态（还原）
- (void)changeNormalState:(UIControl *)control {
    //更改图片
    UIImageView *imgView = [control viewWithTag:200];
    if (_normalNames.count > 0) {
        imgView.image = [UIImage imageNamed:_normalNames[control.tag-kNormalTag]];
    }
    //更改字体颜色
    UILabel *lable = [control viewWithTag:201];
    lable.textColor = kNormalColor;
    
}

@end

//
//  SegmentView.m
//  test
//
//  Created by 刘毅 on 16/7/27.
//  Copyright © 2016年 刘毅. All rights reserved.
//

#import "SegmentView.h"
#import "UIImageView+AFNetworking.h"

#define kNormalTag 100
#define kControlHight 50
#define kNormalColor [UIColor blackColor]
#define kSelectColor [UIColor whiteColor]

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
        if (selectNames == nil) {
            
        }else {
            _selectNames = selectNames;
        }
        
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
        UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(0, kControlHight-1, self.frame.size.width, 1)];
        line.backgroundColor = [UIColor colorWithWhite:0.8 alpha:1];
        [control addSubview:line];
        
        [control addTarget:self action:@selector(controlAction:) forControlEvents:UIControlEventTouchUpInside];
        
//        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(5, (kControlHight-18)/2, 18, 18)];
//        imgView.tag = 200;
//        if ([names[i] hasPrefix:@"http"]) {
//            [imgView setImageWithURL:[NSURL URLWithString:names[i]]];
//        }else {
//            
//            imgView.image = [UIImage imageNamed:names[i]];
//        }
//        [control addSubview:imgView];
        
//        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imgView.frame)+2, (kControlHight-20)/2, self.frame.size.width-30, 20)];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, (kControlHight-20)/2, self.frame.size.width, 20)];
        label.tag = 201;
        label.text = titles[i];
        label.textColor = kNormalColor;
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:12];
        [control addSubview:label];
        
        if (i == 0) {
            [self changeSelectState:control];
            _selectTag = control.tag;
        }
    }
    //创建control旁边的竖线
    _lineView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, kControlHight)];
//    _lineView.backgroundColor = kSelectColor;
    _lineView.backgroundColor = [UIColor colorFromHexRGB:ThemeColor];
    [self insertSubview:_lineView atIndex:0];
    
    
    self.contentSize = CGSizeMake(self.frame.size.width, kControlHight*titles.count);
    UIImageView *verticalLine = [[UIImageView alloc] initWithFrame:CGRectMake(self.contentSize.width-1, 0, 1, self.contentSize.height)];
    verticalLine.backgroundColor = [UIColor colorWithWhite:0.8 alpha:1];
    [self addSubview:verticalLine];
}
//设置开始的索引
- (void)setIndex:(NSInteger)index {
    _index = index;
    UIControl *indexControl = [self viewWithTag:_index+kNormalTag];
//    UIControl *selectControl = [self viewWithTag:_selectTag];
//    [self changeNormalState:selectControl];
//    [self changeSelectState:indexControl];
    [self controlAction:indexControl];
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
//    UIImageView *imgView = [control viewWithTag:200];
//    if (_selectNames.count>0) {
//        imgView.image = [UIImage imageNamed:_selectNames[control.tag-kNormalTag]];
//    }
    //更改字体颜色
    UILabel *lable = [control viewWithTag:201];
    lable.textColor = kSelectColor;
    //重设选中control的tag值
    _selectTag = control.tag;
}
//改变control的状态（还原）
- (void)changeNormalState:(UIControl *)control {
    //更改图片
//    UIImageView *imgView = [control viewWithTag:200];
//    if (_normalNames.count > 0) {
//        imgView.image = [UIImage imageNamed:_normalNames[control.tag-kNormalTag]];
//    }
    //更改字体颜色
    UILabel *lable = [control viewWithTag:201];
    lable.textColor = kNormalColor;
    
}

@end

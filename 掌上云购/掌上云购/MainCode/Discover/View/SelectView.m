//
//  SelectView.m
//  掌上云购
//
//  Created by 杨浩斌 on 16/8/23.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import "SelectView.h"

typedef void(^Block) (NSInteger index);

@implementation SelectView
{


    Block _block;
    
    UIView *_barView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        NSArray * titles = @[@"夺宝记录", @"幸运记录", @"晒单记录"];
        
        for (NSInteger i = 0; i < 3; i++) {
            [self addBtnWithTitle:titles[i] target:self action:@selector(btnClicked:) frame:CGRectMake(i * frame.size.width/3, 0, frame.size.width/3, frame.size.height) tag:i + 100];
        }
        for (NSInteger i = 0; i < 2; i++) {
            UIView * view = [[UIView alloc] initWithFrame:CGRectMake((i + 1) * (frame.size.width/3 - 1), 10, 2, 30)];
            view.backgroundColor = [UIColor grayColor];
            [self addSubview:view];
        }
        _barView = [[UIView alloc] initWithFrame:CGRectMake(0, 46, frame.size.width/3, 4)];
        _barView.backgroundColor = [UIColor orangeColor];
        [self addSubview:_barView];
    }
    return self;
}

- (void)addBtnWithTitle:(NSString *)title target:(id)target action:(SEL)action frame:(CGRect)frame tag:(NSInteger)tag {
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    btn.frame = frame;
    btn.tag = tag;
    [self addSubview:btn];
}

- (void)btnClicked:(UIButton *)btn {
    
    
    CGPoint center = _barView.center;
    center.x = btn.center.x;
    
    [UIView animateWithDuration:0.5 animations:^{
        _barView.center = center;
    }];
    
    NSInteger index = btn.tag - 100;
    // 调用block运行
    if (_block) {
        _block(index);
    }
}

// void(^)(NSInteger index)
// void 表示返回值为空
// NSInteger index 表示参数是整形数值
- (void)setCallbackBlock:(void(^)(NSInteger index))block {
    _block = [block copy];
}

- (void)selectBtn:(NSInteger)index {
    CGPoint center = _barView.center;
    
    UIButton * btn = [self viewWithTag:index + 100];
    center.x = btn.center.x;
    
    [UIView animateWithDuration:0.5 animations:^{
        _barView.center = center;
    }];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

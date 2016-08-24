//
//  AlertController.m
//  test
//
//  Created by 刘毅 on 16/8/22.
//  Copyright © 2016年 刘毅. All rights reserved.
//

#import "AlertController.h"

@interface AlertController ()

@property (nonatomic, strong)UIView *bgView;
@property (nonatomic, strong)UILabel *titleLabel;
@property (nonatomic, strong)UILabel *msgLabel;
@property (nonatomic, assign)CGFloat bgH;

@end

@implementation AlertController

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message {
    self = [super init];
    if (self) {
        self.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        self.view.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];
        [self initSubViews:title message:message];
    }
    return self;
}

- (void)initSubViews:(NSString *)title message:(NSString *)message{
    
    if (message==nil||message.length == 0) {
        _bgH = 70;
    }else {
        _bgH = 100;
    }
    _bgView = [[UIView alloc] initWithFrame:CGRectMake(40, (KScreenHeight-200)/2, KScreenWidth-40*2, _bgH)];
    _bgView.backgroundColor = [UIColor whiteColor];
    //    backView.layer.shadowRadius = 40;
    _bgView.layer.cornerRadius = 20;
    _bgView.layer.masksToBounds = YES;
    [self.view addSubview:_bgView];
    
    CGRect titleRect = [title boundingRectWithSize:CGSizeMake(_bgView.frame.size.width, 50) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20]} context:nil];
    CGFloat w = _bgView.frame.size.width;
    CGFloat th = titleRect.size.height;
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 15, w, th)];
    _titleLabel.numberOfLines = 2;
    _titleLabel.text = title;
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.textColor = [UIColor blackColor];
    _titleLabel.font = [UIFont systemFontOfSize:20];
    [_bgView addSubview:_titleLabel];
    
    CGRect msgRect = [message boundingRectWithSize:CGSizeMake(_bgView.frame.size.width, 50) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20]} context:nil];
    _msgLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 20+th, w, msgRect.size.height)];
    _msgLabel.numberOfLines = 2;
    _msgLabel.text = message;
    _msgLabel.textAlignment = NSTextAlignmentCenter;
    _msgLabel.textColor = [UIColor darkGrayColor];
    _msgLabel.font = [UIFont systemFontOfSize:15];
    [_bgView addSubview:_msgLabel];
    
}
//添加按钮
- (void)addButtonTitleArray:(NSArray *)titleArray{
    CGFloat w = _bgView.frame.size.width;
    if (titleArray.count>2) {
        CGFloat h = _bgH + 50 *titleArray.count;
       _bgView.frame = CGRectMake(40, (KScreenHeight-h)/2, KScreenWidth-40*2, h);
        
    }else {
        CGRect frame = _bgView.frame;
        frame.size.height = _bgH+50;
        _bgView.frame = frame;
    }
    CGFloat h = _bgView.frame.size.height;
    
    for (int i = 0; i < titleArray.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        switch (titleArray.count) {
            case 0:
                
                break;
            case 1:
            {
                button.frame = CGRectMake(0, h-50, w, 50);
                UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMinY(button.frame), w, 1)];
                line.backgroundColor = [UIColor colorWithWhite:.8 alpha:1];
                [_bgView addSubview:line];
                
            }
                break;
            case 2:
            {
                button.frame = CGRectMake(w/2*i, h-50, w/2, 50);
                if (i == 0) {
                    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMinY(button.frame), w, 1)];
                    line1.backgroundColor = [UIColor colorWithWhite:.8 alpha:1];
                    [_bgView addSubview:line1];
                    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(w/2, h-50, 1, 50)];
                    line2.backgroundColor = [UIColor colorWithWhite:.8 alpha:1];
                    [_bgView addSubview:line2];
                }
            }
                break;
                
            default:{
                button.frame = CGRectMake(0, 100+50*i, w, 50);
                if (i == 0) {
                    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMinY(button.frame), w, 1)];
                    line1.backgroundColor = [UIColor colorWithWhite:.8 alpha:1];
                    [_bgView addSubview:line1];
                    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(button.frame), w, 1)];
                    line2.backgroundColor = [UIColor colorWithWhite:.8 alpha:1];
                    [_bgView addSubview:line2];
                }else {
                    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(button.frame), w, 1)];
                    line.backgroundColor = [UIColor colorWithWhite:.8 alpha:1];
                    [_bgView addSubview:line];
                }
            }
                break;
        }
        button.tag = 100 +i;
        [button setTitleColor:[UIColor colorWithRed:0 green:128/255.0 blue:1 alpha:1] forState:UIControlStateNormal];
        [button setTitle:titleArray[i] forState:UIControlStateNormal];
        
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [_bgView addSubview:button];
    }
}
//按钮的点击事件
- (void)buttonAction:(UIButton *)button{
   
    self.clickButtonBlock(button.tag - 100);
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end

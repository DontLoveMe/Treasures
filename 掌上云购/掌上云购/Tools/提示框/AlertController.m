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
    
    _bgView = [[UIView alloc] initWithFrame:CGRectMake(40, (KScreenHeight-280)/2, KScreenWidth-40*2, 150)];
    _bgView.backgroundColor = [UIColor whiteColor];
    //    backView.layer.shadowRadius = 40;
    _bgView.layer.cornerRadius = 20;
    _bgView.layer.masksToBounds = YES;
    [self.view addSubview:_bgView];
    
    CGRect titleRect = [title boundingRectWithSize:CGSizeMake(_bgView.frame.size.width, 50) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20]} context:nil];
    CGFloat w = _bgView.frame.size.width;
    CGFloat h = _bgView.frame.size.height;
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
   
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, h-50, w, 1)];
    line.backgroundColor = [UIColor colorWithWhite:.8 alpha:1];
    [_bgView addSubview:line];
    
    
    for (int i = 0; i < 2; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = 100 +i;
        button.frame = CGRectMake(w/2*i, h-50, w/2, 50);
        [button setTitleColor:[UIColor colorWithRed:0 green:128/255.0 blue:1 alpha:1] forState:UIControlStateNormal];
        if (i == 0) {
            [button setTitle:@"取消" forState:UIControlStateNormal];
        }else {
            [button setTitle:@"确定" forState:UIControlStateNormal];
        }
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [_bgView addSubview:button];
    }

    
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(w/2, h-50, 1, 50)];
    line2.backgroundColor = [UIColor colorWithWhite:.8 alpha:1];
    [_bgView addSubview:line2];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    
    
}
- (void)buttonAction:(UIButton *)button{
    switch (button.tag) {
        case 100:
            [self dismissViewControllerAnimated:YES completion:nil];
            break;
        case 101:
            [self dismissViewControllerAnimated:YES completion:nil];
            self.sureBlock();
            break;
            
        default:
            break;
    }
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end

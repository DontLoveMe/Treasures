//
//  ProgressView.m
//  掌上云购
//
//  Created by coco船长 on 16/8/23.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import "ProgressView.h"

@implementation ProgressView

- (instancetype)init{
    
    self = [super init];
    if (self) {
        [self initView];
    }
    return self;
    
}

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
    
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initView];
    }
    return self;
    
}

- (void)initView{

    self.backgroundColor = [UIColor clearColor];
    
    _bgImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
    _bgImgView.backgroundColor = [UIColor colorWithWhite:0.8 alpha:1];
    _bgImgView.layer.cornerRadius = self.height / 2;
    _bgImgView.layer.masksToBounds = YES;
    _bgImgView.layer.borderWidth = 0;
    _bgImgView.layer.borderColor = [[UIColor clearColor] CGColor];
    [self addSubview:_bgImgView];
    
    
    _progressImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 0, self.height)];
    _progressImgView.backgroundColor = [UIColor colorFromHexRGB:@"FDB730"];
    _progressImgView.layer.cornerRadius = self.height / 2;
    _progressImgView.layer.masksToBounds = YES;
    _progressImgView.layer.borderWidth = 0;
    _progressImgView.layer.borderColor = [[UIColor clearColor] CGColor];
    [self addSubview:_progressImgView];
    
}

- (void)setProgress:(NSInteger)progress{

    if (_progress != progress) {
        
        _progress = progress;
        
        _progressImgView.width = self.width * _progress / 100;

    }

}

@end

//
//  HomeFunctionControl.m
//  掌上云购
//
//  Created by coco船长 on 16/8/15.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import "HomeFunctionControl.h"

@implementation HomeFunctionControl

//重写实例化方法
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
    
    float imgWidth = self.width / 4;
    
    self.backgroundColor = [UIColor whiteColor];
    
    _themeImg = [[UIImageView alloc] initWithFrame:CGRectMake(imgWidth, (self.height - imgWidth) / 2 - imgWidth / 2, imgWidth * 2, imgWidth * 2)];
    [self addSubview:_themeImg];
    
    _themeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, _themeImg.bottom + 4.f, self.width, 20.f)];
    _themeLabel.textColor = [UIColor blackColor];
    _themeLabel.font = [UIFont systemFontOfSize:12];
    _themeLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_themeLabel];

}

- (void)setControlFlag:(NSString *)controlFlag{

    if (_controlFlag != controlFlag) {
        
        _controlFlag = controlFlag;
        [_themeImg setImage:[UIImage imageNamed:@"揭晓-图片.jpg"]];
        _themeLabel.text = _controlFlag;
        
    }
    
}

@end

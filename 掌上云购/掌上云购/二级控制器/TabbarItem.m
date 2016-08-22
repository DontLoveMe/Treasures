//
//  TabbarItem.m
//  掌上云购
//
//  Created by coco船长 on 16/8/3.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import "TabbarItem.h"

@implementation TabbarItem

{
    
    UIImageView *bgImg;
    UIImageView *imgView;
    UILabel *titleLabel;
    NSString *imgName;
}

- (id)initWithFrame:(CGRect)frame
          imageName:(NSString *)imageName
              title:(NSString *)title {
    
    self = [super initWithFrame:frame];
    imgName = imageName;
    if (self) {
        
        self.contentMode = UIViewContentModeScaleToFill;
        self.backgroundColor = [UIColor whiteColor];
        // 设置背景图片
        imgView = [[UIImageView alloc] initWithFrame:CGRectMake((frame.size.width-20)/2, 5, 20, 20)];
        // 设置图片模式
        imgView.contentMode = UIViewContentModeScaleAspectFit;
        UIImage *image = [UIImage imageNamed:imgName];
        imgView.image = image;
        [self addSubview:imgView];
        
        //设置title
        CGFloat imageViewBottom = imgView.bottom;
        titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, imageViewBottom, self.width, 20)];
        titleLabel.text = title;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.font = [UIFont systemFontOfSize:13];
        titleLabel.textColor = [UIColor colorFromHexRGB:@"5A5A5A"];
        [self addSubview:titleLabel];
    }
    return self;
}

- (void)setIsSelected:(BOOL) selected {
    
    if (selected) {
        
        imgView.image = [UIImage imageNamed:[imgName stringByAppendingString:@"-selected"]];
        titleLabel.textColor = [UIColor colorFromHexRGB:ThemeColor];
        
    } else {
        
        UIImage *image = [UIImage imageNamed:imgName];
        imgView.image = image;
        titleLabel.textColor = [UIColor colorFromHexRGB:@"5A5A5A"];
    }
}

@end

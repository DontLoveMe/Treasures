//
//  InordertoshareCell.m
//  掌上云购
//
//  Created by 刘毅 on 16/8/15.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import "InordertoshareCell.h"
#import "HisCenterController.h"
#import "PersonalCenterController.h"


@implementation InordertoshareCell {
    
    NSArray *_imgViews;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initViews];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initViews];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
       [self initViews];
    }
    return self;
}
- (void)initViews {
    self.clipsToBounds = YES;
    NSMutableArray *arr = [NSMutableArray array];
    for (int i = 0; i < 6; i ++) {
        
        UIImageView *imgView = [[UIImageView alloc] init];
        [arr addObject:imgView];
        imgView.hidden = YES;
        
    }
    _imgViews = arr;
}
- (void)setISModel:(InordertoshareModel *)iSModel {
    _iSModel = iSModel;
    
//    NSString *urlStr = _iSModel.userPhotoUrl;
//    NSURL *url = [NSURL URLWithString:urlStr];
//    [_iconButton setBackgroundImageForState:UIControlStateNormal withURL:url placeholderImage:[UIImage imageNamed:@"我的_头像"]];
    
    _nameLabel.text = _iSModel.nickName;
    //转时间格式
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [dateFormatter dateFromString:_iSModel.createDate];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"MM-dd HH:mm"];
    
    NSString *currentDateStr = [dateFormatter stringFromDate:date];
    _dateLabel.text = currentDateStr;
    
    _titleLabel.text = _iSModel.title;

    _productNameLabel.text = [NSString stringWithFormat:@"获得商品：%@",_iSModel.productName];
    _drawTimesLabel.text = [NSString stringWithFormat:@"期号：%@",_iSModel.drawTimes];
    _contentLabel.text = _iSModel.content;
    
    CGRect contentRect = [ _iSModel.content boundingRectWithSize:CGSizeMake(KScreenWidth-57, 35) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil];
    
    NSArray *photoUrllist = _iSModel.photoUrllist;
    for (int i = 0; i < _imgViews.count; i ++) {
        UIImageView *imgView = _imgViews[i];
//        imgView.backgroundColor = [UIColor grayColor];
        CGFloat w =  (KScreenWidth-48-8)/3;
        CGFloat h = 90;
        CGFloat x = (w+4)*(i%3);
        CGFloat y = CGRectGetMinY(_contentLabel.frame)+contentRect.size.height+3+94*(i/3);
        imgView.frame = CGRectMake(x, y, w, h);
        [self.bgView addSubview:imgView];
        if (i > photoUrllist.count-1||photoUrllist == nil||photoUrllist.count == 0) {
            imgView.hidden = YES;
           
        }else {
            imgView.hidden = NO;
            NSURL *url = [NSURL URLWithString:photoUrllist[i]];
            [imgView setImageWithURL:url placeholderImage:[UIImage imageNamed:@"揭晓-图片.jpg"]];
        }
    }
}
//头像按钮的点击
- (IBAction)iconAction:(UIButton *)sender {
    PersonalCenterController *hcVC = [[PersonalCenterController alloc] init];
    [[self viewController].navigationController pushViewController:hcVC animated:YES];
}

- (UIViewController *)viewController {
    
    UIResponder *next = self.nextResponder;
    
    do {
        
        if ([next isKindOfClass:[UIViewController class]]) {
            
            return (UIViewController *)next;
        }
        
        next = next.nextResponder;
        
    } while (next != nil);
    
    return nil;
}



@end

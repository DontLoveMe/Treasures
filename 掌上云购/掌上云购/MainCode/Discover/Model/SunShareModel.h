//
//  SunShareModel.h
//  掌上云购
//
//  Created by 杨浩斌 on 16/8/25.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SunShareModel : NSObject

//用户名
@property(nonatomic,copy)NSString *nickName;

//晒单标题
@property(nonatomic,copy)NSString *title;

//商品名称
@property(nonatomic,copy)NSString *productName;

//期号
@property(nonatomic,copy)NSString *drawTimes;

//评论内容
@property(nonatomic,copy)NSString *content;

//晒单图片
@property(nonatomic,copy)NSString *photoUrl;

@end

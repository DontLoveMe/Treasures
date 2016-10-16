//
//  RedEnvelopeController.h
//  掌上云购
//
//  Created by 刘毅 on 16/8/15.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import "BaseViewController.h"
#import "UseRedElpTableView.h"

@protocol RedEnveloperDelegate <NSObject>

@optional
- (void)paySelectDic:(NSDictionary *)redEnveloperDic;

@end

@interface RedEnvelopeController : BaseViewController<UIScrollViewDelegate,RedEnveloperTableDelegate>

@property (nonatomic,weak)id<RedEnveloperDelegate> redDellegate;

//1,查看红包,2,支付时选择红包
@property (nonatomic,copy)NSString *isPay;
@property (nonatomic,assign)NSInteger constNum;

@property (nonatomic,strong)NSNumber *businessId;
//yes:是红包弹窗进来的
@property (nonatomic,assign)BOOL isMsgPush;

@end

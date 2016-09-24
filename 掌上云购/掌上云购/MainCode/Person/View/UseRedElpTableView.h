//
//  UseRedElpTableView.h
//  掌上云购
//
//  Created by 刘毅 on 16/8/16.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RedEnveloperTableDelegate <NSObject>

@optional
- (void)paySelectCellDic:(NSDictionary *)redEnveloperDic;

@end

@interface UseRedElpTableView : UITableView<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic ,weak)id<RedEnveloperTableDelegate> redTableDelegate;

@property (nonatomic ,strong)NSArray *data;//数据
//1,查看红包,2,支付时选择红包
@property (nonatomic,copy)NSString *isPay;

@property (nonatomic ,strong)UIView *noView;//无数据显示的图片

@end

//
//  UseRedElpTableView.h
//  掌上云购
//
//  Created by 刘毅 on 16/8/16.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UseRedElpTableView : UITableView<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic ,strong)NSArray *data;//数据

@property (nonatomic ,strong)UIView *noView;//无数据显示的图片

@end

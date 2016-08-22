//
//  BroughtHistoryView.h
//  掌上云购
//
//  Created by coco船长 on 16/8/18.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BroughtHistoryCell.h"
#import "UIScrollView+MJRefresh.h"

@protocol BroughtHistoryDelegate <NSObject>

@optional
- (void)pullBack;

@end

@interface BroughtHistoryView : UIView<UITableViewDelegate,UITableViewDataSource>{

    UILabel     *_recommandLabel;
    
    UITableView *_recordTable;
    
}
@property (weak,nonatomic)id<BroughtHistoryDelegate> BHdelegate;

@end

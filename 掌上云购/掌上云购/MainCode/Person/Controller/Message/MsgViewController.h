//
//  MsgViewController.h
//  掌上云购
//
//  Created by 刘毅 on 16/9/14.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import "BaseViewController.h"

@interface MsgViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,assign)NSInteger msgType;

@end

//
//  MessageController.m
//  掌上云购
//
//  Created by 刘毅 on 16/9/5.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import "MessageController.h"
#import "MsgViewController.h"

@interface MessageController ()

@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSArray *msgType;


@end

@implementation MessageController
#pragma mark - 导航栏
- (void)initNavBar{
    
    self.navigationItem.backBarButtonItem = nil;
    UIButton *leftButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 12.f, 18.f)];
    leftButton.tag = 101;
    [leftButton setBackgroundImage:[UIImage imageNamed:@"返回.png"]
                          forState:UIControlStateNormal];
    [leftButton addTarget:self
                   action:@selector(NavAction:)
         forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftItem;
    
}

- (void)NavAction:(UIButton *)button{
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"消息中心";
    [self initNavBar];
    
    _msgType = @[@"红包消息",@"揭晓消息",@"其他消息"];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight-64) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.showsVerticalScrollIndicator = NO;
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
}

#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _msgType.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    cell.textLabel.text = _msgType[indexPath.row];
    
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
   // 类型（4：红包消息，2：揭晓消息，3：其他消息）
        MsgViewController *msgVc = [[MsgViewController alloc] init];
    switch (indexPath.row) {
        case 0:
            msgVc.msgType = 4;
            msgVc.title = @"红包消息";
            break;
        case 1:
            msgVc.msgType = 2;
            msgVc.title = @"揭晓消息";
            break;
        case 2:
            msgVc.msgType = 3;
            msgVc.title = @"其他消息";
            break;
            
        default:
            break;
    }
    
        [self.navigationController pushViewController:msgVc animated:YES];
   
}
@end

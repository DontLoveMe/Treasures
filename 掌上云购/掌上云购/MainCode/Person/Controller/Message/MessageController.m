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


@end

@implementation MessageController
#pragma mark - 导航栏
- (void)initNavBar{
    
    self.navigationItem.backBarButtonItem = nil;
    UIButton *leftButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, kNavigationBarItemWidth, kNavigationBarItemHight)];
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
    
    _dataArr = [NSMutableArray array];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight-64) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
//    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.showsVerticalScrollIndicator = NO;
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    
}

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    
    [self requestData];
    
}

#pragma mark - requestData
- (void)requestData{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    NSDictionary *userDic = [[NSUserDefaults standardUserDefaults] objectForKey:@"userDic"];
    if(userDic == nil){
        return;
    }
    NSNumber *userId = userDic[@"id"];
    [params setObject:userId forKey:@"userId"];
    
    NSString *url = [NSString stringWithFormat:@"%@%@",BASE_URL,MessageType_URL];
    [ZSTools post:url
           params:params
          success:^(id json) {
              
              if ([[json objectForKey:@"flag"] boolValue]) {
                  
                  _dataArr = [json objectForKey:@"data"];
                  [_tableView reloadData];
                  
              }
              
          } failure:^(NSError *error) {
              
          }];
    
}

#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    NSDictionary *dic = [_dataArr objectAtIndex:indexPath.row];
    
    cell.textLabel.text = dic[@"title"];
    
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    
    NSInteger haveRead = [[dic objectForKey:@"isHaveRead"] integerValue];
    
    if (haveRead == 0) {
        
        UIImageView *redPoint = [[UIImageView alloc] initWithFrame:CGRectMake(cell.width - 4, 18.f, 4, 4)];
        redPoint.backgroundColor = [UIColor redColor];
        redPoint.layer.cornerRadius = 2.f;
        redPoint.layer.masksToBounds = YES;
        [cell addSubview:redPoint];
        
    }
    NSLogZS(@"%@：%@",[dic objectForKey:@"msgType"],[dic objectForKey:@"title"]);
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
   // 类型（4：红包消息，2：揭晓消息，3：其他消息）
    MsgViewController *msgVc = [[MsgViewController alloc] init];
    NSDictionary *dic = [_dataArr objectAtIndex:indexPath.row];
    msgVc.msgType = [[dic objectForKey:@"msgType"] integerValue];
    NSLogZS(@"%@",[dic objectForKey:@"title"]);
    msgVc.title = [dic objectForKey:@"title"];
    if ([[dic objectForKey:@"msgType"] integerValue] == 3) {
        
        [self readMessageWithID];
    
    }
    [self.navigationController pushViewController:msgVc animated:YES];
   
}

- (void)readMessageWithID{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSDictionary *userDic = [[NSUserDefaults standardUserDefaults] objectForKey:@"userDic"];
    if(userDic == nil){
        return;
    }
    NSNumber *userId = userDic[@"id"];
    [params setObject:userId forKey:@"userId"];
    [params setObject:[NSNumber numberWithInteger:3]
               forKey:@"msgType"];
    NSString *url = [NSString stringWithFormat:@"%@%@",BASE_URL,ReadMessage_URL];
    [ZSTools post:url
           params:params
          success:^(id json) {
              
              NSLogZS(@"%@",[json objectForKey:@"msg"]);
              
          } failure:^(NSError *error) {
              
          }];
    
}

@end

//
//  MessageController.m
//  掌上云购
//
//  Created by 刘毅 on 16/9/5.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import "MessageController.h"
#import "RedEnvelopeController.h"
#import "SnatchRecordController.h"

@interface MessageController ()

@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *msgList;


@end

@implementation MessageController
#pragma mark - 导航栏
- (void)initNavBar{
    
    self.navigationItem.backBarButtonItem = nil;
    UIButton *leftButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 20.f, 25.f)];
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
    self.title = @"消息";
    [self initNavBar];
    
    [self requestMsgData];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight-64) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.showsVerticalScrollIndicator = NO;
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
}

- (void)requestMsgData {
    //取出存储的用户信息
        NSDictionary *userDic = [[NSUserDefaults standardUserDefaults] objectForKey:@"userDic"];
        NSNumber *userId = userDic[@"id"];
    [self showHUD:@"加载中"];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:@{@"userId":userId} forKey:@"paramsMap"];
    
    
    NSString *url = [NSString stringWithFormat:@"%@%@",BASE_URL,MessageList_URL];
    [ZSTools post:url
           params:params
          success:^(id json) {
              
              BOOL isSuccess = [[json objectForKey:@"flag"] boolValue];
              [self hideSuccessHUD:[json objectForKey:@"msg"]];
              if (isSuccess) {
                  
                  self.msgList = json[@"data"];
                  [_tableView reloadData];
              }
              
              
          } failure:^(NSError *error) {
              
              [self hideFailHUD:@"加载失败"];
              NSLogZS(@"%@",error);
          }];

}

#pragma mark - UITableViewDelegate,UITableViewDataSource
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    return 0;
//}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.msgList.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    NSDictionary *msgDic = self.msgList[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:13];
    if (![msgDic[@"content"] isKindOfClass:[NSNull class]]) {
        cell.textLabel.text = msgDic[@"content"];
    }else {
        NSInteger msgType = [msgDic[@"msgType"] integerValue];
        if (msgType == 1) {
             cell.textLabel.text = @"红包消息";
        }else if (msgType == 2) {
            cell.textLabel.text = @"揭晓消息";
        }else {
            cell.textLabel.text = @"其他消息";
        }
        
    }
    
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 30;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *msgDic = self.msgList[indexPath.row];
    NSInteger msgType = [msgDic[@"msgType"] integerValue];
    if (msgType == 1) {
        RedEnvelopeController *rdVc = [[RedEnvelopeController alloc] init];
        [self.navigationController pushViewController:rdVc animated:YES];
    }else if (msgType == 2) {
        
        SnatchRecordController *srVc = [[SnatchRecordController alloc] init];
        [self.navigationController pushViewController:srVc animated:YES];
    }else {
        
    }
}
@end

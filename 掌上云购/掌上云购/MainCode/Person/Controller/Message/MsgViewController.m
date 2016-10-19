//
//  MsgViewController.m
//  掌上云购
//
//  Created by 刘毅 on 16/9/14.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import "MsgViewController.h"
#import "RedEnvelopeController.h"
#import "MessageCell.h"
#import "GoodsDetailController.h"

@interface MsgViewController ()

@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *msgList;

@end

@implementation MsgViewController

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
    [self initNavBar];
    
    [self requestMsgData];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight-64) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.showsVerticalScrollIndicator = NO;
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [_tableView registerNib:[UINib nibWithNibName:@"MessageCell" bundle:nil] forCellReuseIdentifier:@"MessageCell"];
}

- (void)requestMsgData {
    //取出存储的用户信息
    NSDictionary *userDic = [[NSUserDefaults standardUserDefaults] objectForKey:@"userDic"];
    NSNumber *userId = userDic[@"id"];
    [self showHUD:@"加载中"];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setObject:@{@"userId":userId,@"msgType":@(_msgType)} forKey:@"paramsMap"];
    
    
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
    
    MessageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MessageCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if (_msgType == 3) {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    NSDictionary *msgDic = self.msgList[indexPath.row];
    
    if (![msgDic[@"title"] isKindOfClass:[NSNull class]]) {
        cell.titleLabel.text = msgDic[@"title"];
        
    }
    if (![msgDic[@"content"] isKindOfClass:[NSNull class]]) {
        cell.contentLabel.text = msgDic[@"content"];

    }
    if (![msgDic[@"createDate"] isKindOfClass:[NSNull class]]) {
   
        cell.timeLabel.text = msgDic[@"createDate"];
        
    }
    
    NSInteger haveRead = [[msgDic objectForKey:@"isHaveRead"] integerValue];
    
    if (_msgType != 3) {
        
        if (haveRead == 0) {
            
            UIImageView *redPoint = [[UIImageView alloc] initWithFrame:CGRectMake(cell.width - 30, 34.f, 4, 4)];
            redPoint.backgroundColor = [UIColor redColor];
            redPoint.layer.cornerRadius = 2.f;
            redPoint.layer.masksToBounds = YES;
            [cell addSubview:redPoint];
            
        }
        
    }

    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 69;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary *msgDic = self.msgList[indexPath.row];
    NSInteger haveRead = [[msgDic objectForKey:@"isHaveRead"] integerValue];
    
    NSInteger msgType = [msgDic[@"msgType"] integerValue];
    //类型（4：红包消息，2：揭晓消息，3：其他消息）
    if (msgType == 4) {
        
        if (haveRead == 0) {
            
            [self readMessageWithID:[msgDic objectForKey:@"id"]];
        }
        RedEnvelopeController *rdVc = [[RedEnvelopeController alloc] init];
        rdVc.isPay = @"1";
        if (![msgDic[@"businessId"] isEqual:[NSNull null]]) {
            rdVc.businessId = msgDic[@"businessId"];
            [self.navigationController pushViewController:rdVc animated:YES];
        }
    }else if (msgType == 2) {
        
        if (haveRead == 0) {
            
            [self readMessageWithID:[msgDic objectForKey:@"id"]];
        }
        GoodsDetailController *gsVC = [[GoodsDetailController alloc] init];
        if (![msgDic[@"businessId"] isEqual:[NSNull null]]) {
            gsVC.drawId = msgDic[@"businessId"];
            gsVC.isAnnounced = 3;
            [self.navigationController pushViewController:gsVC animated:YES];
        }
        
    }else if (msgType == 3) {
      
        
        
    }
    
}

- (void)readMessageWithID:(NSString *)msgID{

    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSDictionary *userDic = [[NSUserDefaults standardUserDefaults] objectForKey:@"userDic"];
    if(userDic == nil){
        return;
    }
    NSNumber *userId = userDic[@"id"];
    [params setObject:userId forKey:@"userId"];
    [params setObject:msgID forKey:@"id"];
    [params setObject:[NSNumber numberWithInteger:_msgType]
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

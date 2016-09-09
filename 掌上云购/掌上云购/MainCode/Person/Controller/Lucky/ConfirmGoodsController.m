//
//  ConfirmGoodsController.m
//  掌上云购
//
//  Created by 刘毅 on 16/8/20.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import "ConfirmGoodsController.h"
#import "ConfirmGoodsCell_1.h"
#import "ConfirmGoodsCell_2.h"
#import "ConfirmGoodsCell_3.h"

@interface ConfirmGoodsController ()

@property (nonatomic,strong)NSDictionary *orderDic;

@end

@implementation ConfirmGoodsController

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
    
    self.title = @"商品确认";
    [self initNavBar];
    
    [self requestSaleOrderStatus];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    UINib *nib1 = [UINib nibWithNibName:@"ConfirmGoodsCell_1" bundle:nil];
    [_tableView registerNib:nib1 forCellReuseIdentifier:@"ConfirmGoodsCell_1"];
    UINib *nib2 = [UINib nibWithNibName:@"ConfirmGoodsCell_2" bundle:nil];
    [_tableView registerNib:nib2 forCellReuseIdentifier:@"ConfirmGoodsCell_2"];
    UINib *nib3 = [UINib nibWithNibName:@"ConfirmGoodsCell_3" bundle:nil];
    [_tableView registerNib:nib3 forCellReuseIdentifier:@"ConfirmGoodsCell_3"];
}

#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        ConfirmGoodsCell_1 *cell = [tableView dequeueReusableCellWithIdentifier:@"ConfirmGoodsCell_1" forIndexPath:indexPath];

        cell.titleLabel.text = _orderDic[@"productName"];
        cell.participateLabel.text = [NSString stringWithFormat:@"参与人次：%@",_orderDic[@"qty"]];
        
        return cell;
    }
//    ConfirmGoodsCell_2 *cell = [tableView dequeueReusableCellWithIdentifier:@"ConfirmGoodsCell_2" forIndexPath:indexPath];
//    return cell;
    ConfirmGoodsCell_3 *cell = [tableView dequeueReusableCellWithIdentifier:@"ConfirmGoodsCell_3" forIndexPath:indexPath];
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 121;
    }
//    return 275;
    return 293;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 15;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}
- (IBAction)againPartake:(UIButton *)sender {
    
}

- (void)requestSaleOrderStatus {
    //取出存储的用户信息
    //    NSDictionary *userDic = [[NSUserDefaults standardUserDefaults] objectForKey:@"userDic"];
    //    NSNumber *userId = userDic[@"id"];
    [self showHUD:@"加载中"];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:@(_rcModel.orderDetailId) forKey:@"id"];
    
    
    NSString *url = [NSString stringWithFormat:@"%@%@",BASE_URL,SaleOrderStatus_URL];
    [ZSTools post:url
           params:params
          success:^(id json) {
              
              BOOL isSuccess = [[json objectForKey:@"flag"] boolValue];
              [self hideSuccessHUD:[json objectForKey:@"msg"]];
              if (isSuccess) {
                 
                  _orderDic = json[@"data"];
                  [_tableView reloadData];
              }
              
              
          } failure:^(NSError *error) {
              
              [self hideFailHUD:@"加载失败"];
              NSLogZS(@"%@",error);
          }];
}

@end

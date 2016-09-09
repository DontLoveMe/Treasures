//
//  ConfirmGoodsController.m
//  掌上云购
//
//  Created by 刘毅 on 16/8/20.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import "ConfirmGoodsController.h"

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
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSArray *pArr = _rcModel.proPictureList;
        if (pArr.count>0) {
            Propicturelist *prtLs = pArr[0];
            NSURL *url = [NSURL URLWithString:prtLs.img650];
            [cell.titleView setImageWithURL:url placeholderImage:[UIImage imageNamed:@"揭晓-图片.jpg"]];
        }
        cell.titleLabel.text = _rcModel.name;
        cell.participateLabel.text = [NSString stringWithFormat:@"参与人次：%ld",_rcModel.partakeCount];
         NSInteger status = [_orderDic[@"status"] integerValue];
        switch (status) {
            case 5:
                cell.stateLabel.text = @"请选择方式";
                break;
            case 6:
                cell.stateLabel.text = @"已选择方式";
                break;
            case 7:
                cell.stateLabel.text = @"已发卡密或充值到余额";
                break;
                
            default:
                break;
        }
        
        
        return cell;
    }
    NSInteger status = [_orderDic[@"status"] integerValue];
    if (status == 0 ||status == 5) {
        ConfirmGoodsCell_2 *cell = [tableView dequeueReusableCellWithIdentifier:@"ConfirmGoodsCell_2" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
        cell.stateView1.highlighted = YES;
        cell.stateView2.highlighted = YES;
        return cell;
    }

    ConfirmGoodsCell_3 *cell = [tableView dequeueReusableCellWithIdentifier:@"ConfirmGoodsCell_3" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
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
- (void)clickButtonBackTag:(NSInteger)tag {
    switch (tag) {
        case 100:
            
            break;
        case 101:
            
            break;
        case 102:
            
            break;
        case 103:
            [self rechargeBalance];
            break;
            
        default:
            break;
    }
}
#pragma mark - 数据请求
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

//确定收货
- (void)confirmGoods {
    // 取出存储的用户信息
    //    NSDictionary *userDic = [[NSUserDefaults standardUserDefaults] objectForKey:@"userDic"];
    //    NSNumber *userId = userDic[@"id"];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    //    [params setObject:userId forKey:@"buyUserId"];
    [params setObject:@(_rcModel.orderDetailId) forKey:@"id"];
    
    NSString *url = [NSString stringWithFormat:@"%@%@",BASE_URL,ConfirmGoods_URL];
    [ZSTools post:url
           params:params
          success:^(id json) {
              
              BOOL isSuccess = [[json objectForKey:@"flag"] boolValue];
              NSLogZS(@"%@",json[@"msg"]);
              if (isSuccess) {
                  NSLogZS(@"确定商品");
                  
                  [self requestSaleOrderStatus];
              }
              
              
          } failure:^(NSError *error) {
              
              
              NSLogZS(@"%@",error);
          }];
}
//已发卡密或充值到余额
- (void)rechargeBalance {
    // 取出存储的用户信息
        NSDictionary *userDic = [[NSUserDefaults standardUserDefaults] objectForKey:@"userDic"];
        NSNumber *userId = userDic[@"id"];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setObject:userId forKey:@"buyUserId"];
    [params setObject:@(_rcModel.orderDetailId) forKey:@"id"];
    
    NSString *url = [NSString stringWithFormat:@"%@%@",BASE_URL,RechargeBalance_URL];
    [ZSTools post:url
           params:params
          success:^(id json) {
              
              BOOL isSuccess = [[json objectForKey:@"flag"] boolValue];
              NSLogZS(@"%@",json[@"msg"]);
              if (isSuccess) {
                  NSLogZS(@"已发卡密或充值到余额");
                  
                  [self requestSaleOrderStatus];
              }
              
              
          } failure:^(NSError *error) {
              
              
              NSLogZS(@"%@",error);
          }];
}


@end

//
//  ConfirmDataController.m
//  掌上云购
//
//  Created by 刘毅 on 16/8/19.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import "ConfirmDataController.h"
#import "LuckyRecordCell.h"
#import "AddShareController.h"
#import "AlertController.h"
#import "AddressViewController.h"
//#import "GoodsStateCell.h"

@interface ConfirmDataController ()

@end

@implementation ConfirmDataController {
    
    UITableView *_tableView;
    NSString *_identify;
    NSString *_identify1;
    NSArray *_sectionArr;
    NSString *_defaultArea;
    NSDictionary *_orderDic;
}

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
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self requestAreaData];
    [self requestSaleOrderStatus];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"信息确认";
    [self initNavBar];
    
    if (_state == 0) {
        _sectionArr = @[@"  商品状态",@"  商品信息"];
    }else {
        _sectionArr = @[@"  商品状态",@"  物流信息",@"  地址信息",@"  商品信息"];
        
    }
    
//    [self requestAreaData];
    
//    [self requestSaleOrderStatus];
    
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight-64) style:UITableViewStyleGrouped];
    [self.view addSubview:_tableView];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    _identify = @"LuckyRecordCell";
    UINib *nib = [UINib nibWithNibName:@"LuckyRecordCell" bundle:nil];
    [_tableView registerNib:nib forCellReuseIdentifier:_identify];
    _identify1 = @"GoodsStateCell";
    UINib *nib1 = [UINib nibWithNibName:@"GoodsStateCell" bundle:nil];
    [_tableView registerNib:nib1 forCellReuseIdentifier:_identify1];
    
    //下拉时动画
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        
        [self requestSaleOrderStatus];
        
    }];
    //下拉时图片
    NSMutableArray *gifWhenPullDown = [NSMutableArray array];
    for (NSInteger i = 1 ; i <= 30; i++) {
        
        if (i / 100 > 0) {
            [gifWhenPullDown addObject:[UIImage imageNamed:[NSString stringWithFormat:@"dropdown_zsyg_%ld",i]]];
        }else if (i / 10){
            [gifWhenPullDown addObject:[UIImage imageNamed:[NSString stringWithFormat:@"dropdown_zsyg_0%ld",i]]];
        }else{
            [gifWhenPullDown addObject:[UIImage imageNamed:[NSString stringWithFormat:@"dropdown_zsyg_00%ld",i]]];
        }
        
    }
    
    [header setImages:gifWhenPullDown
             duration:1 forState:MJRefreshStatePulling];
    
    //正在刷新时图片
    NSMutableArray *gifWhenRefresh = [NSMutableArray array];
    for (NSInteger i = 31 ; i <= 112; i++) {
        
        if (i / 100 > 0) {
            [gifWhenRefresh addObject:[UIImage imageNamed:[NSString stringWithFormat:@"dropdown_zsyg_%ld",i]]];
        }else if (i / 10){
            [gifWhenRefresh addObject:[UIImage imageNamed:[NSString stringWithFormat:@"dropdown_zsyg_0%ld",i]]];
        }else{
            [gifWhenRefresh addObject:[UIImage imageNamed:[NSString stringWithFormat:@"dropdown_zsyg_00%ld",i]]];
        }
        
    }
    
    [header setImages:gifWhenRefresh
             duration:2 forState:MJRefreshStateRefreshing];
    
    header.lastUpdatedTimeLabel.hidden = YES;
    header.stateLabel.hidden = NO;
    header.stateLabel.textColor = [UIColor colorFromHexRGB:ThemeColor];
    [header setTitle:@"下拉刷新。" forState:MJRefreshStateIdle];
    [header setTitle:@"松手即可刷新" forState:MJRefreshStatePulling];
    [header setTitle:@"正在刷新..." forState:MJRefreshStateRefreshing];
    _tableView.mj_header = header;
}

#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _sectionArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        GoodsStateCell *cell = [tableView dequeueReusableCellWithIdentifier:_identify1 forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
        cell.sureAddress.hidden = YES;
        cell.selectAddress.hidden = YES;
        cell.delayReceipt.hidden = YES;
        cell.sureReceipt.hidden = YES;
        //"0",//订单状态，0：已支付1：已确认收货地址2：已发货3：已签收4：已晒单5：已确认物品6：已选择方式7：已发卡密或充值到余额（虚拟商品）8：未确认地址取消订单',

        if (_state == 0) {
            
            cell.stateView1.highlighted = YES;
            cell.stateView2.highlighted = YES;
            cell.stateView3.highlighted = NO;
            cell.stateView4.highlighted = NO;
            cell.stateView5.highlighted = NO;
            
            cell.stateLabel1.highlighted = YES;
            cell.stateLabel2.highlighted = YES;
            
//            cell.stateLabel2.text = @"确认收货地址\nxxxxxxxxxxxxx地址明细";
            cell.stateLabel2.text = [NSString stringWithFormat:@"确认收货地址\n%@",_defaultArea];
            cell.timeLabel1.highlighted = YES;
            cell.timeLabel2.highlighted = YES;
            
            cell.timeLabel1.text = @"";
            cell.timeLabel2.text = @"";
            cell.timeLabel3.text = @"";
            cell.timeLabel4.text = @"";
            cell.shareBtn.hidden = YES;
            
            cell.sureAddress.hidden = NO;
            cell.selectAddress.hidden = NO;
            cell.delayReceipt.hidden = YES;
            cell.sureReceipt.hidden = YES;
        }else if(_state == 1){
            
            cell.stateView1.highlighted = YES;
            cell.stateView2.highlighted = YES;
            cell.stateView3.highlighted = NO;
            cell.stateView4.highlighted = NO;
            cell.stateView5.highlighted = NO;
            
            cell.stateLabel1.highlighted = YES;
            cell.stateLabel2.highlighted = YES;
            cell.stateLabel3.highlighted = NO;
            cell.stateLabel4.highlighted = NO;
            
            cell.timeLabel1.highlighted = YES;
            cell.timeLabel2.highlighted = YES;
            cell.timeLabel3.highlighted = NO;
            cell.timeLabel4.highlighted = NO;
            cell.timeLabel4.text = @"";
            
            cell.stateLabel2.text = [NSString stringWithFormat:@"确认收货地址"];
            if (![_orderDic[@"drawDate"] isKindOfClass:[NSNull class]]) {
                cell.timeLabel1.text = [TimeFormat getNewTimeString:_orderDic[@"drawDate"]];
            }
            if (![_orderDic[@"confirmGoodsAddressDate"] isKindOfClass:[NSNull class]]) {
                cell.timeLabel2.text = [TimeFormat getNewTimeString:_orderDic[@"confirmGoodsAddressDate"]];
            }
            cell.timeLabel3.text = @"";
            cell.timeLabel4.text = @"";
            
            cell.shareBtn.hidden = YES;
            cell.sureAddress.hidden = YES;
            cell.selectAddress.hidden = YES;
            cell.delayReceipt.hidden = YES;
            cell.sureReceipt.hidden = YES;
           
        }else if (_state == 2){
            
            cell.stateView1.highlighted = YES;
            cell.stateView2.highlighted = YES;
            cell.stateView3.highlighted = YES;
            cell.stateView4.highlighted = YES;
            cell.stateView5.highlighted = NO;
            
            cell.stateLabel1.highlighted = YES;
            cell.stateLabel2.highlighted = YES;
            cell.stateLabel3.highlighted = YES;
            cell.stateLabel4.highlighted = YES;
            cell.stateLabel5.highlighted = NO;
            
            cell.stateLabel2.text = [NSString stringWithFormat:@"确认收货地址"];
            cell.stateLabel4.text = [NSString stringWithFormat:@"未确认收货"];
            cell.stateLabel5.text = [NSString stringWithFormat:@"未签收"];
            
            cell.timeLabel1.highlighted = YES;
            cell.timeLabel2.highlighted = YES;
            cell.timeLabel3.highlighted = YES;
            cell.timeLabel4.highlighted = YES;
    
            
            if (![_orderDic[@"drawDate"] isKindOfClass:[NSNull class]]) {
                cell.timeLabel1.text = [TimeFormat getNewTimeString:_orderDic[@"drawDate"]];
            }
            if (![_orderDic[@"confirmGoodsAddressDate"] isKindOfClass:[NSNull class]]) {
                cell.timeLabel2.text = [TimeFormat getNewTimeString: _orderDic[@"confirmGoodsAddressDate"]];
            }
            if (![_orderDic[@"deliverDate"] isKindOfClass:[NSNull class]]) {
                cell.timeLabel3.text = [TimeFormat getNewTimeString:_orderDic[@"deliverDate"]];
            }
            cell.timeLabel4.text = @"";
            
            cell.shareBtn.hidden = YES;
            cell.sureAddress.hidden = YES;
            cell.selectAddress.hidden = YES;
//            cell.delayReceipt.hidden = NO;
            cell.sureReceipt.hidden = NO;
            
            if (![_orderDic[@"isDelayReceive"] isKindOfClass:[NSNull class]]) {
                if ([_orderDic[@"isDelayReceive"] integerValue]==0) {
                    cell.delayReceipt.hidden = NO;
                }else {
                    cell.delayReceipt.hidden = YES;
                }
            }else {
                cell.delayReceipt.hidden = NO;
            }
            
            
                
            }
        else if (_state == 3) {
            
            cell.stateView1.highlighted = YES;
            cell.stateView2.highlighted = YES;
            cell.stateView3.highlighted = YES;
            cell.stateView4.highlighted = YES;
            cell.stateView5.highlighted = YES;
            
            cell.stateLabel1.highlighted = YES;
            cell.stateLabel2.highlighted = YES;
            cell.stateLabel3.highlighted = YES;
            cell.stateLabel4.highlighted = YES;
            cell.stateLabel5.highlighted = YES;
            
            cell.stateLabel2.text = [NSString stringWithFormat:@"确认收货地址"];
            
            cell.stateLabel4.text = [NSString stringWithFormat:@"已签收"];
            cell.stateLabel5.text = [NSString stringWithFormat:@"未晒单"];
            
            cell.timeLabel1.highlighted = YES;
            cell.timeLabel2.highlighted = YES;
            cell.timeLabel3.highlighted = YES;
            cell.timeLabel4.highlighted = YES;
            
            
            cell.shareBtn.hidden = NO;
            cell.delayReceipt.hidden = YES;
            cell.sureReceipt.hidden = YES;
            cell.stateView5.highlighted = YES;
            cell.stateLabel5.highlighted = YES;
            if (![_orderDic[@"drawDate"] isKindOfClass:[NSNull class]]) {
                cell.timeLabel1.text = [TimeFormat getNewTimeString: _orderDic[@"drawDate"]];
            }
            if (![_orderDic[@"confirmGoodsAddressDate"] isKindOfClass:[NSNull class]]) {
                cell.timeLabel2.text = [TimeFormat getNewTimeString:_orderDic[@"confirmGoodsAddressDate"]];
            }
            if (![_orderDic[@"deliverDate"] isKindOfClass:[NSNull class]]) {
                cell.timeLabel3.text = [TimeFormat getNewTimeString:_orderDic[@"deliverDate"]];
            }
            if (![_orderDic[@"confirmGoodsReceiptDate"] isKindOfClass:[NSNull class]]) {
                cell.timeLabel4.text = [TimeFormat getNewTimeString: _orderDic[@"confirmGoodsReceiptDate"]];
            }
        }else {
            
            cell.stateView1.highlighted = YES;
            cell.stateView2.highlighted = YES;
            cell.stateView3.highlighted = YES;
            cell.stateView4.highlighted = YES;
            cell.stateView5.highlighted = YES;
            
            cell.stateLabel1.highlighted = YES;
            cell.stateLabel2.highlighted = YES;
            cell.stateLabel3.highlighted = YES;
            cell.stateLabel4.highlighted = YES;
            cell.stateLabel5.highlighted = YES;
            
            cell.stateLabel2.text = [NSString stringWithFormat:@"确认收货地址"];
            
            cell.stateLabel4.text = [NSString stringWithFormat:@"已签收"];
            cell.stateLabel5.text = [NSString stringWithFormat:@"已晒单"];
            
            cell.timeLabel1.highlighted = YES;
            cell.timeLabel2.highlighted = YES;
            cell.timeLabel3.highlighted = YES;
            cell.timeLabel4.highlighted = YES;
            
            cell.shareBtn.hidden = YES;
            cell.delayReceipt.hidden = YES;
            cell.sureReceipt.hidden = YES;
            cell.stateView5.highlighted = YES;
            cell.stateLabel5.highlighted = YES;
            if (![_orderDic[@"drawDate"] isKindOfClass:[NSNull class]]) {
                cell.timeLabel1.text = [TimeFormat getNewTimeString:_orderDic[@"drawDate"]];
            }
            if (![_orderDic[@"confirmGoodsAddressDate"] isKindOfClass:[NSNull class]]) {
                cell.timeLabel2.text = [TimeFormat getNewTimeString:_orderDic[@"confirmGoodsAddressDate"]];
            }
            if (![_orderDic[@"deliverDate"] isKindOfClass:[NSNull class]]) {
                cell.timeLabel3.text = [TimeFormat getNewTimeString:_orderDic[@"deliverDate"]];
            }
            if (![_orderDic[@"confirmGoodsReceiptDate"] isKindOfClass:[NSNull class]]) {
                cell.timeLabel4.text = [TimeFormat getNewTimeString:_orderDic[@"confirmGoodsReceiptDate"]];
            }
        }
    
        return cell;

    }
    if (_sectionArr.count==3) {
        
        if (indexPath.section == 1)
        {
            UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"CellStyleSubtitle"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.textLabel.font = [UIFont systemFontOfSize:13];
            cell.detailTextLabel.font = [UIFont systemFontOfSize:12];
            cell.detailTextLabel.numberOfLines = 2;

           
                if (![_orderDic[@"consigneeName"] isKindOfClass:[NSNull class]]) {
                    cell.textLabel.text = [NSString stringWithFormat:@"姓名：%@  联系方式（%@)",_orderDic[@"consigneeName"],_orderDic[@"mobile"]];
                }
                if (![_orderDic[@"addressDetailFull"] isKindOfClass:[NSNull class]]) {
                    
                    cell.detailTextLabel.text = [NSString stringWithFormat:@"\n快递地址：%@",_orderDic[@"addressDetailFull"]];
                }
            
            return cell;
        }
    }else if (_sectionArr.count==4){
        if (indexPath.section == 1||indexPath.section == 2) {
            UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"CellStyleSubtitle"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.textLabel.font = [UIFont systemFontOfSize:13];
            cell.detailTextLabel.font = [UIFont systemFontOfSize:12];
            cell.detailTextLabel.numberOfLines = 2;
            
            if (indexPath.section == 1) {
                if (![_orderDic[@"invoiceCompany"] isKindOfClass:[NSNull class]]) {
                    cell.textLabel.text = [NSString stringWithFormat:@"物流公司：%@",_orderDic[@"invoiceCompany"]];
                }
                if (![_orderDic[@"invoiceCode"] isKindOfClass:[NSNull class]]) {
                    
                    cell.detailTextLabel.text = [NSString stringWithFormat:@"\n快递单号：%@",_orderDic[@"invoiceCode"]];
                }
            }else {
                if (![_orderDic[@"consigneeName"] isKindOfClass:[NSNull class]]) {
                    cell.textLabel.text = [NSString stringWithFormat:@"姓名：%@  联系方式（%@)",_orderDic[@"consigneeName"],_orderDic[@"mobile"]];
                }
                if (![_orderDic[@"addressDetailFull"] isKindOfClass:[NSNull class]]) {
                    
                    cell.detailTextLabel.text = [NSString stringWithFormat:@"\n快递地址：%@",_orderDic[@"addressDetailFull"]];
                }
            }
            return cell;
        }

    }
    
    LuckyRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:_identify forIndexPath:indexPath];
    cell.goodsButton.hidden = YES;
    cell.lkModel = _rcModel;
    cell.isSunBtn.hidden = YES;
    cell.contentView.backgroundColor = [UIColor colorFromHexRGB:@"EBEBF1"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        return 180;
    }
    if (indexPath.section == _sectionArr.count-1) {
        return 160;
    }
    return 80;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = [UIColor whiteColor];
    label.textColor = [UIColor blackColor];
    label.font = [UIFont systemFontOfSize:16];
    label.text = _sectionArr[section];
    
    return label;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 30;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}
//tag值：0确认地址2延期收货3确认收货4立即晒单
- (void)clickButtonBackTag:(NSInteger)tag {
    if (tag == 0) {
        [self confirmAddress];
    }else if (tag == 2){
        
        [self deferredReceipt];
        
    }else if (tag == 3) {
        [self confirmReceipt];
    }else if (tag == 4) {
        AddShareController *addSVC = [[AddShareController alloc] init];
        addSVC.lkModel = _rcModel;
        [self.navigationController pushViewController:addSVC animated:YES];
    }
}
#pragma mark - 数据请求
//确认地址
- (void)confirmAddress{
    if (_defaultArea.length == 0||[_defaultArea isEqualToString:@"没有默认地址"]) {
        AlertController *alert = [[AlertController alloc] initWithTitle:@"温馨提示!" message:@"请选择默认地址?没有请添加"];
        [alert addButtonTitleArray:@[@"取消",@"选择/添加"]];
        __weak typeof(AlertController*) weakAlert = alert;
        __weak typeof(self) weakSelf = self;
        [alert setClickButtonBlock:^(NSInteger tag) {
            if (tag == 0) {//取消
                [weakAlert dismissViewControllerAnimated:YES completion:nil];
            }else {//选择
                [weakAlert dismissViewControllerAnimated:YES completion:nil];
                AddressViewController *avc = [[AddressViewController alloc] init];
                [weakSelf.navigationController pushViewController:avc animated:YES];

            }
        }];
        [self presentViewController:alert
                                            animated:YES
                                          completion:nil];
        return;
    }
   // 取出存储的用户信息
    NSDictionary *userDic = [[NSUserDefaults standardUserDefaults] objectForKey:@"userDic"];
    NSNumber *userId = userDic[@"id"];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:userId forKey:@"buyUserId"];
    [params setObject:@(_rcModel.orderDetailId) forKey:@"id"];
    
    NSString *url = [NSString stringWithFormat:@"%@%@",BASE_URL,ConfirmAddress_URL];
    [ZSTools post:url
           params:params
          success:^(id json) {
              
              BOOL isSuccess = [[json objectForKey:@"flag"] boolValue];
              NSLogZS(@"%@",json[@"msg"]);
              if (isSuccess) {
                  NSLogZS(@"确认地址");

                  [self requestSaleOrderStatus];
              }
              
              
          } failure:^(NSError *error) {
              
              
              NSLogZS(@"%@",error);
          }];
}
//请求地址信息 
- (void)requestAreaData {
    //取出存储的用户信息
    NSDictionary *userDic = [[NSUserDefaults standardUserDefaults] objectForKey:@"userDic"];
    NSNumber *userId = userDic[@"id"];
//    [self showHUD:@"加载中"];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:userId forKey:@"userId"];
    
    
    NSString *url = [NSString stringWithFormat:@"%@%@",BASE_URL,AreaList_URL];
    [ZSTools post:url
           params:params
          success:^(id json) {
              
              BOOL isSuccess = [[json objectForKey:@"flag"] boolValue];
//              [self hideSuccessHUD:[json objectForKey:@"msg"]];
              if (isSuccess) {
                  NSArray *area = json[@"data"];
                  if (area.count == 0) {
                      
                      _defaultArea = @"没有默认地址";
                      
                      AlertController *alert = [[AlertController alloc] initWithTitle:@"温馨提示!" message:@"请添加地址！"];
                      [alert addButtonTitleArray:@[@"取消",@"添加"]];
                      __weak typeof(AlertController*) weakAlert = alert;
                      __weak typeof(self) weakSelf = self;
                      [alert setClickButtonBlock:^(NSInteger tag) {
                          if (tag == 0) {//取消
                              [weakAlert dismissViewControllerAnimated:YES completion:nil];
                          }else {//选择
                              [weakAlert dismissViewControllerAnimated:YES completion:nil];
                              AddressViewController *avc = [[AddressViewController alloc] init];
                              [weakSelf.navigationController pushViewController:avc animated:YES];
                              
                          }
                      }];
                      return;
                  }
                  for (NSDictionary *dic in area) {
                      if([dic[@"isDefault"] boolValue]) {
                          if ([dic[@"city"][@"name"]isEqualToString:dic[@"area"][@"name"]]) {
                              _defaultArea = [NSString stringWithFormat:@"%@%@%@",dic[@"province"][@"name"],dic[@"city"][@"name"],dic[@"addressDetail"]];
                          }else{
                              _defaultArea = [NSString stringWithFormat:@"%@%@%@%@",dic[@"province"][@"name"],dic[@"city"][@"name"],dic[@"area"][@"name"],dic[@"addressDetail"]];
                          }
                          
                          [_tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
                      }
                  }
                  
              }
              
              
          } failure:^(NSError *error) {
              
              [self hideFailHUD:@"加载失败"];
              NSLogZS(@"%@",error);
          }];
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
              [self hideSuccessHUD:@"加载成功"];
              [_tableView.mj_header endRefreshing];
              if (isSuccess) {
                  _orderDic = json[@"data"];
                  
                  NSInteger status = [_orderDic[@"status"] integerValue];
                  _state = status;
                  if (status == 0) {
                      
                      _sectionArr = @[@"  商品状态",@"  商品信息"];
                  }else if (status == 1){
                      
                      _sectionArr = @[@"  商品状态",@"  地址信息",@"  商品信息"];
                  }else {
                      _sectionArr = @[@"  商品状态",@"  物流信息",@"  地址信息",@"  商品信息"];
                  }
                  
                  
                 [_tableView reloadData];
              }
              
              
          } failure:^(NSError *error) {
              
              [self hideFailHUD:@"加载失败"];
              NSLogZS(@"%@",error);
          }];
}
//确定收货
- (void)confirmReceipt {
    // 取出存储的用户信息
//    NSDictionary *userDic = [[NSUserDefaults standardUserDefaults] objectForKey:@"userDic"];
//    NSNumber *userId = userDic[@"id"];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    [params setObject:userId forKey:@"buyUserId"];
    [params setObject:@(_rcModel.orderDetailId) forKey:@"id"];
    
    NSString *url = [NSString stringWithFormat:@"%@%@",BASE_URL,ConfirmReceipt_URL];
    [ZSTools post:url
           params:params
          success:^(id json) {
              
              BOOL isSuccess = [[json objectForKey:@"flag"] boolValue];
              NSLogZS(@"%@",json[@"msg"]);
              if (isSuccess) {
                  NSLogZS(@"确定收货");
                  
                  [self requestSaleOrderStatus];
              }
              
              
          } failure:^(NSError *error) {
              
              
              NSLogZS(@"%@",error);
          }];
}
//延期收货
-(void)deferredReceipt {
    // 取出存储的用户信息
    //    NSDictionary *userDic = [[NSUserDefaults standardUserDefaults] objectForKey:@"userDic"];
    //    NSNumber *userId = userDic[@"id"];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    //    [params setObject:userId forKey:@"buyUserId"];
    [params setObject:@(_rcModel.orderDetailId) forKey:@"id"];
    
    NSString *url = [NSString stringWithFormat:@"%@%@",BASE_URL,DeferredReceipt_URL];
    [ZSTools post:url
           params:params
          success:^(id json) {
              
              BOOL isSuccess = [[json objectForKey:@"flag"] boolValue];
              NSLogZS(@"%@",json[@"msg"]);
              if (isSuccess) {
                  NSLogZS(@"延期收货");
                  
                  [self requestSaleOrderStatus];
              }
              
              
          } failure:^(NSError *error) {
              
              
              NSLogZS(@"%@",error);
          }];
}

@end

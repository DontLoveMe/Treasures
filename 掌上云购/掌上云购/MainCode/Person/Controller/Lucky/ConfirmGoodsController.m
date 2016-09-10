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
@property (nonatomic,copy)NSString *userName;
@property (nonatomic,assign)NSInteger mannerType;
//2：手机充值，3：余额，4：支付宝
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
    
    _mannerType = 2;
//    [self confirmGoods];
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
        cell.participateLabel.text = [NSString stringWithFormat:@"参与人次：%ld",_rcModel.saleDraw.sellShare];
         NSInteger status = [_orderDic[@"status"] integerValue];
        switch (status) {
            case 5:
                cell.stateLabel.text = @"请选择方式";
                break;
            case 6:
                cell.stateLabel.text = @"已发卡密或充值到余额";
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
        
        if (![_orderDic[@"drawDate"] isKindOfClass:[NSNull class]]) {
            
            cell.timeLabel1.text = _orderDic[@"drawDate"];
        }else {
            cell.timeLabel1.text = @"";
        }
        return cell;
    }

    ConfirmGoodsCell_3 *cell = [tableView dequeueReusableCellWithIdentifier:@"ConfirmGoodsCell_3" forIndexPath:indexPath];
    if (![_orderDic[@"drawDate"] isKindOfClass:[NSNull class]]) {
        
        cell.timeLabel1.text = _orderDic[@"drawDate"];
    }else {
        cell.timeLabel1.text = @"";
    }
    if (![_orderDic[@"confirmGoodsAddressDate"] isKindOfClass:[NSNull class]]) {
        
        cell.timeLabel2.text = _orderDic[@"confirmGoodsAddressDate"];
    }else {
        cell.timeLabel2.text = @"";
    }
    if (![_orderDic[@"confirmGoodsReceiptDate"] isKindOfClass:[NSNull class]]) {
        
        cell.timeLabel3.text = _orderDic[@"confirmGoodsReceiptDate"];
    }else {
        cell.timeLabel3.text = @"";
    }
    if (![_orderDic[@"receiptAccount"] isKindOfClass:[NSNull class]]) {
        
        cell.cardNoLabel.text = _orderDic[@"receiptAccount"];
    }else {
        cell.cardNoLabel.text = @"";
    }
    NSInteger type = [_orderDic[@"receivingType"] integerValue];
    if (type == 2) {
        cell.mannerLabel.text = @"已选择：充值到话费";
        cell.stateLabel3.text = @"已充值到话费";
        
    }else if (type == 3) {
        cell.mannerLabel.text = @"已选择：充值到余额";
        cell.stateLabel3.text = @"已充值到余额";
    }else if (type == 4){
        cell.mannerLabel.text = @"已选择：充值到支付宝";
        cell.stateLabel3.text = @"已充值到支付宝";
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 121;
    }
//    return 275;
    NSInteger status = [_orderDic[@"status"] integerValue];
    if (status == 5||status == 0) {
        return 365;
    }
    return 263;
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
#pragma mark - confirmGoodsDelegate
- (void)clickButtonBackTag:(NSInteger)tag {
    switch (tag) {
        case 100://话费
            _mannerType = 2;
            break;
        case 101://余额
            _mannerType = 3;
            break;
        case 102://支付宝
            _mannerType = 4;
            break;
        case 103://同意
            
            break;
        case 104://确定
            [self rechargeBalance];
            break;
            
        default:
            break;
    }
}

- (void)getUserName:(NSString *)userName {
    _userName = userName;
    NSLog(@"%@",userName);
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
                  if ([_orderDic[@"status"] integerValue]==0) {
                      [self confirmGoods];
                  }
              }
              
              
          } failure:^(NSError *error) {
              
              [self hideFailHUD:@"加载失败"];
              NSLogZS(@"%@",error);
          }];
}

//确定收货
- (void)confirmGoods {
    // 取出存储的用户信息
        NSDictionary *userDic = [[NSUserDefaults standardUserDefaults] objectForKey:@"userDic"];
        NSNumber *userId = userDic[@"id"];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setObject:userId forKey:@"buyUserId"];
    [params setObject:@(_rcModel.orderDetailId) forKey:@"id"];
    
    NSString *url = [NSString stringWithFormat:@"%@%@",BASE_URL,ConfirmGoods_URL];
    [ZSTools post:url
           params:params
          success:^(id json) {
              
              BOOL isSuccess = [[json objectForKey:@"flag"] boolValue];
              NSLogZS(@"%@",json[@"msg"]);
              if (isSuccess) {
                  NSLogZS(@"确定商品");
                  
//                  [self requestSaleOrderStatus];
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
    [params setObject:@(_mannerType) forKey:@"receivingType"];
    [params setObject:_userName forKey:@"buyUserId"];
    
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
#pragma mark - 监听键盘事件
- (void)viewWillAppear:(BOOL)animated{

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHidden:) name:UIKeyboardWillHideNotification object:nil];

}
- (void)viewDidDisappear:(BOOL)animated{

    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];

}

- (void)keyboardWasShown:(NSNotification*)aNotification{

    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;

    
    CGRect rect1 = self.view.frame;
    rect1.origin.y = -kbSize.height+64;
    self.view.frame = rect1;
 
}

- (void)keyboardWillBeHidden:(NSNotification*)aNotification{

    CGRect rect1 = self.view.frame;
    rect1.origin.y = 64;
    self.view.frame = rect1;

}


@end

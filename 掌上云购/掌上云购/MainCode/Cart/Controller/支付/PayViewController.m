//
//  PayViewController.m
//  掌上云购
//
//  Created by 杨浩斌 on 16/8/16.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import "PayViewController.h"
#import "PayFirstKindCell.h"
#import "PayTwoKindCell.h"
#import "PayThreeKindCell.h"
#import "UIView+SDAutoLayout.h"


@interface PayViewController ()<UITableViewDataSource,UITableViewDelegate>

//商品总数
@property(nonatomic,strong)UILabel *goodstotal;

//商品总价格
@property(nonatomic,strong)UILabel *pricetotal;

//商品总钱数
@property(nonatomic,strong)UILabel *pricesum;

//警示语
@property(nonatomic,strong)UILabel *warntext;

//结算按钮
@property(nonatomic,strong)UIButton *settlebtn;

@end

@implementation PayViewController{

    UITableView *_tab;
    
//    NSMutableArray *_dataArray;

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
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    _redEnveloperReduceCount = 0;
    _redEnveloperID = @"";
    _thirdPayState = @[@"0",@"0"];
    
    self.title = @"支付";
    [self initNavBar];
    
    //创建列表
    [self creatTableView];
    
    //创建底部View;
    [self creatView];
    
}

-(void)creatView{
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, KScreenHeight-125, KScreenWidth, 125)];
    
    view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:view];
    
    //商品总数
    _goodstotal = [[UILabel alloc]init];
    _goodstotal.text = @"共 0 件商品,";
    _goodstotal.textColor = [UIColor grayColor];
    _goodstotal.font = [UIFont systemFontOfSize:15];
    [view addSubview:_goodstotal];
    _goodstotal.sd_layout
    .leftSpaceToView(view,5)
    .topSpaceToView(view,5)
    .widthIs(90)
    .heightIs(20);
    
    //商品总钱数
    _pricesum = [[UILabel alloc]init];
    _pricesum.textColor = [UIColor redColor];
    _pricesum.text = @"0元";
    _pricesum.font = [UIFont systemFontOfSize:15];
    [view addSubview:_pricesum];
    _pricesum.sd_layout
    .leftSpaceToView(_goodstotal,3)
    .topEqualToView(_goodstotal)
    .widthIs(100)
    .heightIs(20);
    
    _warntext = [[UILabel alloc]init];
    _warntext.text = @"夺宝有风险,参与需谨慎";
    _warntext.textColor = [UIColor grayColor];
    _warntext.font = [UIFont systemFontOfSize:15];
    [view addSubview:_warntext];
    _warntext.sd_layout
    .leftEqualToView(_goodstotal)
    .topSpaceToView(_goodstotal,10)
    .widthIs(200)
    .heightIs(20);
    
    _settlebtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _settlebtn.layer.masksToBounds = YES;
    _settlebtn.layer.cornerRadius = 5;
    [_settlebtn setBackgroundImage:[UIImage imageNamed:@"按钮背景"] forState:UIControlStateNormal];
    [_settlebtn setTitle:@"提交" forState:UIControlStateNormal];
    [_settlebtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_settlebtn addTarget:self action:@selector(PayClicked:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:_settlebtn];
    
    _settlebtn.sd_layout
    .rightSpaceToView(view,10)
    .topSpaceToView(view,20)
    .widthIs(60)
    .heightIs(30);
    
    [self changeBottomView];

}

- (void)changeBottomView {
    
    NSMutableArray *cartArr = [NSMutableArray array];
    if ([_isimidiately isEqualToString:@"1"]) {
        
        cartArr = [NSMutableArray arrayWithArray:[CartTools getCartList]];
        
    }else{
        
        cartArr = [_immidiatelyArr mutableCopy];
    }
    _goodstotal.text = [NSString stringWithFormat:@"共 %ld 件商品",(unsigned long)cartArr.count];
    NSInteger totalPrice = 0;
    for (int i = 0; i < cartArr.count; i ++) {
        
        NSDictionary *dic = [cartArr objectAtIndex:i];
        NSInteger singlePrice = [[dic objectForKey:@"singlePrice"] integerValue];
        NSInteger num = [[dic objectForKey:@"buyTimes"] integerValue];
        totalPrice = totalPrice + singlePrice * num;
    }
    
    _pricesum.text = [NSString stringWithFormat:@"总计:%ld元",(long)totalPrice];
}

-(void)PayClicked:(UIButton *)btn{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    //用户id
    NSDictionary *userDic = [[NSUserDefaults standardUserDefaults] objectForKey:@"userDic"];
    NSNumber *userId = userDic[@"id"];
    [params setObject:userId forKey:@"buyUserId"];

#warning 这里根据是否选择，余额数量是否够用,是否选择第三方支付，拼写请求参数
    NSMutableArray *cartArr = [NSMutableArray array];
    if ([_isimidiately isEqualToString:@"1"]) {
        
        cartArr = [NSMutableArray arrayWithArray:[CartTools getCartList]];
        
    }else{
        
        cartArr = [_immidiatelyArr mutableCopy];
    }
    
    NSMutableArray  *BuyArr = [NSMutableArray array];
    float totalPrice = 0;
    for (int i = 0; i < cartArr.count; i ++) {
        
        NSDictionary *dic = [cartArr objectAtIndex:i];
        NSInteger singlePrice = [[dic objectForKey:@"singlePrice"] integerValue];
        NSInteger num = [[dic objectForKey:@"buyTimes"] integerValue];
        totalPrice = totalPrice + singlePrice * num;
        
        NSDictionary *buyDic = @{@"productId":[dic objectForKey:@"id"],
                                 @"Qty":[dic objectForKey:@"buyTimes"],
                                 @"buyNum":@"1"};
        [BuyArr addObject:buyDic];
        
    }
    
    //红包id
    if (_redEnveloperID.length != 0) {
        [params setObject:_redEnveloperID forKey:@"redPacketId"];
    }
    //余额支付数量
    totalPrice = totalPrice - _redEnveloperReduceCount;
   
    //购买数量
    [params setObject:BuyArr forKey:@"orderDetailList"];
    
    CGFloat restMoney = [userDic[@"money"] floatValue];

   //余额支付数量
    if (restMoney > totalPrice) {
        
        [params setObject:[NSNumber numberWithInteger:totalPrice] forKey:@"balanceConsume"];
        [params setObject:@"0" forKey:@"payType"];
        [params setObject:@"0"forKey:@"cashConsume"];
        
    }else{
        
        [params setObject:[NSNumber numberWithInteger:restMoney]
                   forKey:@"balanceConsume"];
        
        [params setObject:[NSString stringWithFormat:@"%.0f",totalPrice - restMoney] forKey:@"cashConsume"];
        NSInteger isWX = [_thirdPayState[0] integerValue];
        NSInteger isAP = [_thirdPayState[1] integerValue];
        if (isWX == 1 && isAP == 0) {
            [params setObject:@"2" forKey:@"payType"];
        }else if (isWX == 0 && isAP == 1){
            [params setObject:@"1" forKey:@"payType"];
        }else if (isWX == 1 && isAP == 1){
            
            UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"只能选择一个支付方式"
                                                                      preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"好"
                                                                   style:UIAlertActionStyleCancel
                                                                 handler:^(UIAlertAction * _Nonnull action) {
                                                                  
                                                                       [alertVC dismissViewControllerAnimated:YES
                                                                                                   completion:nil];
                                                                       
                                                                   }];
            [alertVC addAction:cancelAction];
            [self presentViewController:alertVC
                                                    animated:YES
                                                  completion:nil];
            return;
            
        }else if (isWX == 0 && isAP == 0){
        
            UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"请选择一个支付方式"
                                                                      preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"好"
                                                                   style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                                                                       
                                                                       [alertVC dismissViewControllerAnimated:YES
                                                                                                   completion:nil];
                                                                       
                                                                   }];
            [alertVC addAction:cancelAction];
            [self presentViewController:alertVC
                                                    animated:YES
                                                  completion:nil];
            return;
            
        }
        
    }
    
//    支付url
    NSString *url = [NSString stringWithFormat:@"%@%@",BASE_URL,SubmitCartList_URL];
//    NSString *url = @"http://192.168.0.123:8080/pcpi/saleCart/submitPayment";
    [CartTools realaseCartList];
    NSArray *cartListArr = [CartTools getCartList];
    [self getRootController].cartNum = cartListArr.count;
    [self showHUD:@"正在支付"];
    [ZSTools post:url
           params:params
          success:^(id json) {
              
              BOOL isSuccess = [[json objectForKey:@"flag"] boolValue];
              NSDictionary *dataDic = [json objectForKey:@"data"];
              NSLogZS(@"%@",[json objectForKey:@"msg"]);
              if (isSuccess) {
                  
                  [self hideSuccessHUD:@"预支付成功"];
                  if (![dataDic isKindOfClass:[NSNull class]]) {
                      JHFOrder *order = [[JHFOrder alloc] init];
                      
                      order.version = [NSString stringWithFormat:@"%@",[dataDic objectForKey:@"version"]];
                      order.extra = [NSString stringWithFormat:@"%@",[dataDic objectForKey:@"extra"]];
                      order.merid = [NSString stringWithFormat:@"%@",[dataDic objectForKey:@"merid"]];
                      NSString *mernameStr = [NSString stringWithFormat:@"%@",[dataDic objectForKey:@"mername"]];
                      order.mername =  [NSString stringWithString:[mernameStr stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
                      order.policyid = @"000001";
                      order.merorderid = [NSString stringWithFormat:@"%@",[dataDic objectForKey:@"merorderid"]];
                      order.paymoney = [NSString stringWithFormat:@"%@",[dataDic objectForKey:@"paymoney"]];
                      NSString *productnameStr = [NSString stringWithFormat:@"%@",[dataDic objectForKey:@"productname"]];
                      order.productname = [NSString stringWithString:[productnameStr stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
                      order.userid = [NSString stringWithFormat:@"%@",[dataDic objectForKey:@"userid"]];
                      order.md5 = [self MD5:order withKey:[dataDic objectForKey:@"md5"]];
                      order.cardtype = [NSString stringWithFormat:@"%@",[dataDic objectForKey:@"cardtype"]];
                      
                      UINavigationController *navigationController = [[JHFSDK sharedInstance] payOrder:order fromScheme:@"allpayzsyg2016" viewController:self callback:^(NSDictionary *resultDict) {
                          NSLog(@"resultDict = %@", resultDict);
                          [self dismissViewControllerAnimated:YES completion:nil];
                      }];
                      
                      if(navigationController!=nil) {
                          [self presentViewController:navigationController animated:YES completion:nil];
                      }
                  }else{
                  
                      [self hideSuccessHUD:@"支付成功"];
                      
                  }
                  [self.navigationController popToRootViewControllerAnimated:YES];
                  
              }else{
                  
                  [self hideFailHUD:@"支付失败"];
                  
              }
              
          } failure:^(NSError *error) {
              
              [self hideFailHUD:@"支付失败"];
              
          }];
 
}

// MD5, 因为涉及到商户私钥，建议放在商户服务端进行
- (NSString*)MD5:(JHFOrder *)order withKey:(NSString *)md5Key{
    
    NSArray *array = @[[NSString stringWithFormat:@"version=%@", order.version?:@""],
                       [NSString stringWithFormat:@"merid=%@", order.merid?:@""],
                       [NSString stringWithFormat:@"mername=%@", order.mername?:@""],
                       [NSString stringWithFormat:@"policyid=%@", order.policyid?:@""],
                       [NSString stringWithFormat:@"merorderid=%@", order.merorderid?:@""],
                       [NSString stringWithFormat:@"paymoney=%@", order.paymoney?:@""],
                       [NSString stringWithFormat:@"productname=%@", order.productname?:@""],
                       [NSString stringWithFormat:@"productdesc=%@", order.productdesc?:@""],
                       [NSString stringWithFormat:@"userid=%@", order.userid?:@""],
                       [NSString stringWithFormat:@"username=%@", order.username?:@""],
                       [NSString stringWithFormat:@"email=%@", order.email?:@""],
                       [NSString stringWithFormat:@"phone=%@", order.phone?:@""],
                       [NSString stringWithFormat:@"extra=%@", order.extra?:@""],
                       [NSString stringWithFormat:@"custom=%@", order.custom?:@""]];
    
    NSString *string =  [array componentsJoinedByString:@"&"];
    string = [NSString stringWithFormat:@"%@%@", string, md5Key];
    
    const char *pointer = [string UTF8String];
    unsigned char md5Buffer[CC_MD5_DIGEST_LENGTH];
    
    CC_MD5(pointer, (CC_LONG)strlen(pointer), md5Buffer);
    
    NSMutableString *md5String = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [md5String appendFormat:@"%02x",md5Buffer[i]];
    
    return md5String;
    
}

-(void)creatTableView{

    _tab = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight-64-49) style:UITableViewStylePlain];
    _tab.backgroundColor = TableViewBackColor;
    
//    _tab.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    _tab.dataSource = self;
    
    _tab.delegate = self;
    
    [self.view addSubview:_tab];

}

#pragma mark-----UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 6;

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.row==0) {
        
        //商品总计
        PayFirstKindCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        
        if (!cell) {
            
            cell = [[PayFirstKindCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
            
            NSMutableArray *carArr = [NSMutableArray array];
            if ([_isimidiately isEqualToString:@"1"]) {
                
                carArr = [NSMutableArray arrayWithArray:[CartTools getCartList]];
                
            }else{
                
                carArr = [_immidiatelyArr mutableCopy];
            }
            cell.goodsTotal.text = [NSString stringWithFormat:@"共 %ld 件商品",(unsigned long)carArr.count];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.iconView.image = [UIImage imageNamed:@"箭头-下"];
            
        }
        
        return cell;
        
    }else if (indexPath.row==1){
  
        //红包抵扣
        UITableViewCell *cell = [[UITableViewCell alloc] init];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        if (_redEnveloperReduceCount > 0) {
            cell.textLabel.text = [NSString stringWithFormat:@"红包抵扣:%ld元",_redEnveloperReduceCount];
        }else{
            cell.textLabel.text = @"红包抵扣";
        }

        return cell;

    }else if (indexPath.row==2){
        
        //余额应当支付多少元
        PayThreeKindCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (!cell) {
            
            cell = [[PayThreeKindCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
            
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.iconView.image = [UIImage imageNamed:@"余额支付"];
        [cell.radio setBackgroundImage:[UIImage imageNamed:@"状态-亮"] forState:UIControlStateNormal];
   
        NSMutableArray *cartArr = [NSMutableArray array];
        if ([_isimidiately isEqualToString:@"1"]) {
            
            cartArr = [NSMutableArray arrayWithArray:[CartTools getCartList]];
            
        }else{
            
            cartArr = [_immidiatelyArr mutableCopy];
        }
        
        NSInteger totalPrice = 0;
        for (int i = 0; i < cartArr.count; i ++) {
            
            NSDictionary *dic = [cartArr objectAtIndex:i];
            NSInteger singlePrice = [[dic objectForKey:@"singlePrice"] integerValue];
            NSInteger num = [[dic objectForKey:@"buyTimes"] integerValue];
            totalPrice = totalPrice + singlePrice * num;
            
        }
        
        totalPrice = totalPrice - _redEnveloperReduceCount;
        
        NSDictionary *userDic = [[NSUserDefaults standardUserDefaults] objectForKey:@"userDic"];
        CGFloat restMoney = [userDic[@"money"] floatValue];
        if (totalPrice < 0){
            
            cell.wechat.text  = [NSString stringWithFormat:@"余额支付:0元"];
            
        }else if (restMoney > totalPrice) {
            
            cell.wechat.text  = [NSString stringWithFormat:@"余额支付:%ld元",(long)totalPrice];
            
        }else{
        
            cell.wechat.text  = [NSString stringWithFormat:@"余额支付:%.0f元",restMoney];
        
        }

        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    }else if (indexPath.row==3){
        
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
        
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.textLabel.text = @"其他支付方式";
        cell.detailTextLabel.font = [UIFont systemFontOfSize:15];
        
        NSMutableArray *cartArr = [NSMutableArray array];
        if ([_isimidiately isEqualToString:@"1"]) {
            
            cartArr = [NSMutableArray arrayWithArray:[CartTools getCartList]];
            
        }else{
            
            cartArr = [_immidiatelyArr mutableCopy];
        }
        
        NSInteger totalPrice = 0;
        for (int i = 0; i < cartArr.count; i ++) {
            
            NSDictionary *dic = [cartArr objectAtIndex:i];
            NSInteger singlePrice = [[dic objectForKey:@"singlePrice"] integerValue];
            NSInteger num = [[dic objectForKey:@"buyTimes"] integerValue];
            totalPrice = totalPrice + singlePrice * num;
            
        }
        
        totalPrice = totalPrice - _redEnveloperReduceCount;
        
        NSDictionary *userDic = [[NSUserDefaults standardUserDefaults] objectForKey:@"userDic"];
        CGFloat restMoney = [userDic[@"money"] floatValue];
        if (restMoney > totalPrice) {
            
            cell.detailTextLabel.text = @"0元";
            
        }else{
            
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%.0f元",totalPrice - restMoney];
            
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
      
        return cell;
        
    }

    PayThreeKindCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];

    NSArray *titles = @[@"微信支付",@"支付宝支付"];
    if (!cell) {
        
        cell = [[PayThreeKindCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
        
    }

    NSInteger cellStatu = [_thirdPayState[indexPath.row - 4] integerValue];
    if (cellStatu == 0) {
        [cell.radio setBackgroundImage:[UIImage imageNamed:@"状态-暗"] forState:UIControlStateNormal];
    }else{
        [cell.radio setBackgroundImage:[UIImage imageNamed:@"状态-亮"] forState:UIControlStateNormal];
    }

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.iconView.image = [UIImage imageNamed:titles[indexPath.row-4]];
    cell.wechat.text = titles[indexPath.row-4];

    return cell;
    
}

#pragma mark---UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 50;
 
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.01;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 1) {
        RedEnvelopeController *redEVC = [[RedEnvelopeController alloc] init];
        NSMutableArray *cartArr = [NSMutableArray array];
        if ([_isimidiately isEqualToString:@"1"]) {
            
            cartArr = [NSMutableArray arrayWithArray:[CartTools getCartList]];
            
        }else{
            
            cartArr = [_immidiatelyArr mutableCopy];
        }
        NSInteger totalPrice = 0;
        for (int i = 0; i < cartArr.count; i ++) {
            
            NSDictionary *dic = [cartArr objectAtIndex:i];
            NSInteger singlePrice = [[dic objectForKey:@"singlePrice"] integerValue];
            NSInteger num = [[dic objectForKey:@"buyTimes"] integerValue];
            totalPrice = totalPrice + singlePrice * num;
        }
        redEVC.constNum = totalPrice;
        redEVC.redDellegate = self;
        redEVC.isPay = @"2";
        [self.navigationController pushViewController:redEVC animated:YES];
        
    }else if (indexPath.row == 4){
    
        NSInteger cellState = [_thirdPayState[0] integerValue];
        if (cellState == 0) {
            _thirdPayState = @[@"1",@"0"];
        }else{
            _thirdPayState = @[@"0",@"0"];
        }
        [_tab reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:4 inSection:0],[NSIndexPath indexPathForRow:5 inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
        
    }else if (indexPath.row ==5){
        
        NSInteger cellState = [_thirdPayState[1] integerValue];
        if (cellState == 0) {
            _thirdPayState = @[@"0",@"1"];
        }else{
            _thirdPayState = @[@"0",@"0"];
        }
        
        [_tab reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:4 inSection:0],[NSIndexPath indexPathForRow:5 inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
        
    }

}

- (TabbarViewcontroller *)getRootController{
    
    UIApplication *app = [UIApplication sharedApplication];
    UIWindow *windows = app.keyWindow;
    return (TabbarViewcontroller *)windows.rootViewController;
    
}

- (void)paySelectDic:(NSDictionary *)redEnveloperDic{

    _redEnveloperReduceCount = [[redEnveloperDic objectForKey:@"amount"] integerValue];
    _redEnveloperID = [NSString stringWithFormat:@"%ld",[[redEnveloperDic objectForKey:@"id"] integerValue]];
    [_tab reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:1 inSection:0],[NSIndexPath indexPathForRow:2 inSection:0],[NSIndexPath indexPathForRow:3 inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
    
}

@end

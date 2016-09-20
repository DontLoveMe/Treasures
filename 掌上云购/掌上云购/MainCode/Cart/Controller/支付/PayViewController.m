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
#import "RedEnvelopeController.h"


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
//    
//    _dataArray = [NSMutableArray array];
    
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
    _warntext.text = @"夺宝有危险,参与需谨慎";
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
    
    
    NSArray *cartArr = [NSMutableArray arrayWithArray:[CartTools getCartList]];
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
    
    NSDictionary *userDic = [[NSUserDefaults standardUserDefaults] objectForKey:@"userDic"];
    NSNumber *userId = userDic[@"id"];
    
    [params setObject:userId forKey:@"buyUserId"];
    [params setObject:@"0" forKey:@"payType"];
    [params setObject:@"0" forKey:@"cashConsume"];
    
    //余额支付数量
    NSMutableArray *cartArr = [NSMutableArray arrayWithArray:[CartTools getCartList]];
    NSMutableArray  *BuyArr = [NSMutableArray array];
    NSInteger totalPrice = 0;
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
    
    [params setObject:[NSNumber numberWithInteger:totalPrice] forKey:@"balanceConsume"];
    [params setObject:BuyArr forKey:@"orderDetailList"];
    
    NSString *url = [NSString stringWithFormat:@"%@%@",BASE_URL,SubmitCartList_URL];
    [CartTools realaseCartList];
    [self showHUD:@"正在支付"];
    [ZSTools post:url
           params:params
          success:^(id json) {
              
              BOOL isSuccess = [[json objectForKey:@"flag"] boolValue];
              NSLogZS(@"%@",[json objectForKey:@"msg"]);
              if (isSuccess) {
                  
                  [self hideSuccessHUD:@"支付成功"];
                  [self.navigationController popViewControllerAnimated:YES];
                  
              }else{
                  
                  [self hideFailHUD:@"支付失败"];
                  
              }
              
          } failure:^(NSError *error) {
              
              [self hideFailHUD:@"支付失败"];
              
          }];
 
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

    return 7;

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.row==0) {
        PayFirstKindCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        
        if (!cell) {
            
            cell = [[PayFirstKindCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
            
            NSArray *carArr = [NSMutableArray arrayWithArray:[CartTools getCartList]];
            cell.goodsTotal.text = [NSString stringWithFormat:@"共 %ld 件商品",(unsigned long)carArr.count];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.iconView.image = [UIImage imageNamed:@"箭头-下"];
            
        }
        
        return cell;
        
    }else if (indexPath.row==1){
  
        UITableViewCell *cell = [[UITableViewCell alloc] init];
      
#warning 这里得判断有没有红包
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.textLabel.text = @"红包抵扣";
         
        return cell;

    }else if (indexPath.row==2){
    
        
#warning 这里得判断余额够不够
        PayFirstKindCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        
        if (!cell) {
            
            cell = [[PayFirstKindCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
            
            NSArray *cartArr = [NSMutableArray arrayWithArray:[CartTools getCartList]];
            
            NSInteger totalPrice = 0;
            for (int i = 0; i < cartArr.count; i ++) {
                
                NSDictionary *dic = [cartArr objectAtIndex:i];
                NSInteger singlePrice = [[dic objectForKey:@"singlePrice"] integerValue];
                NSInteger num = [[dic objectForKey:@"buyTimes"] integerValue];
                totalPrice = totalPrice + singlePrice * num;
            }

            cell.goodsTotal.text = [NSString stringWithFormat:@"总计:%ld元",(long)totalPrice];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.iconView.hidden = YES;
            cell.radio.hidden = NO;
            cell.radio.selected = YES;
            [cell.radio setBackgroundImage:[UIImage imageNamed:@"状态-暗"] forState:UIControlStateNormal];
            [cell.radio setBackgroundImage:[UIImage imageNamed:@"状态-亮"] forState:UIControlStateSelected];
            cell.radio.tag = 200;
            [cell.radio addTarget:self action:@selector(selectAtion:) forControlEvents:UIControlEventTouchUpInside];
            
        }
        
        return cell;
        
    }else if (indexPath.row==3){
        
#warning 这里得判断余额够不够
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
        
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.textLabel.text = @"其他支付方式";
        cell.detailTextLabel.font = [UIFont systemFontOfSize:15];
        cell.detailTextLabel.text = @"1云币";
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
      
        return cell;
        
    }

        PayThreeKindCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
        NSArray *titles = @[@"微信支付",@"支付宝支付",@"银联支付"];
        if (!cell) {
            
            cell = [[PayThreeKindCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.iconView.image = [UIImage imageNamed:titles[indexPath.row-4]];
            
            cell.wechat.text = titles[indexPath.row-4];
            
            [cell.radio setBackgroundImage:[UIImage imageNamed:@"状态-暗"] forState:UIControlStateNormal];
            [cell.radio setBackgroundImage:[UIImage imageNamed:@"状态-亮"] forState:UIControlStateSelected];
            cell.radio.tag = 300 + indexPath.row-4;
            [cell.radio addTarget:self action:@selector(selectAtion:) forControlEvents:UIControlEventTouchUpInside];
            
        }
        
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
        [self.navigationController pushViewController:redEVC animated:YES];
    }
}

- (void)selectAtion:(UIButton *)button {
    button.selected = !button.selected;
   
}
@end

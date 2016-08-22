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

@implementation PayViewController
{

    UITableView *_tab;
    
    NSMutableArray *_dataArray;

}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    _dataArray = [NSMutableArray array];
    
    self.title = @"支付";
    
    
    UIImage *image =[[UIImage imageNamed:@"返回"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIBarButtonItem *imageButton =[[UIBarButtonItem alloc]initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(leftClick:)];
    
    self.navigationItem.leftBarButtonItem = imageButton;
    
    
    //创建列表
    [self creatTableView];
    
    //创建底部View;
    [self creatView];
    
}


-(void)creatView
{
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, KScreenHeight-180, KScreenWidth, KScreenHeight)];
    
    view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:view];
    
    //商品总数
    _goodstotal = [[UILabel alloc]init];
    
    _goodstotal.text = @"共 3 件商品,";
    
    _goodstotal.textColor = [UIColor grayColor];
    
    [view addSubview:_goodstotal];
    
    _goodstotal.sd_layout
    .leftSpaceToView(view,5)
    .topSpaceToView(view,5)
    .widthIs(100)
    .heightIs(20);
    
    //商品总价格
    _pricetotal = [[UILabel alloc]init];
    
    _pricetotal.text = @"总计:";
    
    _pricetotal.textColor = [UIColor grayColor];
    
    [view addSubview:_pricetotal];
    
    _pricetotal.sd_layout
    .leftSpaceToView(_goodstotal,5)
    .topEqualToView(_goodstotal)
    .widthIs(40)
    .heightIs(20);
    
    //商品总钱数
    _pricesum = [[UILabel alloc]init];
    
    _pricesum.textColor = [UIColor redColor];
    
    _pricesum.text = @"21元";
    
    [view addSubview:_pricesum];
    
    _pricesum.sd_layout
    .leftSpaceToView(_pricetotal,3)
    .topEqualToView(_pricetotal)
    .widthIs(40)
    .heightIs(20);
    
    
    _warntext = [[UILabel alloc]init];
    
    _warntext.text = @"夺宝有危险,参与需谨慎";
    
    _warntext.textColor = [UIColor grayColor];
    
    [view addSubview:_warntext];
    
    _warntext.sd_layout
    .leftEqualToView(_goodstotal)
    .topSpaceToView(_goodstotal,10)
    .widthIs(200)
    .heightIs(20);
    
    _settlebtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    _settlebtn.layer.masksToBounds = YES;
    
    _settlebtn.layer.cornerRadius = 5;
    
    _settlebtn.backgroundColor = [UIColor redColor];
    
    [_settlebtn setTitle:@"提交" forState:UIControlStateNormal];
    
    [_settlebtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [_settlebtn addTarget:self action:@selector(PayClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [view addSubview:_settlebtn];
    
    _settlebtn.sd_layout
    .rightSpaceToView(view,10)
    .topSpaceToView(view,20)
    .widthIs(60)
    .heightIs(30);
    
    
    
}

-(void)PayClicked:(UIButton *)btn
{

 
}



-(void)creatTableView
{

    _tab = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight-180) style:UITableViewStylePlain];
    
    _tab.backgroundColor = TableViewBackColor;
    
    _tab.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    _tab.dataSource = self;
    
    _tab.delegate = self;
    
    [self.view addSubview:_tab];


}

#pragma mark-----UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return 6;

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (indexPath.row==0) {
        PayFirstKindCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        
        if (!cell) {
            
            cell = [[PayFirstKindCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
            
            cell.goodsTotal.text = @"共 1 件商品";
            
            cell.backgroundColor = TableViewBackColor;
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.iconView.image = [UIImage imageNamed:@"商品列表"];
            
        }
        
        return cell;
        

    }else if (indexPath.row==1)
    {
    
        PayFirstKindCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        
        if (!cell) {
            
            cell = [[PayFirstKindCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
            
            cell.goodsTotal.text = @"余额支付:1234";
            
            cell.backgroundColor = TableViewBackColor;
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.iconView.image = [UIImage imageNamed:@"商品列表"];
            
        }
        
        return cell;

      
    
    
    }else if (indexPath.row==2)
    {
    
    
        PayTwoKindCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        
        if (!cell) {
            
            cell = [[PayTwoKindCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
            
               cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            
            
            cell.redText.text = @"红包抵扣";
            
            cell.choiceText.text = @"无可用红包";
            
            cell.view.backgroundColor = [UIColor whiteColor];
            
            cell.otherText.text = @"其它支付方式";
            
            cell.money.text = @"125币";
            
            
        }
        
        return cell;
        

      
    
    }else if (indexPath.row==3)
    {
    
        
        PayThreeKindCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        
        if (!cell) {
            
            cell = [[PayThreeKindCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
            
            cell.iconView.image = [UIImage imageNamed:@"微信支付"];
            
            cell.wechat.text = @"微信支付";
            
            [cell.radio setImage:[UIImage imageNamed:@"我的-头像"] forState:UIControlStateNormal];
            
            
            
    
        }
        
        return cell;
        

    }else if (indexPath.row==4)
    {
    
        
        
        PayThreeKindCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        
        if (!cell) {
            
            cell = [[PayThreeKindCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
            
            cell.iconView.image = [UIImage imageNamed:@"支付宝支付"];
            
            cell.wechat.text = @"支付宝支付";
            
            [cell.radio setImage:[UIImage imageNamed:@"我的-头像"] forState:UIControlStateNormal];
            
        }
        
        return cell;
        

    }else
    {
        
        PayThreeKindCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        
        if (!cell) {
            
            cell = [[PayThreeKindCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
            
            cell.iconView.image = [UIImage imageNamed:@"银联支付"];
            
            cell.wechat.text = @"银联支付";
            
            [cell.radio setImage:[UIImage imageNamed:@"我的-头像"] forState:UIControlStateNormal];
            
        }
        
        return cell;
        

    }
    

    
    
    
}


#pragma mark---UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (indexPath.row==0) {
        return 60;
    }else if (indexPath.row==1)
    {
    
        return 60;
    }else if (indexPath.row==2)
    {
    
        return 120;
    }else if (indexPath.row==3)
    {
        return 90;
    }else if (indexPath.row==4)
    {
        return 90;
    }else{
        return 90;
    }
 
}




-(void)leftClick:(UIButton *)btn
{

    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

//
//  CartViewController.m
//  掌上云购
//
//  Created by coco船长 on 16/8/3.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import "CartViewController.h"
#import "CartTableViewCell.h"
#import "UIView+SDAutoLayout.h"
#import "PayViewController.h"
@interface CartViewController ()<UITableViewDelegate,UITableViewDataSource>
{


    UITableView *_tabview;
    
    NSMutableArray *_dataArray;

}

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

@implementation CartViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    _dataArray = [NSMutableArray array];
    
    self.title = @"购物车";
    
    //创建列表
    [self creatTableView];
    
    //添加编辑按钮
    [self creatNav];
    
    //创建底部View;
    [self creatView];
    
    
    
}


-(void)creatNav
{

    //设置右视图
    UIButton *rightbtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    
    [rightbtn setTitle:@"编辑" forState:UIControlStateNormal];
    
    [rightbtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    
    [rightbtn addTarget:self action:@selector(Clicked:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *custom = [[UIBarButtonItem alloc]initWithCustomView:rightbtn];
    
    self.navigationItem.rightBarButtonItem = custom;
    

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
    
    [_settlebtn setTitle:@"结算" forState:UIControlStateNormal];
    
    [_settlebtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [_settlebtn addTarget:self action:@selector(PayClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [view addSubview:_settlebtn];
    
    _settlebtn.sd_layout
    .rightSpaceToView(view,10)
    .topSpaceToView(view,20)
    .widthIs(60)
    .heightIs(30);
    
    

}

#pragma mark---结算按钮事件
-(void)PayClicked:(UIButton *)btn
{

    PayViewController *VC = [[PayViewController alloc]init];
    
    [self.navigationController pushViewController:VC animated:YES];

}


#pragma mark----编辑事件
-(void)Clicked:(UIButton *)btn
{

    NSLog(@"编辑");
 
}
-(void)creatTableView
{

    _tabview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight-180) style:UITableViewStylePlain];
    
    _tabview.backgroundColor = TableViewBackColor;
    
    _tabview.dataSource = self;
    
    _tabview.delegate = self;
    
    [self.view addSubview:_tabview];
   


}

#pragma mark----UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return 3;

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    
    CartTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (!cell) {
        
        cell = [[CartTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
        
        
        cell.goodsTitle.text = @"Apple iPhone6S Plus 128G 颜色随机";
        
        cell.totalNumber.text = @"总需809人次,";
        
        cell.surplusNumber.text = @"剩余737人次";
        
        cell.passengers.text = @"人次";
        
        cell.price.text = @"10元/人次";
        
        [cell.deleteBtn setImage:[UIImage imageNamed:@"按钮-"] forState:UIControlStateNormal];
        
        [cell.addBtn setImage:[UIImage imageNamed:@"按钮+"] forState:UIControlStateNormal];
        
        [cell.isSelectImg setImage:[UIImage imageNamed:@"复选框-未选中"]];
        
        cell.goodsType.image = [UIImage imageNamed:@"商品种类"];
        
        cell.goodsImg.image = [UIImage imageNamed:@"品牌图片"];
       
        cell.goodsNumLab.text = @"1";
    }
    
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return 160;
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

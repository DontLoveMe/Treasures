//
//  IndianaViewController.m
//  掌上云购
//
//  Created by 杨浩斌 on 16/8/23.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import "IndianaViewController.h"
#import "IndianRecordCell.h"
@interface IndianaViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation IndianaViewController

{


    UITableView *_tab;
    
    NSMutableArray *_dataArray;

}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    _dataArray = [NSMutableArray array];
    
    //创建列表
    [self creatUI];
    
    
    
}

-(void)creatUI
{

    _tab = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight) style:UITableViewStylePlain];
    
    _tab.dataSource = self;
    
    _tab.delegate = self;
    
    [self.view addSubview:_tab];

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{


    return 2;

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    IndianRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (!cell) {
        
        cell = [[IndianRecordCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
        
        cell.iconView.image = [UIImage imageNamed:@"QQlogo"];
        
        cell.luckView.image = [UIImage imageNamed:@"QQlogo"];
        
        cell.goodsName.text = @"商品名称";
        
        cell.numberLabel.text = @"期号:xxxxxx";
        
        cell.peopleLabel.text = @"本期参与:12人次";
        
        [cell.lookBtn setTitle:@"查看详情" forState:UIControlStateNormal];
        
        cell.winnerLabel.text = @"获得者:xxxxx";
        
        cell.passengersLabel.text = @"xx人次";
        
        [cell.buyBtn setTitle:@"购买" forState:UIControlStateNormal];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

    }
  
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{


    return 170;

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

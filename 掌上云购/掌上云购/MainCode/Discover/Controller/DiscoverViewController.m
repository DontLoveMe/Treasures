//
//  DiscoverViewController.m
//  掌上云购
//
//  Created by coco船长 on 16/8/3.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import "DiscoverViewController.h"
#import "DiscoverCell.h"
#import "SunSharingViewController.h"
@interface DiscoverViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation DiscoverViewController
{


    UITableView *_tab;
    
    NSMutableArray *_dataArray;
    

}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    _dataArray = [NSMutableArray array];
    
    self.title = @"发现";
    
    
    //创建列表
    [self creatTableView];
    
    
    
    
}

-(void)creatTableView
{

    _tab = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight) style:UITableViewStyleGrouped];
    
    _tab.dataSource = self;
    
    _tab.delegate = self;
    
    _tab.backgroundColor = TableViewBackColor;
    
    [self.view addSubview:_tab];
  

}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return 2;

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    if (section==0) {
        
        return 1;
    }else
    {
    
        return 5;
    }

}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    if(indexPath.section==0&&indexPath.row==0)
    {
    
    DiscoverCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (!cell) {
        
        cell = [[DiscoverCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
        
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        cell.iconView.image = [UIImage imageNamed:@"发现1"];
        
        cell.titleLabel.text = @"晒单分享";
        
        cell.detailLabel.text = @"没错,就是我中的!来咬我啊!";
        
    }
        return cell;
    }else if (indexPath.section==1&&indexPath.row==0)
    {
    
        DiscoverCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        
        if (!cell) {
            
            cell = [[DiscoverCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
            
            
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

            cell.selectionStyle = UITableViewCellSelectionStyleNone;

            
            cell.iconView.image = [UIImage imageNamed:@"发现2"];
            
            cell.titleLabel.text = @"每日首冲送礼包";
            
            cell.detailLabel.text = @"用网易支付每天首冲,最高得100元!";

    }
        
        return cell;
    }
    else if (indexPath.section==1&&indexPath.row==1)
    {
    
        DiscoverCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        
        if (!cell) {
            
            cell = [[DiscoverCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
            
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

            cell.selectionStyle = UITableViewCellSelectionStyleNone;

            
            cell.iconView.image = [UIImage imageNamed:@"发现3"];
            
            cell.titleLabel.text = @"激情观战奥运会";
            
            cell.detailLabel.text = @"为中国队加油!";
            
        }

    
        return cell;
    
    }else if (indexPath.section==1&&indexPath.row==2)
    {
    
    
        DiscoverCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        
        if (!cell) {
            
            cell = [[DiscoverCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
            
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

            cell.selectionStyle = UITableViewCellSelectionStyleNone;

            
            cell.iconView.image = [UIImage imageNamed:@"发现4"];
            
            cell.titleLabel.text = @"提车现场豪车秀";
            
            cell.detailLabel.text = @"他们竟然只花10元就开走了一辆车!";
            
        }

        return cell;
    }else if (indexPath.section==1&&indexPath.row==3)
    {
    
        DiscoverCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        
        if (!cell) {
            
            cell = [[DiscoverCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
            
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;

            cell.iconView.image = [UIImage imageNamed:@"发现5"];
            
            cell.titleLabel.text = @"充值送万元礼包";
            
            cell.detailLabel.text = @"送你万元红包,还可免费抽iPhone!";
            
        }

        return cell;
    }else
    {
    
        DiscoverCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        
        if (!cell) {
            
            cell = [[DiscoverCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
            
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

            cell.selectionStyle = UITableViewCellSelectionStyleNone;

            
            cell.iconView.image = [UIImage imageNamed:@"发现6"];
            
            cell.titleLabel.text = @"苹果商品全价购";
            
            cell.detailLabel.text = @"夏季换新,就来一元夺宝正品直购!";
            
        }

        return cell;
    }


}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section==0&&indexPath.row==0) {
        
        
        SunSharingViewController *VC = [[SunSharingViewController alloc]init];
        
        VC.hidesBottomBarWhenPushed = YES;
        
        [self.navigationController pushViewController:VC animated:YES];
        
    }

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0&&indexPath.row==0) {
        
        return 80;
    }else
    {
        return 80;
    }

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

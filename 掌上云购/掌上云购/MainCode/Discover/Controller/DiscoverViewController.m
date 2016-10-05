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
  

    [_tab registerClass:[DiscoverCell class] forCellReuseIdentifier:@"DiscoverCell"];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return 2;

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    if (section==0) {
        
        return 1;
    }
    
        return 1;
    

}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    
    DiscoverCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DiscoverCell" forIndexPath:indexPath];
    
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if(indexPath.section==0)
    {
        cell.iconView.image = [UIImage imageNamed:@"发现1"];
        
        cell.titleLabel.text = @"晒单分享";
        
        cell.detailLabel.text = @"听说晒单和中奖更配哦";
        
    }else {
        cell.iconView.image = [UIImage imageNamed:@"发现2"];
        
        cell.titleLabel.text = @"尽请期待！";
        
        cell.detailLabel.text = @"尽请期待!";
    }

    
    return cell;
    


}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section==0&&indexPath.row==0) {
        
        
        SunSharingViewController *VC = [[SunSharingViewController alloc]init];
        
        VC.hidesBottomBarWhenPushed = YES;
        
        [self.navigationController pushViewController:VC animated:YES];
        
    }

}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return nil;
    }
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = [UIColor whiteColor];
    label.text = @"  最新活动";
    label.textColor = [UIColor colorFromHexRGB:ThemeColor];
    label.textAlignment = NSTextAlignmentLeft;
    label.font = [UIFont systemFontOfSize:13];
    return label;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0&&indexPath.row==0) {
        
        return 65;
    }else
    {
        return 65;
    }

}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0.01;
    }
    return 20;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

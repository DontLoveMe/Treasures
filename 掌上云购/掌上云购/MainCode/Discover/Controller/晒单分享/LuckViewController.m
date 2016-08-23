//
//  LuckViewController.m
//  掌上云购
//
//  Created by 杨浩斌 on 16/8/23.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import "LuckViewController.h"
#import "LuckCell.h"
@interface LuckViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation LuckViewController

{

    UITableView *_tab;
    
    NSMutableArray *_dataArray;

}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    _dataArray = [NSMutableArray array];
    
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
 
   
    LuckCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (!cell) {
        
        cell = [[LuckCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
        
        cell.iconView.image = [UIImage imageNamed:@"QQlogo"];
        
        cell.goodsLabel.text = @"滴滴滴滴";
        
        cell.backgroundColor = [UIColor colorWithRed:242/256.0 green:242/256.0 blue:242/256.0 alpha:1];
        
        cell.numberLabel.text = @"xxxxxx";
        
        cell.totalLabel.text = @"12314";
        
        cell.luckLabel.text = @"123xx";
        
        cell.peopleLabel.text = @"xxx人次";
        
        cell.timeLabel.text = @"21331";
    }
    
    return cell;
    

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{


    return 200;

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

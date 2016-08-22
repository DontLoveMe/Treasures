//
//  SunSharingViewController.m
//  掌上云购
//
//  Created by 杨浩斌 on 16/8/19.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import "SunSharingViewController.h"
#import "SunShareCell.h"
@interface SunSharingViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation SunSharingViewController

{


    UITableView *_tab;
    
    NSMutableArray *_dataArray;
    

}




- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    _dataArray = [NSMutableArray array];
    
    self.title = @"晒单分享";
    
    UIImage *image =[[UIImage imageNamed:@"返回"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIBarButtonItem *imageButton =[[UIBarButtonItem alloc]initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(leftClick:)];
    
    self.navigationItem.leftBarButtonItem = imageButton;
    
    
    //创建列表
    [self creatTableView];
    
    
    
}

-(void)creatTableView
{

    _tab = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight)];
    
    _tab.dataSource = self;
    
    _tab.delegate = self;
    
    [self.view addSubview:_tab];

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return 4;

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{


    SunShareCell *cell  = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (!cell) {
        
        cell  =[[SunShareCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
        
        cell.iconView.image = [UIImage imageNamed:@"发现3"];
        
        cell.nameLabel.text = @"明天5000个赌个金碗";
        
        cell.timeLabel.text = @"14:03";
        
        cell.dateLabel.text = @"08-19";
        
        cell.commentLabel.text = @"运气好坏莫上头";
        
        cell.goodsnameLabel.text = @"中国黄金 AU9999投资金20g薄片";
        
        cell.issueLabel.text = @"期号:308110806";
        
        cell.detailLabel.text = @"贴吧上已经有很多案例了,运气好坏莫上头。理性夺宝,高投入不一定百分百高回报";
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.imgOne.image = [UIImage imageNamed:@"发现4"];
        
        cell.imgTwo.image = [UIImage imageNamed:@"发现5"];
        
        cell.imgThree.image = [UIImage imageNamed:@"发现6"];
        
    }
    
    return cell;

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return 280;
    


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

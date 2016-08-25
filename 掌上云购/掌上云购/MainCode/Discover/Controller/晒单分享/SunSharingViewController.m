//
//  SunSharingViewController.m
//  掌上云购
//
//  Created by 杨浩斌 on 16/8/19.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import "SunSharingViewController.h"
#import "SunShareCell.h"
#import "PersonalCenterController.h"
#import "SunShareModel.h"
@interface SunSharingViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation SunSharingViewController

{


    UITableView *_tab;
    
    NSMutableArray *_dataArray;
    
    NSInteger           _pageIndex;
    
    SunShareModel *_model;

    

}




- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    _dataArray = [NSMutableArray array];
    
     _pageIndex = 1;
    
    self.title = @"晒单分享";
    
    UIImage *image =[[UIImage imageNamed:@"返回"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIBarButtonItem *imageButton =[[UIBarButtonItem alloc]initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(leftClick:)];
    
    self.navigationItem.leftBarButtonItem = imageButton;
    
    
    //创建列表
    [self creatTableView];
    
    //请求数据
    [self requestData:_pageIndex];
    
    
    
}
#pragma mark---列表相关
-(void)creatTableView
{

    _tab = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight)];
    
    _tab.dataSource = self;
    
    _tab.delegate = self;
    
    [self.view addSubview:_tab];

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return _dataArray.count;

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{


    SunShareCell *cell  = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (!cell) {
        
        cell  =[[SunShareCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
        
        _model = _dataArray[indexPath.row];
        
        
        [cell configCellWithModel:_model];
        
        
        
        cell.iconView.image = [UIImage imageNamed:@"发现3"];
        
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
        
        tap.numberOfTapsRequired = 1;
        
        
        tap.numberOfTouchesRequired = 1;
        
      [cell.iconView addGestureRecognizer:tap];

        
        cell.timeLabel.text = @"14:03";
        
        cell.dateLabel.text = @"08-19";
        
        
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.imgOne.image = [UIImage imageNamed:@"发现4"];
        
        cell.imgTwo.image = [UIImage imageNamed:@"发现5"];
        
        cell.imgThree.image = [UIImage imageNamed:@"发现6"];
        
    }
    
    return cell;

}

-(void)tap:(UITapGestureRecognizer *)tap
{

    PersonalCenterController *VC = [[PersonalCenterController alloc]init];
    
    [self.navigationController pushViewController:VC animated:YES];
    

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return 280;
    


}

-(void)leftClick:(UIButton *)btn
{

    [self.navigationController popViewControllerAnimated:YES];

}


#pragma mark---数据源相关
- (void)requestData:(NSInteger)indexPath{

{


   [self showHUD:@"加载中"];
    
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setObject:@"10" forKey:@"rows"];
    
    [params setObject:[NSNumber numberWithInteger:indexPath]
               forKey:@"page"];
    
    NSString *url = [NSString stringWithFormat:@"%@%@",BASE_URL,Sunsharing_URL];
    
    [ZSTools post:url
           params:params
          success:^(id json) {
              
           
            [self hideSuccessHUD:[json objectForKey:@"msg"]];

              NSArray *rootArray = [json objectForKey:@"data"];
              
              for(NSDictionary *dic in rootArray) {
                  
                  _model = [[SunShareModel alloc]init];
                  
                  [_model setValuesForKeysWithDictionary:dic];
                  
                  [_dataArray addObject:_model];
                  
              }
              
              [_tab reloadData];
              
              
          } failure:^(NSError *error) {
              
              [self hideFailHUD:@"加载失败"];

          }];

   

}

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end

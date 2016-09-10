//
//  CountWayController.m
//  掌上云购
//
//  Created by coco船长 on 16/8/18.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import "CountWayController.h"

@interface CountWayController ()

@end

@implementation CountWayController
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
    self.title = @"计算详情";
    
    _dataDic = [NSMutableDictionary dictionary];
    _titleArr = @[@"计算公式",@"数值A",@"数值B",@"计算结果"];
    _valueArr = @[@"[(数值A+数值B)➗商品所需次数]（取余）+10000001",@"=截止开奖时间点前最后50条全站参与记录\n=正在计算",@"=最近一期中国福利彩票“老时时彩”的开奖结果\n=等待开奖",@"幸运号码:请等待开奖结果"];
    _AvalueArr = [NSMutableArray array];
    
    _isOpen = 0;
    
    [self initNavBar];
    
    [self initViews];
    
    [self requsetData];
    
}

- (void)initViews{

    _descriptionTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight - kNavigationBarHeight)
                                                     style:UITableViewStyleGrouped];
    _descriptionTable.delegate = self;
    _descriptionTable.dataSource = self;
    [self.view addSubview:_descriptionTable];

}

- (void)requsetData{

    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:_drawID forKey:@"drawId"];
    
    NSString *url = [NSString stringWithFormat:@"%@%@",BASE_URL,CountWay_URL];
    
    [ZSTools post:url
           params:params
          success:^(id json) {
              
              if ([[json objectForKey:@"flag"] boolValue]) {
                  
                  _dataDic = [[json objectForKey:@"data"] mutableCopy];
                  
                  NSDictionary *dic = [_dataDic objectForKey:@"bNumValue"];
                  NSString *bValueStr = [dic objectForKey:@"openCode"];
                  NSString *bValueResultStr = [bValueStr stringByReplacingOccurrencesOfString:@","
                                                       withString:@""];

                  NSMutableString *numStr = [[_dataDic objectForKey:@"msg"] mutableCopy];
                  NSString *resultStr = [numStr substringWithRange:NSMakeRange(numStr.length - 8, 8)];
                  
                  _valueArr = @[[_dataDic objectForKey:@"msg"],
                                @"=截止开奖时间点前最后50条全站参与记录",
                                [NSString stringWithFormat:@"=%@",bValueResultStr],
                                [NSString stringWithFormat:@"幸运号码:%@",resultStr]];
                  
                  [_descriptionTable reloadData];
                  
              }

              
          } failure:^(NSError *error) {
              
          }];
    
    
}

#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 4;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    if (section == 1) {
        
        if (_isOpen == 0) {
        
            return 0;
        
        }else{
        
            return _AvalueArr.count;
            
        }
        
    }else{
    
        return 0;
        
    }
    
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor colorFromHexRGB:@"EFEFEF"];
    
    NSString *titleStr = _titleArr[section];
    CGRect titleRect = [titleStr boundingRectWithSize:CGSizeMake(KScreenWidth - 24.f , 3000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(12.f, 4.f, KScreenWidth - 24.f, titleRect.size.height)];
    titleLabel.text = titleStr;
    titleLabel.font = [UIFont systemFontOfSize:15];
    [view addSubview:titleLabel];
    
    NSString *valueStr = _valueArr[section];
    CGRect valueRect = [valueStr boundingRectWithSize:CGSizeMake(KScreenWidth - 24.f , 3000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil];
    UILabel *valueLabel = [[UILabel alloc] initWithFrame:CGRectMake(12.f, titleLabel.bottom, KScreenWidth - 24.f, valueRect.size.height)];
    valueLabel.text = valueStr;
    valueLabel.font = [UIFont systemFontOfSize:13];
    [view addSubview:valueLabel];
    
    if (section == 1) {
        
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(KScreenWidth - 72.f, (valueLabel.bottom + 4)/2, 60.f, 24.f)];
        [button setTitleColor:[UIColor colorFromHexRGB:@"0095E5"]
                     forState:UIControlStateNormal];
        [button setTitle:@"展开🔽" forState:UIControlStateNormal];
        [button setTitle:@"收起⏫" forState:UIControlStateSelected];
        
        [button addTarget:self
                   action:@selector(isOpenAction:)
         forControlEvents:UIControlEventTouchUpInside];
        
        if (_isOpen == 0) {
            
            button.selected = NO;
            
        }else{
            
            button.selected = YES;
            
        }
        [view addSubview:button];
        
    }
    
    return view;
        
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    NSString *titleStr = _titleArr[section];
    CGRect titleRect = [titleStr boundingRectWithSize:CGSizeMake(KScreenWidth , 3000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil];
    
    NSString *valueStr = _valueArr[section];
    CGRect valueRect = [valueStr boundingRectWithSize:CGSizeMake(KScreenWidth - 24.f , 3000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil];
    
    return titleRect.size.height + valueRect.size.height + 8.f;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

    return 0;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
    NSDictionary *dic = _AvalueArr[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@（%@）",[dic objectForKey:@"createDate"],[dic objectForKey:@"createMillisecond"]];
    cell.detailTextLabel.text = [dic objectForKey:@"nickName"];
    return cell;
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 44.f;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [tableView deselectRowAtIndexPath:indexPath animated:YES];

}


- (void)isOpenAction:(UIButton *)button{

    if (button.selected) {
        
        button.selected = NO;
        _isOpen = 0;
        NSIndexSet *indexset = [NSIndexSet indexSetWithIndex:1];
        _AvalueArr = [NSMutableArray array];
        [_descriptionTable reloadSections:indexset
            withRowAnimation:UITableViewRowAnimationFade];
        
    }else{
    
        button.selected = YES;
        _isOpen = 1;
        NSIndexSet *indexset = [NSIndexSet indexSetWithIndex:1];
        _AvalueArr = [_dataDic objectForKey:@"aNumValueList"];
        [_descriptionTable reloadSections:indexset
                         withRowAnimation:UITableViewRowAnimationFade];
        
    }
    
}


@end

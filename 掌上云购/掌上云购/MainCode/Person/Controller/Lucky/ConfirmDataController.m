//
//  ConfirmDataController.m
//  掌上云购
//
//  Created by 刘毅 on 16/8/19.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import "ConfirmDataController.h"
#import "LuckyRecordCell.h"
#import "AddShareController.h"
//#import "GoodsStateCell.h"

@interface ConfirmDataController ()

@end

@implementation ConfirmDataController {
    
    UITableView *_tableView;
    NSString *_identify;
    NSString *_identify1;
    NSArray *_sectionArr;
    NSString *_defaultArea;
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
    
    self.title = @"信息确认";
    [self initNavBar];
    
    if (_state == 0) {
        _sectionArr = @[@"  商品状态",@"  商品信息"];
    }else {
        _sectionArr = @[@"  商品状态",@"  物流信息",@"  地址信息",@"  商品信息"];
        
    }
    
    [self requestAreaData];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight-64) style:UITableViewStyleGrouped];
    [self.view addSubview:_tableView];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    _identify = @"LuckyRecordCell";
    UINib *nib = [UINib nibWithNibName:@"LuckyRecordCell" bundle:nil];
    [_tableView registerNib:nib forCellReuseIdentifier:_identify];
    _identify1 = @"GoodsStateCell";
    UINib *nib1 = [UINib nibWithNibName:@"GoodsStateCell" bundle:nil];
    [_tableView registerNib:nib1 forCellReuseIdentifier:_identify1];
}

#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _sectionArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        GoodsStateCell *cell = [tableView dequeueReusableCellWithIdentifier:_identify1 forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
        cell.sureAddress.hidden = YES;
        cell.selectAddress.hidden = YES;
        cell.delayReceipt.hidden = YES;
        cell.sureReceipt.hidden = YES;
        if (_state == 0) {
            
            cell.stateView1.highlighted = YES;
            cell.stateView2.highlighted = YES;
            
            cell.stateLabel1.highlighted = YES;
            cell.stateLabel2.highlighted = YES;
            
//            cell.stateLabel2.text = @"确认收货地址\nxxxxxxxxxxxxx地址明细";
            cell.stateLabel2.text = [NSString stringWithFormat:@"确认收货地址\n%@",_defaultArea];
            cell.timeLabel1.highlighted = YES;
            cell.timeLabel2.highlighted = YES;
            
            cell.timeLabel1.text = @"";
            cell.timeLabel2.text = @"";
            cell.timeLabel3.text = @"";
            cell.timeLabel4.text = @"";
            cell.shareBtn.hidden = YES;
            
            cell.sureAddress.hidden = NO;
            cell.selectAddress.hidden = NO;
            cell.delayReceipt.hidden = YES;
            cell.sureReceipt.hidden = YES;
        }else {
            
            cell.stateView1.highlighted = YES;
            cell.stateView2.highlighted = YES;
            cell.stateView3.highlighted = YES;
            cell.stateView4.highlighted = YES;
            
            cell.stateLabel1.highlighted = YES;
            cell.stateLabel2.highlighted = YES;
            cell.stateLabel3.highlighted = YES;
            cell.stateLabel4.highlighted = YES;
            
            cell.timeLabel1.highlighted = YES;
            cell.timeLabel2.highlighted = YES;
            cell.timeLabel3.highlighted = YES;
            cell.timeLabel4.highlighted = YES;
            cell.timeLabel4.text = @"";
            
            cell.shareBtn.hidden = YES;
            cell.sureAddress.hidden = YES;
            cell.selectAddress.hidden = YES;
            cell.delayReceipt.hidden = NO;
            cell.sureReceipt.hidden = NO;
        }
        return cell;

    }
    if (_state == 1) {
        if (indexPath.section == 1||indexPath.section == 2) {
            UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"CellStyleSubtitle"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.textLabel.font = [UIFont systemFontOfSize:13];
            cell.detailTextLabel.font = [UIFont systemFontOfSize:12];
            cell.detailTextLabel.numberOfLines = 2;

            if (indexPath.section == 1) {
                cell.textLabel.text = @"物流公司：韵达";
                cell.detailTextLabel.text = @"\n快递单号：123453457";
            }else {
                cell.textLabel.text = @"姓名：李四  联系方式（1524*＊＊＊123)";
                cell.detailTextLabel.text = @"\n快递地址：岳麓区银杉路";
            }
            return cell;
        }
    }
    
    LuckyRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:_identify forIndexPath:indexPath];
    cell.goodsButton.hidden = YES;
    cell.lkModel = _rcModel;
    cell.contentView.backgroundColor = [UIColor colorFromHexRGB:@"EBEBF1"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        return 180;
    }
    if (indexPath.section == _sectionArr.count-1) {
        return 160;
    }
    return 80;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = [UIColor whiteColor];
    label.textColor = [UIColor blackColor];
    label.font = [UIFont systemFontOfSize:16];
    label.text = _sectionArr[section];
    
    return label;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 30;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}
//tag值：0确认地址2延期收货3确认收货4立即晒单
- (void)clickButtonBackTag:(NSInteger)tag {
    if (tag == 0) {
        [self confirmAddress];
    }else if (tag == 2){
        
    }else if (tag == 3) {
        
    }else if (tag == 4) {
        AddShareController *addSVC = [[AddShareController alloc] init];
        addSVC.lkModel = _rcModel;
        [self.navigationController pushViewController:addSVC animated:YES];
    }
}
#pragma mark - 数据请求
//确认地址
- (void)confirmAddress{
   // 取出存储的用户信息
    NSDictionary *userDic = [[NSUserDefaults standardUserDefaults] objectForKey:@"userDic"];
    NSNumber *userId = userDic[@"id"];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:userId forKey:@"buyUserId"];
    [params setObject:_rcModel.ID forKey:@"productId"];
    [params setObject:@(_rcModel.saleDraw.periodsNumber) forKey:@"buyPeriods"];
    
    NSString *url = [NSString stringWithFormat:@"%@%@",BASE_URL,ConfirmAddress_URL];
    [ZSTools post:url
           params:params
          success:^(id json) {
              
              BOOL isSuccess = [[json objectForKey:@"flag"] boolValue];
              NSLogZS(@"%@",json[@"msg"]);
              if (isSuccess) {
                  NSLogZS(@"确认地址");
                  _state = 1;
                   _sectionArr = @[@"  商品状态",@"  物流信息",@"  地址信息",@"  商品信息"];
                  [_tableView reloadData];
              }
              
              
          } failure:^(NSError *error) {
              
              
              NSLogZS(@"%@",error);
          }];
}
- (void)requestAreaData {
    //取出存储的用户信息
    NSDictionary *userDic = [[NSUserDefaults standardUserDefaults] objectForKey:@"userDic"];
    NSNumber *userId = userDic[@"id"];
    [self showHUD:@"加载中"];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:userId forKey:@"userId"];
    
    
    NSString *url = [NSString stringWithFormat:@"%@%@",BASE_URL,AreaList_URL];
    [ZSTools post:url
           params:params
          success:^(id json) {
              
              BOOL isSuccess = [[json objectForKey:@"flag"] boolValue];
              [self hideSuccessHUD:[json objectForKey:@"msg"]];
              if (isSuccess) {
                  NSArray *area = json[@"data"];
                  if (area.count == 0) {
                      return;
                  }
                  for (NSDictionary *dic in area) {
                      if(dic[@"isDefault"]) {
                          if ([dic[@"city"][@"name"]isEqualToString:dic[@"area"][@"name"]]) {
                              _defaultArea = [NSString stringWithFormat:@"%@%@%@",dic[@"province"][@"name"],dic[@"city"][@"name"],dic[@"addressDetailFull"]];
                          }else{
                              _defaultArea = [NSString stringWithFormat:@"%@%@%@%@",dic[@"province"][@"name"],dic[@"city"][@"name"],dic[@"area"][@"name"],dic[@"addressDetailFull"]];
                          }
                          
                          [_tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
                      }
                  }
                  
              }
              
              
          } failure:^(NSError *error) {
              
              [self hideFailHUD:@"加载失败"];
              NSLogZS(@"%@",error);
          }];
}

@end

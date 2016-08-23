//
//  AddressViewController.m
//  掌上云购
//
//  Created by 刘毅 on 16/8/17.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import "AddressViewController.h"
#import "AddAddressController.h"
#import "AddressCell.h"
#import "AddressModel.h"

@interface AddressViewController ()

@end

@implementation AddressViewController  {
    
    UITableView *_tableView;
    NSString *_identify;
    NSMutableArray *_data;
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
    
    
    UIButton *rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 45.f, 25.f)];
    rightButton.tag = 102;
    //    [rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [rightButton setTitle:@"编辑" forState:UIControlStateNormal];
    [rightButton setBackgroundImage:[UIImage imageNamed:@"按钮框"]
                           forState:UIControlStateNormal];
    [rightButton addTarget:self
                    action:@selector(NavAction:)
          forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightItem;
    
}
- (void)NavAction:(UIButton *)button{
    
    if (button.tag == 101) {
        
        [self.navigationController popViewControllerAnimated:YES];
    }else if (button.tag == 102) {
        
        _tableView.editing = !_tableView.editing;
        
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"收货地址管理";
    [self initNavBar];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight-64) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    _identify = @"AddressCell";
    [_tableView registerNib:[UINib nibWithNibName:@"AddressCell" bundle:nil] forCellReuseIdentifier:_identify];
 
    
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self requestData];
}
- (void)requestData {
    //取出存储的用户信息
//    NSDictionary *userDic = [[NSUserDefaults standardUserDefaults] objectForKey:@"userDic"];
//    NSNumber *userId = userDic[@"userId"];
    [self showHUD:@"加载中"];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:@1 forKey:@"userId"];
    
    
    NSString *url = [NSString stringWithFormat:@"%@%@",BASE_URL,AreaList_URL];
    [ZSTools post:url
           params:params
          success:^(id json) {
              
              BOOL isSuccess = [[json objectForKey:@"flag"] boolValue];
              [self hideSuccessHUD:[json objectForKey:@"msg"]];
              if (isSuccess) {
                  NSArray *arr = json[@"data"];
                  _data = arr.mutableCopy;
                  [_tableView reloadData];
                  
              }
              
              
          } failure:^(NSError *error) {
              
              [self hideFailHUD:@"加载失败"];
              NSLogZS(@"%@",error);
          }];
}
//修改默认地址
- (void)setDefault:(NSNumber *)addressId{
    if (addressId == nil) {
        return;
    }
    //取出存储的用户信息
    //    NSDictionary *userDic = [[NSUserDefaults standardUserDefaults] objectForKey:@"userDic"];
    //    NSNumber *userId = userDic[@"userId"];
    [self showHUD:@"修改默认地址"];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:@1 forKey:@"userId"];
    [params setObject:addressId forKey:@"id"];
    NSString *url = [NSString stringWithFormat:@"%@%@",BASE_URL,DefaultArea_URL];
    [ZSTools post:url
           params:params
          success:^(id json) {
              
              BOOL isSuccess = [[json objectForKey:@"flag"] boolValue];
              if (isSuccess) {
                  [self hideSuccessHUD:@"修改默认地址成功"];
                  [self requestData];
                  
              }
              
              
          } failure:^(NSError *error) {
              
              [self hideFailHUD:@"加载失败"];
              NSLogZS(@"%@",error);
          }];
}
//删除地址
- (void)deleteAddress:(NSNumber *)addressId index:(NSInteger)index{
    if (addressId == nil) return;
    
    //取出存储的用户信息
    //    NSDictionary *userDic = [[NSUserDefaults standardUserDefaults] objectForKey:@"userDic"];
    //    NSNumber *userId = userDic[@"userId"];
    [self showHUD:@"删除地址"];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    [params setObject:@1 forKey:@"userId"];
    [params setObject:addressId forKey:@"id"];
    NSString *url = [NSString stringWithFormat:@"%@%@",BASE_URL,DeleteArea_URL];
    [ZSTools post:url
           params:params
          success:^(id json) {
              
              BOOL isSuccess = [[json objectForKey:@"flag"] boolValue];
              [self hideSuccessHUD:json[@"msg"]];
              if (isSuccess) {
                  
//                  [_data removeObjectAtIndex:index];
//                  [_tableView reloadData];
                  [self requestData];
              }
              
              
          } failure:^(NSError *error) {
              
              [self hideFailHUD:@"加载失败"];
              NSLogZS(@"%@",error);
          }];
}

#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _data.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AddressCell *cell = [tableView dequeueReusableCellWithIdentifier:_identify forIndexPath:indexPath];
    [AddressModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{
                 @"addressId" : @"id",
                };
    }];
    AddressModel *model = [AddressModel mj_objectWithKeyValues:_data[indexPath.row]];
    cell.model = model;
   
    __weak typeof(self) weakSelf = self;
    [cell setSelectDefault:^(UIButton *sender) {
//        sender.selected = !sender.selected;
        [weakSelf setDefault:model.addressId];
    }];
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 90;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *footView = [[UIView alloc] init];
    footView.backgroundColor = [UIColor whiteColor];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake((KScreenWidth-120)/2, 20, 120, 40);
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitle:@"添加地址" forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"按钮框"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(addAddressAction:) forControlEvents:UIControlEventTouchUpInside];
    [footView addSubview:button];
    
    return footView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 60;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    AddAddressController *aaVC = [[AddAddressController alloc] init];
    aaVC.title = @"修改地址";
    AddressModel *model = [AddressModel mj_objectWithKeyValues:_data[indexPath.row]];
    aaVC.model = model;
    [self.navigationController pushViewController:aaVC animated:YES];
    
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        AddressModel *model = [AddressModel mj_objectWithKeyValues:_data[indexPath.row]];
        [self deleteAddress:model.addressId index:indexPath.row];
    }
    
}
//- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return UITableViewCellEditingStyleDelete;
//}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

#pragma mark - addAddress
- (void)addAddressAction:(UIButton *)button {
    
    AddAddressController *aaVC = [[AddAddressController alloc] init];
    aaVC.title = @"添加地址";
    [self.navigationController pushViewController:aaVC animated:YES];
}

@end

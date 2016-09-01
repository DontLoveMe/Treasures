//
//  InordertoDetailController.m
//  掌上云购
//
//  Created by 刘毅 on 16/8/15.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import "InordertoDetailController.h"

@interface InordertoDetailController ()

@end

@implementation InordertoDetailController

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
    
    self.navigationItem.rightBarButtonItem = nil;
    UIButton *rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40.f, 25.f)];
    rightButton.tag = 102;
    [rightButton setTitle:@"分享" forState:UIControlStateNormal];
//    [rightButton setBackgroundImage:[UIImage imageNamed:@"返回.png"]
//                          forState:UIControlStateNormal];
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
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"分享方式"
                                                                                 message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"QQ，微信"
                                                               style:UIAlertActionStyleDefault
                                                             handler:^(UIAlertAction * _Nonnull action) {
                                                                 [alertController dismissViewControllerAnimated:YES
                                                                                                     completion:nil];
                                                             }];
        UIAlertAction *cancelAction1 = [UIAlertAction actionWithTitle:@"取消"
                                                               style:UIAlertActionStyleDefault
                                                             handler:^(UIAlertAction * _Nonnull action) {
                                                                 [alertController dismissViewControllerAnimated:YES
                                                                                                     completion:nil];
                                                             }];
        [alertController addAction:cancelAction];
        [alertController addAction:cancelAction1];
        [self presentViewController:alertController
                           animated:YES
                         completion:nil];
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"晒单详情";
    
    [self initNavBar];
    
    [self requestData];
}
- (void)requestData {
    
    [self showHUD:@"加载数据"];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:@{@"id":@(_shareID)} forKey:@"paramsMap"];
    NSString *url = [NSString stringWithFormat:@"%@%@",BASE_URL,SunshareDetail_URL];
    [ZSTools post:url
           params:params
          success:^(id json) {
              
              BOOL isSuccess = [[json objectForKey:@"flag"] boolValue];
              [self hideSuccessHUD:json[@"msg"]];
              if (isSuccess) {
                  NSArray *dataArr = json[@"data"];
//                  if (_page == 1) {
//                      [_data removeAllObjects];
//                      _data = dataArr.mutableCopy;
//                      
//                      [_tableView.mj_footer resetNoMoreData];
//                      [_tableView.mj_header endRefreshing];
//                  }
//                  
//                  if (_page != 1 && _page != 0) {
//                      if (dataArr.count > 0) {
//                          _page ++;
//                          [_data addObjectsFromArray:dataArr];
//                          [_tableView.mj_footer endRefreshing];
//                      }else {
//                          [_tableView.mj_footer endRefreshingWithNoMoreData];
//                      }
//                  }
//                  [_tableView reloadData];
              }
              
              
          } failure:^(NSError *error) {
              
              [self hideFailHUD:@"加载失败"];
              NSLogZS(@"%@",error);
          }];
}


@end

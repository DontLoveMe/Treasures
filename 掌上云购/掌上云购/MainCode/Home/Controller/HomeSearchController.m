//
//  HomeSearchController.m
//  掌上云购
//
//  Created by coco船长 on 16/8/18.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import "HomeSearchController.h"

@interface HomeSearchController ()

@end

@implementation HomeSearchController

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
    self.title = @"搜索";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initNavBar];
    
    [self initViews];
    
}

- (void)initViews{

    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(4, 4, KScreenWidth - 8.f, 24.f)];
    _searchBar.barStyle = UIBarStyleDefault;
    [self.view addSubview:_searchBar];
    
    _searchHistoryTable = [[UITableView alloc] initWithFrame:CGRectMake(4.f, _searchBar.bottom + 8.f, KScreenWidth - 8.f, 200.f)];
    _searchHistoryTable.delegate = self;
    _searchHistoryTable.dataSource = self;
    _searchHistoryTable.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];
    [self.view addSubview:_searchHistoryTable];
    
    _separateLine = [[UIImageView alloc] initWithFrame:CGRectMake(4.f, _searchHistoryTable.bottom + 4, KScreenWidth - 8, 1.f)];
    _separateLine.backgroundColor = [UIColor blackColor];
    [self.view addSubview:_separateLine];
    
}

#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 0;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return nil;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 20;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
}

@end

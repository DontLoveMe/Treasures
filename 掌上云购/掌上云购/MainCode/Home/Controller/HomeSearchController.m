//
//  HomeSearchController.m
//  掌上云购
//
//  Created by coco船长 on 16/8/18.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import "HomeSearchController.h"
#import "SeachHistoryCell.h"
#import "HotSearchCell.h"
#import "HistoryData.h"

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
    
    if ([HistoryData getHistoryData]) {
        _historyData = [HistoryData getHistoryData];
    }
    [self initNavBar];
    
    [self initViews];
    
}

- (void)initViews{

    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(4, 4, KScreenWidth - 8.f, 28.f)];
    _searchBar.barStyle = UIBarStyleBlackTranslucent;

    _searchBar.searchBarStyle = UISearchBarStyleMinimal;
    _searchBar.barTintColor = [UIColor whiteColor];
    _searchBar.delegate = self;
    
    UITextField *searchField = [_searchBar valueForKey:@"_searchField"];
    // 输入文本颜色
    searchField.textColor = [UIColor blackColor];
    // 默认文本颜色
    //    [searchField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    
    [self.view addSubview:_searchBar];
//    self.navigationItem.titleView = _searchBar;
    
    _searchHistoryTable = [[UITableView alloc] initWithFrame:CGRectMake(4.f, _searchBar.bottom + 8.f, KScreenWidth - 8.f, 667.f-64) style:UITableViewStyleGrouped];
    _searchHistoryTable.delegate = self;
    _searchHistoryTable.dataSource = self;
   
    [self.view addSubview:_searchHistoryTable];
    
    [_searchHistoryTable registerNib:[UINib nibWithNibName:@"SeachHistoryCell" bundle:nil] forCellReuseIdentifier:@"SeachHistoryCell"];
    
    [_searchHistoryTable registerNib:[UINib nibWithNibName:@"HotSearchCell" bundle:nil] forCellReuseIdentifier:@"HotSearchCell"];
    
//    
//    _separateLine = [[UIImageView alloc] initWithFrame:CGRectMake(4.f, _searchHistoryTable.bottom + 4, KScreenWidth - 8, 1.f)];
//    _separateLine.backgroundColor = [UIColor blackColor];
//    [self.view addSubview:_separateLine];
    
}

- (void)searchRequestData:(NSString *)searchStr {
    NSLogZS(@"%@",searchStr);
    
}

#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return _historyData.count;
    }
    return 1;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        SeachHistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SeachHistoryCell" forIndexPath:indexPath];
        cell.titleLabel.text = _historyData[indexPath.row];
        
        __weak typeof(self) weakSelf = self;
        [cell setDeleteIndex:^(UIButton *sender) {
            [weakSelf deleteIndex:indexPath.row];
        }];
        
        return cell;
    }
    HotSearchCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HotSearchCell" forIndexPath:indexPath];
    __weak typeof(self) weakSelf = self;
    [cell setHotSearchString:^(NSString *hotString){
        [weakSelf searchRequestData:hotString];
    }];
    return cell;
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = [UIColor whiteColor];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 200, 30)];
    
    label.textColor = [UIColor blackColor];
    label.font = [UIFont systemFontOfSize:16];
    [headerView addSubview:label];
    if (section == 0) {
        label.text = @"历史搜索";
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(KScreenWidth-40, 5, 25, 28);
        [button setBackgroundImage:[UIImage imageNamed:@"搜索_全删"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(allDeleteAction:) forControlEvents:UIControlEventTouchUpInside];
        [headerView addSubview:button];
    }else {
        label.text = @"热门搜索";
    }
    
    
    
    
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 40;
    }
    return 90;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        [self searchRequestData:_historyData[indexPath.row]];
    }
    
}


- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
    [searchBar resignFirstResponder];
    
    [HistoryData addHistoryData:searchBar.text];
    _historyData = [HistoryData getHistoryData];
    [_searchHistoryTable reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
}
- (void)allDeleteAction:(UIButton *)button{
    
    [HistoryData allDeleteHistoryData];
    _historyData = [HistoryData getHistoryData];
    
    [_searchHistoryTable reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
}
- (void)deleteIndex:(NSInteger )index{
    
    [HistoryData deleteHistoryData:index];
    _historyData = [HistoryData getHistoryData];
    
    [_searchHistoryTable reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [_searchBar resignFirstResponder];
}
@end

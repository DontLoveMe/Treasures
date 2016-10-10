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
#import "SearchGoodsController.h"

@interface HomeSearchController ()

@end

@implementation HomeSearchController

- (void)initNavBar{
    
    self.navigationItem.backBarButtonItem = nil;
    UIButton *leftButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 12.f, 18.f)];
    leftButton.tag = 101;
    [leftButton setBackgroundImage:[UIImage imageNamed:@"返回.png"]
                          forState:UIControlStateNormal];
    [leftButton addTarget:self
                   action:@selector(NavAction:)
         forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    UIButton *rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 23.f, 20.f)];
    rightButton.tag = 102;
    [rightButton setBackgroundImage:[UIImage imageNamed:@"购物车.png"]
                           forState:UIControlStateNormal];
    [rightButton addTarget:self
                    action:@selector(NavAction:)
          forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
//    self.navigationItem.rightBarButtonItem = rightItem;
    
    UIButton *rightButton2 = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 22, 22)];
    rightButton2.tag = 103;
    [rightButton2 setBackgroundImage:[UIImage imageNamed:@"消息.png"]
                           forState:UIControlStateNormal];;
    [rightButton2 addTarget:self
                    action:@selector(NavAction:)
          forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem2 = [[UIBarButtonItem alloc]initWithCustomView:rightButton2];
    self.navigationItem.rightBarButtonItems =@[rightItem2,rightItem];
    
}

- (void)NavAction:(UIButton *)button{
    
    if (button.tag == 101) {
        [self.navigationController popViewControllerAnimated:YES];
    }else if (button.tag == 102){
        NSLogZS(@"进入购物车");
        id next = [self nextResponder];
        while (next != nil) {
            
            if ([next isKindOfClass:[TabbarViewcontroller class]]) {
                
                //获得标签控制器
                TabbarViewcontroller *tb = next;
                //修改索引
                tb.selectedIndex = 3;
                //原选中标签修改
                tb.selectedItem.isSelected = NO;
                //选中新标签
                TabbarItem *item = (TabbarItem *)[tb.view viewWithTag:4];
                item.isSelected = YES;
                //设置为上一个选中
                tb.selectedItem = item;
                
                return;
            }
            next = [next nextResponder];
        }
        
    }else {
        NSDictionary *userDic = [[NSUserDefaults standardUserDefaults] objectForKey:@"userDic"];
        if (userDic == nil) {
            LoginViewController *lVC = [[LoginViewController alloc] init];
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:lVC];
            [self presentViewController:nav animated:YES completion:nil];
            return;
        }
        MessageController *msgVC = [[MessageController alloc] init];
        self.navigationController.navigationBar.hidden = NO;
        msgVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:msgVC animated:YES];
    }
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
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    _historyData = [HistoryData getHistoryData];
    [_searchHistoryTable reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationFade];
}


#pragma mark - 视图初始化
- (void)initViews{

    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(4, 10, KScreenWidth - 8.f, 30.f)];
    [_searchBar setSearchFieldBackgroundImage:[UIImage imageNamed:@"搜索背景"] forState:UIControlStateNormal];
    
    _searchBar.barStyle = UIBarStyleDefault;
//    _searchBar.backgroundColor = [UIColor whiteColor];
    _searchBar.placeholder = @"搜索";
    _searchBar.searchBarStyle = UISearchBarStyleMinimal;
//    _searchBar.barTintColor = [UIColor whiteColor];
    _searchBar.delegate = self;
    
    UITextField *searchField = [_searchBar valueForKey:@"_searchField"];
//    searchField.background = [UIImage imageNamed:@"搜索背景"];
    // 输入文本颜色
    searchField.textColor = [UIColor blackColor];
    // 默认文本颜色
    //    [searchField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    
    [self.view addSubview:_searchBar];
//    self.navigationItem.titleView = _searchBar;
    
    _searchHistoryTable = [[UITableView alloc] initWithFrame:CGRectMake(0, _searchBar.bottom + 8.f, KScreenWidth, KScreenHeight-64) style:UITableViewStyleGrouped];
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
#pragma mark - 搜索
- (void)searchRequestData:(NSString *)searchStr {
    NSLogZS(@"%@",searchStr);
    [HistoryData addHistoryData:searchStr];
    _historyData = [HistoryData getHistoryData];
    [_searchHistoryTable reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationFade];
    SearchGoodsController *searchVC = [[SearchGoodsController alloc] init];
    searchVC.searchStr = searchStr;
    [self.navigationController pushViewController:searchVC animated:YES];
}

#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    return _historyData.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        HotSearchCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HotSearchCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        __weak typeof(self) weakSelf = self;
        [cell setHotSearchString:^(NSString *hotString){
            [weakSelf searchRequestData:hotString];
        }];
        
        return cell;
    }
//    SeachHistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SeachHistoryCell" forIndexPath:indexPath];
//    cell.titleLabel.text = _historyData[indexPath.row];
//    
//    __weak typeof(self) weakSelf = self;
//    [cell setDeleteIndex:^(UIButton *sender) {
//        [weakSelf deleteIndex:indexPath.row];
//    }];
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    cell.textLabel.text = _historyData[indexPath.row];
    cell.textLabel.textColor = [UIColor grayColor];
//    cell.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}
#pragma mark - 头视图
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = [UIColor whiteColor];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 200, 30)];
    
    label.textColor = [UIColor blackColor];
    label.font = [UIFont systemFontOfSize:15];
    [headerView addSubview:label];
    if (section == 0) {
        UIImageView *hotImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"热门搜索"]];
        hotImgView.frame = CGRectMake(5, 5, 23, 23);
        [headerView addSubview:hotImgView];
        label.frame = CGRectMake(CGRectGetMaxX(hotImgView.frame) + 3, 5, 200, 30);
        label.text = @"热门搜索";
    }else {
        
        label.text = @"历史搜索";
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(KScreenWidth-70, 8, 60, 23);
        [button setTitle:@"清空记录" forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:13];
        [button setTitleColor:[UIColor colorFromHexRGB:ThemeColor] forState:UIControlStateNormal];
//        [button setBackgroundImage:[UIImage imageNamed:@"搜索_全删"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(allDeleteAction:) forControlEvents:UIControlEventTouchUpInside];
        [headerView addSubview:button];
    }
    
    
    
    
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 90;
    }
    return 30;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 1) {
        [self searchRequestData:_historyData[indexPath.row]];
    }
    
}

#pragma mark - UISearchBarDelegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
    [searchBar resignFirstResponder];
    
    [self searchRequestData:searchBar.text];
    
}
- (void)allDeleteAction:(UIButton *)button{
    
    [HistoryData allDeleteHistoryData];
    _historyData = [HistoryData getHistoryData];
    
    [_searchHistoryTable reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationFade];
}
- (void)deleteIndex:(NSInteger )index{
    
    [HistoryData deleteHistoryData:index];
    _historyData = [HistoryData getHistoryData];
    
    [_searchHistoryTable reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationFade];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [_searchBar resignFirstResponder];
}
@end

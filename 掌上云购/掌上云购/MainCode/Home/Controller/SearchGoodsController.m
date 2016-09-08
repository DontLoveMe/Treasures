//
//  SearchGoodsController.m
//  掌上云购
//
//  Created by 刘毅 on 16/9/6.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import "SearchGoodsController.h"
#import "SearchGoodsCell.h"
#import "HistoryData.h"
#import "GoodsModel.h"
#import "GoodsDetailController.h"

@interface SearchGoodsController ()

@property (nonatomic,strong)UISearchBar *searchBar;
@property (nonatomic,strong)UITableView *tableView;

@property (nonatomic,strong)NSArray *seachData;

@end

@implementation SearchGoodsController

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
    
    
    UIButton *rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 25.f, 20.f)];
    rightButton.tag = 102;
    [rightButton setBackgroundImage:[UIImage imageNamed:@"购物车.png"]
                           forState:UIControlStateNormal];
    [rightButton addTarget:self
                    action:@selector(NavAction:)
          forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    _searchBar = [[UISearchBar alloc] init];
    _searchBar.barStyle = UIBarStyleBlackTranslucent;
    _searchBar.placeholder = @"搜索";
    _searchBar.searchBarStyle = UISearchBarStyleMinimal;
    _searchBar.barTintColor = [UIColor whiteColor];
    _searchBar.delegate = self;
    UITextField *searchField = [_searchBar valueForKey:@"_searchField"];
    // 输入文本颜色
    searchField.textColor = [UIColor whiteColor];
    // 默认文本颜色
    [searchField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    

    self.navigationItem.titleView = _searchBar;
}

- (void)NavAction:(UIButton *)button{
    if (button.tag == 101) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }else {
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

    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initNavBar];
    
    [self searchRequest];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight-64) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.showsVerticalScrollIndicator = NO;
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    UINib *nib = [UINib nibWithNibName:@"SearchGoodsCell" bundle:nil];
    [_tableView registerNib:nib forCellReuseIdentifier:@"SearchGoodsCell"];
}

- (void)searchRequest {
    NSString *url = [NSString stringWithFormat:@"%@%@",BASE_URL,GoodsList_URL];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if (_searchStr.length>0) {
        
        [params setObject:@{@"name":_searchStr} forKey:@"paramsMap"];
    }else {
        [params setObject:@{@"name":@""} forKey:@"paramsMap"];
    }
    
    [ZSTools post:url
           params:params
          success:^(id json) {
             
              BOOL isSuccess = [json objectForKey:@"flag"];
              [self hideSuccessHUD:json[@"msg"]];
              if (isSuccess) {
                  self.seachData = json[@"data"];
                  [_tableView reloadData];
              }
              
          } failure:^(NSError *error) {
              
          }];
}

#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.seachData.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SearchGoodsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SearchGoodsCell" forIndexPath:indexPath];
    cell.gsModel = [GoodsModel mj_objectWithKeyValues:self.seachData[indexPath.row]];
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 90;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    GoodsDetailController *gsdtVC = [[GoodsDetailController alloc] init];
    GoodsModel *gsModel = [GoodsModel mj_objectWithKeyValues:self.seachData[indexPath.row]];
    gsdtVC.goodsId = gsModel.ID;
    gsdtVC.drawId = gsModel.drawId;
    gsdtVC.isAnnounced = 1;
    [self.navigationController pushViewController:gsdtVC animated:YES];
    
    
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
    [searchBar resignFirstResponder];
    
    [HistoryData addHistoryData:searchBar.text];
    
    _searchStr = searchBar.text;
    [self searchRequest];
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [_searchBar resignFirstResponder];
}

@end

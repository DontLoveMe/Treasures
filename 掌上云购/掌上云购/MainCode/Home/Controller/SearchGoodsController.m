//
//  SearchGoodsController.m
//  掌上云购
//
//  Created by 刘毅 on 16/9/6.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import "SearchGoodsController.h"

@interface SearchGoodsController ()

@property (nonatomic,strong)UISearchBar *searchBar;
@property (nonatomic,strong)UITableView *tableView;

@property (nonatomic,strong)NSArray *seachData;

@end

@implementation SearchGoodsController

#pragma mark - 导航栏
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
    self.navigationItem.rightBarButtonItem = rightItem;
    
    _searchBar = [[UISearchBar alloc] init];
    _searchBar.barStyle = UIBarStyleBlackTranslucent;
    _searchBar.placeholder = @"搜索";
    _searchBar.text = _searchStr;
    [_searchBar setImage:[UIImage imageNamed:@"首页_搜索"] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
    [_searchBar setImage:[UIImage imageNamed:@"搜索_删除"] forSearchBarIcon:UISearchBarIconClear state:UIControlStateNormal];
    [_searchBar setSearchFieldBackgroundImage:[UIImage imageNamed:@"搜索背景_白"] forState:UIControlStateNormal];
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
        [self.navigationController popViewControllerAnimated:YES];
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
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.nowIndexpath = indexPath;
    cell.gsModel = [GoodsModel mj_objectWithKeyValues:self.seachData[indexPath.row]];
    cell.delegate = self;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 90;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    GoodsDetailController *gsdtVC = [[GoodsDetailController alloc] init];
    GoodsModel *gsModel = [GoodsModel mj_objectWithKeyValues:self.seachData[indexPath.row]];
    gsdtVC.goodsId = gsModel.ID;
//    gsdtVC.drawId = gsModel.drawId;
    gsdtVC.isAnnounced = 1;
    [self.navigationController pushViewController:gsdtVC animated:YES];
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 20;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    
    UILabel *resultLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth-120, 20)];
    resultLabel.text = [NSString stringWithFormat:@"搜索结果：%@(%ld)",_searchStr,self.seachData.count];
    resultLabel.textColor = [UIColor grayColor];
    resultLabel.textAlignment = NSTextAlignmentLeft;
    resultLabel.font = [UIFont systemFontOfSize:12];
    [headerView addSubview:resultLabel];
   
    UIButton *allButton = [UIButton buttonWithType:UIButtonTypeCustom];
    allButton.frame = CGRectMake(KScreenWidth-100, 0, 100, 20);
    allButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [allButton setTitleColor:[UIColor colorFromHexRGB:ThemeColor] forState:UIControlStateNormal];
    [allButton setTitle:@"全部加入清单" forState:UIControlStateNormal];
    
    [allButton addTarget:self action:@selector(allButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:allButton];
    
    return headerView;
}

#pragma mark - 加入购物车成功的动画
- (void)addToCartWithIndexpath:(NSIndexPath *)nowIndexpath{
    
    //数据
    NSDictionary *dic = [_seachData objectAtIndex:nowIndexpath.row];
    
    //设置动画图片初始位置
    SearchGoodsCell *cell = (SearchGoodsCell *)[_tableView cellForRowAtIndexPath:nowIndexpath];
    
    UIImageView *activityImgview = [[UIImageView alloc] initWithFrame:CGRectMake(nowIndexpath.row % 2 * (cell.width + 1) + 36, nowIndexpath.row / 2 * (cell.height + 1) + 16.f + _tableView.top, cell.imgView.width,cell.imgView.height)];
    //设置图片
    NSArray *picList = [dic objectForKey:@"proPictureList"];
    if (picList.count != 0) {
        
        [activityImgview setImageWithURL:[NSURL URLWithString:[picList[0] objectForKey:@"img650"]]];
        
    }
    
    [self.view addSubview:activityImgview];
    
    [UIView animateWithDuration:1.5
                     animations:^{
                         
                         CGAffineTransform transform = CGAffineTransformMakeTranslation(KScreenWidth - 20 - activityImgview.centerX, -activityImgview.centerY);
                         transform = CGAffineTransformScale(transform, 0.01, 0.01);
                         activityImgview.transform = CGAffineTransformRotate(transform, 2 * M_PI_2);
                         //
                     }completion:^(BOOL finished) {
                         
                         //动画结束后隐藏图片
                         activityImgview.hidden = YES;
                         
                     }];
    
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

- (void)allButtonAction:(UIButton *)button{
    if (_seachData.count == 0) {
        return;
    }
    for (int i = 0; i < _seachData.count; i++) {
        
        GoodsModel *gsModel = [GoodsModel mj_objectWithKeyValues:self.seachData[i]];
        NSMutableArray *picArr = [gsModel.pictureList mutableCopy];
        for (int i = 0; i < picArr.count; i ++) {
            
            NSMutableDictionary *dic = [[picArr objectAtIndex:i] mutableCopy];
            for (NSInteger j = dic.allKeys.count - 1 ; j >= 0 ; j --) {
                
                if ([[dic objectForKey:dic.allKeys[j]] isEqual:[NSNull null]]) {
                    
                    [dic removeObjectForKey:dic.allKeys[j]];
                    
                }
                
            }
            [picArr replaceObjectAtIndex:i withObject:dic];
            
        }
        
        NSDictionary *goods = @{@"id":gsModel.ID,
                                @"name":gsModel.name,
                                @"proPictureList":picArr,
                                @"totalShare":@(gsModel.totalShare),
                                @"surplusShare":@(gsModel.surplusShare),
                                @"buyTimes":[NSNumber numberWithInteger:1],
                                @"singlePrice":@(gsModel.singlePrice)};
        
        BOOL isSuccess = [CartTools addCartList:@[goods]];
        if (isSuccess) {
            
            [self getRootController].cartNum = [CartTools getCartList].count;
            //        if ([_delegate respondsToSelector:@selector(addToCartWithIndexpath:)]) {
            //            [_delegate addToCartWithIndexpath:_nowIndexpath];
            //
            //        }
        }
        NSLogZS(@"加入清单，成功了么%d",isSuccess);
    }
    
}

- (TabbarViewcontroller *)getRootController{
    
    UIApplication *app = [UIApplication sharedApplication];
    UIWindow *windows = app.keyWindow;
    return (TabbarViewcontroller *)windows.rootViewController;
    
}
@end

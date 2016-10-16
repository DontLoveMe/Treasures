//
//  SnatchRecordController.m
//  掌上云购
//
//  Created by 刘毅 on 16/8/9.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import "SnatchRecordController.h"
#import "SnatchRecordCell.h"
#import "SnatchRecordingCell.h"
#import "RecordModel.h"
#import "LoveView.h"
#import "TabbarViewcontroller.h"

@interface SnatchRecordController ()

@property (nonatomic,strong)UIImageView *lineView;
@property (nonatomic,assign)NSInteger selectButtonTag;

@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,copy) NSString *identify;
@property (nonatomic,copy) NSString *identify2;

@property (nonatomic,strong)NSMutableArray *data;

@property (nonatomic,assign)NSInteger page;

@property (nonatomic,strong)LoveView *loveView;//猜你喜欢

@property (nonatomic,strong)UIView *noView;
@end

@implementation SnatchRecordController

#pragma mark - 导航栏
- (void)initNavBar{
    
    self.navigationItem.backBarButtonItem = nil;
    UIButton *leftButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, kNavigationBarItemWidth, kNavigationBarItemHight)];
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
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"云购记录";
    
    _page = 1;
    _data = [NSMutableArray array];
    
    [self initNavBar];
    
    //创建子视图
    [self createSubViews];
    
    [self requestData:nil];
    [self createBottomView];
    
}

- (void)requestData:(NSNumber *)drawStatus{
    //重置上拉加载
    [_tableView.mj_footer resetNoMoreData];
    
    //取出存储的用户信息
        NSDictionary *userDic = [[NSUserDefaults standardUserDefaults] objectForKey:@"userDic"];
        NSNumber *userId = userDic[@"id"];
    [self showHUD:@"加载数据"];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if (drawStatus == nil) {
        [params setObject:@{@"buyUserId":userId} forKey:@"paramsMap"];
    }else {
        [params setObject:@{@"buyUserId":userId,@"drawStatus":drawStatus} forKey:@"paramsMap"];
    }
    
    [params setObject:@(_page) forKey:@"page"];
    [params setObject:@8 forKey:@"rows"];
    
    NSString *url = [NSString stringWithFormat:@"%@%@",BASE_URL,UserOrderList_URL];
    [ZSTools post:url
           params:params
          success:^(id json) {
              
              BOOL isSuccess = [[json objectForKey:@"flag"] boolValue];
              [self hideSuccessHUD:json[@"msg"]];
              if (isSuccess) {
                  NSArray *dataArr = json[@"data"];
                  if (_page == 1) {
                      [_data removeAllObjects];
                      _data = dataArr.mutableCopy;
                      if (_data.count >0) {
                          _noView.hidden = YES;
                          _loveView.hidden = YES;
                      }else {
                          _noView.hidden = NO;
                          _loveView.hidden = NO;
                      }
                      
                      [_tableView.mj_footer resetNoMoreData];
                      [_tableView.mj_header endRefreshing];
                  }
                  
                  if (_page != 1 && _page != 0) {
                      if (dataArr.count > 0) {
                          _page ++;
                          [_data addObjectsFromArray:dataArr];
                          [_tableView.mj_footer endRefreshing];
                      }else {
                          [_tableView.mj_footer endRefreshingWithNoMoreData];
                      }
                  }
                  [_tableView reloadData];
              }
              
              
          } failure:^(NSError *error) {
              
              [self hideFailHUD:@"加载失败"];
              NSLogZS(@"%@",error);
          }];
   
}
//创建子视图
- (void)createSubViews {
    
    NSArray *titles = @[@"全部",@"进行中",@"已揭晓"];
    //按钮
    for (int i = 0; i < 3; i ++) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = 200 + i;
        button.frame = CGRectMake(KScreenWidth/3*i, 0, KScreenWidth/3, 45);
        button.backgroundColor = [UIColor whiteColor];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorFromHexRGB:ThemeColor] forState:UIControlStateSelected];
        [button setTitle:titles[i] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        
        if (i == 0) {
            button.selected = YES;
            _selectButtonTag = 200;
        }
    }
    UIImageView *lineView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 44, KScreenWidth, 1)];
    lineView.backgroundColor = [UIColor colorFromHexRGB:@"EAEAEA"];
    [self.view addSubview:lineView];

    //按钮下方的横线
    _lineView = [[UIImageView alloc] initWithFrame:CGRectMake((KScreenWidth/3-40)/2, 44, 40, 1)];
    _lineView.backgroundColor = [UIColor colorFromHexRGB:ThemeColor];
    [self.view addSubview:_lineView];
    
    
    [self requestData:nil];
    //创建表视图
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 45, KScreenWidth, KScreenHeight-45-64) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.showsVerticalScrollIndicator = NO;
    
    _tableView.backgroundColor = [UIColor clearColor];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    _identify = @"SnatchRecordCell";
    UINib *nib = [UINib nibWithNibName:@"SnatchRecordCell" bundle:nil];
    [_tableView registerNib:nib forCellReuseIdentifier:_identify];
    
    _identify2 = @"SnatchRecordingCell";
    UINib *nib2 = [UINib nibWithNibName:@"SnatchRecordingCell" bundle:nil];
    [_tableView registerNib:nib2 forCellReuseIdentifier:_identify2];
    
  
    //下拉时动画
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        
        _page = 1;
        [self changeStateData:_selectButtonTag];
        
    }];
    //下拉时图片
    NSMutableArray *gifWhenPullDown = [NSMutableArray array];
    for (NSInteger i = 1 ; i <= 30; i++) {
        
        if (i / 100 > 0) {
            [gifWhenPullDown addObject:[UIImage imageNamed:[NSString stringWithFormat:@"dropdown_zsyg_%ld",i]]];
        }else if (i / 10){
            [gifWhenPullDown addObject:[UIImage imageNamed:[NSString stringWithFormat:@"dropdown_zsyg_0%ld",i]]];
        }else{
            [gifWhenPullDown addObject:[UIImage imageNamed:[NSString stringWithFormat:@"dropdown_zsyg_00%ld",i]]];
        }
        
    }
    
    [header setImages:gifWhenPullDown
             duration:1 forState:MJRefreshStatePulling];
    
    //正在刷新时图片
    NSMutableArray *gifWhenRefresh = [NSMutableArray array];
    for (NSInteger i = 31 ; i <= 112; i++) {
        
        if (i / 100 > 0) {
            [gifWhenRefresh addObject:[UIImage imageNamed:[NSString stringWithFormat:@"dropdown_zsyg_%ld",i]]];
        }else if (i / 10){
            [gifWhenRefresh addObject:[UIImage imageNamed:[NSString stringWithFormat:@"dropdown_zsyg_0%ld",i]]];
        }else{
            [gifWhenRefresh addObject:[UIImage imageNamed:[NSString stringWithFormat:@"dropdown_zsyg_00%ld",i]]];
        }
        
    }
    
    [header setImages:gifWhenRefresh
             duration:2 forState:MJRefreshStateRefreshing];
    
    header.lastUpdatedTimeLabel.hidden = YES;
    header.stateLabel.hidden = NO;
    header.stateLabel.textColor = [UIColor colorFromHexRGB:ThemeColor];
    [header setTitle:@"下拉刷新。" forState:MJRefreshStateIdle];
    [header setTitle:@"松手即可刷新" forState:MJRefreshStatePulling];
    [header setTitle:@"正在刷新..." forState:MJRefreshStateRefreshing];
    _tableView.mj_header = header;
    
    
    MJRefreshBackStateFooter *footer = [MJRefreshBackStateFooter footerWithRefreshingBlock:^{
        if (_page == 1) {
            _page = 2;
        }

        switch (_selectButtonTag) {
            case 200:
                [self requestData:nil];
                break;
            case 201:
                [self requestData:@1];
                break;
            case 202:
                [self requestData:@3];
                break;
                
            default:
                break;
        }
    }];
    _tableView.mj_footer = footer;
    
}
//创建下方视图
- (void)createBottomView {
    
    CGFloat w = (KScreenWidth-8*4)/3;
    
    _loveView = [[LoveView alloc] initWithFrame:CGRectMake(0, KScreenHeight-w*1.4-37-64, KScreenWidth, w*1.4+35)];
    [self.view addSubview:_loveView];
    
    
    _noView = [[UIView alloc] initWithFrame:CGRectMake((KScreenWidth-220)/2, (KScreenHeight-240)/2-100, 220, 240)];
    //    _noView.backgroundColor = [UIColor grayColor];
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake((_noView.width-150)/2, 15, 150, 150)];
    imgView.image = [UIImage imageNamed:@"无记录"];
    [_noView addSubview:imgView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, imgView.bottom +5, _noView.width, 16)];
    label.text = @"你还没有记录哦";
    label.textColor = [UIColor darkGrayColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:13];
    [_noView addSubview:label];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake((_noView.width-85)/2, label.bottom+5, 85, 28);
    button.titleLabel.font = [UIFont systemFontOfSize:13];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitle:@"立即夺宝" forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"按钮背景-黄"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buyAction:) forControlEvents:UIControlEventTouchUpInside];
    [_noView addSubview:button];
    
    
    [self.view insertSubview:_noView atIndex:0];
    
}
- (void)buyAction:(UIButton *)button{
    id next = [self nextResponder];
    while (next != nil) {
        
        if ([next isKindOfClass:[TabbarViewcontroller class]]) {
            
            //获得标签控制器
            TabbarViewcontroller *tb = (TabbarViewcontroller *)next;
            //修改索引
            tb.selectedIndex = 0;
            //原选中标签修改
            tb.selectedItem.isSelected = NO;
            //选中新标签
            TabbarItem *item = (TabbarItem *)[tb.view viewWithTag:1];
            item.isSelected = YES;
            //设置为上一个选中
            tb.selectedItem = item;
            
            return;
        }
        next = [next nextResponder];
    }

}
#pragma mark - 按钮的点击
- (void)buttonAction:(UIButton *)button {
    
    UIButton *selectButton = [self.view viewWithTag:_selectButtonTag];
    
    if (button.tag != _selectButtonTag) {
        selectButton.selected = NO;
        button.selected = YES;
    }
    
    [UIView animateWithDuration:0.15 animations:^{
        
        _selectButtonTag = button.tag;
        CGRect frame = _lineView.frame;
        frame.origin.x = (KScreenWidth/3-40)/2+button.origin.x;
        _lineView.frame = frame;
    }];
    [self changeStateData:button.tag];
    
}

- (void)changeStateData:(NSInteger)tag {
    switch (tag) {
        case 200:
            _page = 1;
            [self requestData:nil];
            break;
        case 201:
            _page = 1;
            [self requestData:@1];
            break;
        case 202:
            _page = 1;
            [self requestData:@3];
            break;
            
        default:
            break;
    }
}

#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _data.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RecordModel *rcModel = [RecordModel mj_objectWithKeyValues:_data[indexPath.row]];
    if (rcModel.saleDraw.status == 3 || rcModel.saleDraw.status == 2) {
        SnatchRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:_identify forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
        cell.rcModel = rcModel;
        return cell;
    }
    SnatchRecordingCell *cell = [tableView dequeueReusableCellWithIdentifier:_identify2 forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    cell.rcModel = rcModel;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 160;
}


@end

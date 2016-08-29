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

@interface SnatchRecordController ()

@property (nonatomic,strong)UIImageView *lineView;
@property (nonatomic,assign)NSInteger selectButtonTag;

@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,copy) NSString *identify;
@property (nonatomic,copy) NSString *identify2;

@property (nonatomic,strong)NSArray *data;

@end

@implementation SnatchRecordController

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
    
    self.title = @"云购记录";
    
    [self initNavBar];
    
    //创建子视图
    [self createSubViews];
    
    [self requestData:nil];
    
    
}

- (void)requestData:(NSNumber *)drawStatus{
    //取出存储的用户信息
    //    NSDictionary *userDic = [[NSUserDefaults standardUserDefaults] objectForKey:@"userDic"];
    //    NSNumber *userId = userDic[@"userId"];
//    [self showHUD:@"加载数据"];
//    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    if (drawStatus == nil) {
//        [params setObject:@{@"buyUserId":@2} forKey:@"paramsMap"];
//    }else {
//        [params setObject:@{@"buyUserId":@2,@"drawStatus":drawStatus} forKey:@"paramsMap"];
//    }
//    
//    [params setObject:@1 forKey:@"page"];
//    [params setObject:@1 forKey:@"rows"];
//    
//    NSString *url = [NSString stringWithFormat:@"%@%@",BASE_URL,UserOrderList_URL];
//    [ZSTools post:url
//           params:params
//          success:^(id json) {
//              
//              BOOL isSuccess = [[json objectForKey:@"flag"] boolValue];
//              [self hideSuccessHUD:json[@"msg"]];
//              if (isSuccess) {
//                  _data = json[@"data"];
//                  [_tableView reloadData];
//              }
//              
//              
//          } failure:^(NSError *error) {
//              
//              [self hideFailHUD:@"加载失败"];
//              NSLogZS(@"%@",error);
//          }];
    NSDictionary *dic1 = @{
        @"id": @1,
        @"name": @"测试数据",
        @"expirationDate": @"2016-08-16 17:27:06",
        @"status": @1,
        @"isBuy": @0,
        @"totalShare": @1000,
        @"surplusShare": @0,
        @"sellShare": @10,
        @"saleDraw": @{
            @"id":@2,
            @"periodsNumber": @3,
            @"drawTimes":@100000001,
            @"productId": @4,
            @"totalShare": @1000,
            @"surplusShare": @0,
            @"sellShare": @1000,
            @"status": @3,
            @"drawDate": @"2016-07-16 15:42:02.0",
            @"drawUserId": @5,
            @"drawNumber": @"10000086",
            @"countdownStartDate": @"2016-08-26 16:10:14.0",
            @"countdownEndDate": @"2016-08-23 10:03:00.0",
            @"nickName": @"测6",
            @"qty": @""
            
        }
        };
    NSDictionary *dic2 = @{
                          @"id": @1,
                          @"name": @"测试数据",
                          @"expirationDate": @"2016-08-16 17:27:06",
                          @"status": @3,
                          @"isBuy": @0,
                          @"totalShare": @1000,
                          @"surplusShare": @0,
                          @"sellShare": @10,
                          @"saleDraw": @{
                                  @"id":@2,
                                  @"periodsNumber": @3,
                                  @"drawTimes":@100000001,
                                  @"productId": @4,
                                  @"totalShare": @1000,
                                  @"surplusShare": @0,
                                  @"sellShare": @1000,
                                  @"status": @3,
                                  @"drawDate": @"2016-07-16 15:42:02.0",
                                  @"drawUserId": @5,
                                  @"drawNumber": @"10000086",
                                  @"countdownStartDate": @"2016-08-26 16:10:14.0",
                                  @"countdownEndDate": @"2016-08-23 10:03:00.0",
                                  @"nickName": @"测6",
                                  @"qty": @"100"
                                  }
                          };
    if (drawStatus == nil) {
        _data = @[dic1,dic2,dic1,dic2,dic1,dic1,dic2,dic2];
    }else if ([drawStatus integerValue] == 1) {
        _data = @[dic1,dic1,dic1,dic1];
    }else if ([drawStatus integerValue] == 3) {
        _data = @[dic2,dic2,dic2,dic2];
    }
    [_tableView reloadData];
}
//创建子视图
- (void)createSubViews {
    
    NSArray *titles = @[@"全部",@"进行中",@"已揭晓"];
    //按钮
    for (int i = 0; i < 3; i ++) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = 200 + i;
        button.frame = CGRectMake(KScreenWidth/3*i, 0, KScreenWidth/3, 30);
        button.backgroundColor = [UIColor whiteColor];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorFromHexRGB:ThemeColor] forState:UIControlStateSelected];
        [button setTitle:titles[i] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:13];
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        
        if (i == 0) {
            button.selected = YES;
            _selectButtonTag = 200;
        }
    }
    //按钮下方的横线
    _lineView = [[UIImageView alloc] initWithFrame:CGRectMake((KScreenWidth/3-40)/2, 29, 40, 1)];
    _lineView.backgroundColor = [UIColor colorFromHexRGB:ThemeColor];
    [self.view addSubview:_lineView];
    
    
    [self requestData:nil];
    //创建表视图
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 30, KScreenWidth, KScreenHeight-30-64) style:UITableViewStylePlain];
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
    
    switch (button.tag) {
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
}

#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _data.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RecordModel *rcModel = [RecordModel mj_objectWithKeyValues:_data[indexPath.row]];
    if (rcModel.status == 3) {
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

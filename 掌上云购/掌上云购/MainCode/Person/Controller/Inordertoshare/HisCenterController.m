//
//  HisCenterController.m
//  掌上云购
//
//  Created by 刘毅 on 16/8/15.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import "HisCenterController.h"
#import "SnatchRecordCell.h"
#import "SnatchRecordingCell.h"
#import "RecordModel.h"
#import "InordertoshareCell.h"
#import "InordertoshareModel.h"

@interface HisCenterController ()
@property (nonatomic,strong)UIImageView *lineView;
@property (nonatomic,assign)NSInteger selectButtonTag;
@property (nonatomic,strong)UIImageView *bgIconView;

@property (nonatomic,strong)UIImageView *iconView;
@property (nonatomic,strong)UILabel *nikeNLabel;
//@property (nonatomic,strong)UILabel *idLabel;

//0.云购记录；1.幸运记录；2.我的晒单
@property (nonatomic,assign)NSInteger type;

@property (nonatomic,assign)NSArray *data;

@end

@implementation HisCenterController

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
    
    self.title = @"TA的个人中心";
    
    [self initNavBar];
 
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.backgroundColor = [UIColor clearColor];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    

    UINib *nib = [UINib nibWithNibName:@"SnatchRecordCell" bundle:nil];
    [_tableView registerNib:nib forCellReuseIdentifier:@"SnatchRecordCell"];
    
    UINib *nib2 = [UINib nibWithNibName:@"SnatchRecordingCell" bundle:nil];
    [_tableView registerNib:nib2 forCellReuseIdentifier:@"SnatchRecordingCell"];
    
    UINib *nib3 = [UINib nibWithNibName:@"InordertoshareCell" bundle:nil];
    [_tableView registerNib:nib3 forCellReuseIdentifier:@"InordertoshareCell"];

    
    [self initBgHeaderView];
    [self createTableHeaderView];
    
}
- (void)initBgHeaderView {
    
    _bgIconView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 160)];
    [self.view insertSubview:_bgIconView belowSubview:_tableView];
    
    _bgIconView.image = [UIImage imageNamed:@"发现5"];
    //  毛玻璃样式
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    //  毛玻璃视图
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    effectView.alpha = 0.8;
    effectView.frame = _bgIconView.bounds;
    [_bgIconView addSubview:effectView];
}

- (void)createTableHeaderView {

    UIImageView *tableHeaderView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 160)];
//    tableHeaderView.backgroundColor = [UIColor colorFromHexRGB:ThemeColor];
    _iconView = [[UIImageView alloc] initWithFrame:CGRectMake((KScreenWidth-90)/2, 30, 90, 90)];
    _iconView.image = [UIImage imageNamed:@"发现5"];
    [tableHeaderView addSubview:_iconView];
    
    _nikeNLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_iconView.frame)+2, KScreenWidth, 20)];
    _nikeNLabel.text = @"nikeName";
    _nikeNLabel.textColor = [UIColor whiteColor];
    _nikeNLabel.textAlignment = NSTextAlignmentCenter;
    _nikeNLabel.font = [UIFont systemFontOfSize:16];
    [tableHeaderView addSubview:_nikeNLabel];
    
    _tableView.tableHeaderView = tableHeaderView;
}

#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_type == 0){
        RecordModel *rcModel = [RecordModel mj_objectWithKeyValues:_data[indexPath.row]];
        if (rcModel.status == 3) {
            SnatchRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SnatchRecordCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor clearColor];
//            cell.rcModel = rcModel;
            return cell;
        }
        SnatchRecordingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SnatchRecordingCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
//        cell.rcModel = rcModel;
        return cell;
    }else if (_type == 1) {
        RecordModel *rcModel = [RecordModel mj_objectWithKeyValues:_data[indexPath.row]];
        SnatchRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SnatchRecordCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
//        cell.rcModel = rcModel;
        return cell;
    }

    InordertoshareCell *cell = [tableView dequeueReusableCellWithIdentifier:@"InordertoshareCell" forIndexPath:indexPath];
//    cell.iSModel = [InordertoshareModel mj_objectWithKeyValues:self.data[indexPath.row]];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_type == 0||_type == 1) {
        return 160;
    }
    //计算单元格高度
    InordertoshareModel *iSModel = [InordertoshareModel mj_objectWithKeyValues:self.data[indexPath.row]];
    NSString *content = iSModel.content;
    CGRect contentRect = [content boundingRectWithSize:CGSizeMake(KScreenWidth-57, 35) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil];
    NSArray *photoUrllist = iSModel.photoUrllist;
    CGFloat height;
    if (photoUrllist.count == 0) {
        height = 0;
    }else if (photoUrllist.count <4){
        height = 90;
    }else if (photoUrllist.count < 7){
        height = 90*2;
    }
    
    return height + contentRect.size.height + 120;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc] init];
//    headerView.backgroundColor = [UIColor redColor];
    NSArray *titles = @[@"夺宝记录",@"幸运记录",@"晒单记录"];
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
        [headerView addSubview:button];
        
        if (i == 0) {
            button.selected = YES;
            _selectButtonTag = 200;
        }
    }
    //按钮下方的横线
    _lineView = [[UIImageView alloc] initWithFrame:CGRectMake(KScreenWidth/3*(_selectButtonTag-200), 29, KScreenWidth/3, 1)];
    _lineView.backgroundColor = [UIColor colorFromHexRGB:ThemeColor];
    [headerView addSubview:_lineView];
    return headerView;
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
        frame.origin.x = button.origin.x;
        _lineView.frame = frame;
    }];
    [self changeStateData:button.tag];
    
}

- (void)changeStateData:(NSInteger)tag {
    switch (tag) {
        case 200:
//            [self requestData:nil];
            _type = 0;
            [_tableView reloadData];
            break;
        case 201:
//            [self requestData:@1];
            _type = 1;
            [_tableView reloadData];
            break;
        case 202:
//            [self requestData:@3];
            _type = 2;
            [_tableView reloadData];
            break;
            
        default:
            break;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    //    NSLog(@"%f",-scrollView.contentOffset.y);
    
    //取得表视图的偏移量
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY <= 0) {
        //计算放大倍数
       CGFloat scale = (160+ABS(offsetY))/160;
        _bgIconView.transform = CGAffineTransformMakeScale(scale, scale);
        _bgIconView.top = 0;
    }else {
        
        _bgIconView.top = -offsetY;

    }
    
    //使titleLabel与headerImgView底部重合
    //    _titleLabel.bottom = _headerImgView.bottom;
}
@end

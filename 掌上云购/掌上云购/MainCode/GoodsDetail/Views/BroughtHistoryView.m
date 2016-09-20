//
//  BroughtHistoryView.m
//  掌上云购
//
//  Created by coco船长 on 16/8/18.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import "BroughtHistoryView.h"

@implementation BroughtHistoryView

- (instancetype)init{
    
    self = [super init];
    if (self) {
        [self initView];
    }
    return self;
    
}

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
    
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initView];
    }
    return self;
    
}

- (void)initView{

    _recommandLabel = [[UILabel  alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 28)];
    _recommandLabel.backgroundColor = [UIColor whiteColor];
    _recommandLabel.text = @"所有参赛记录(2016-08-10 10-34-24开始)";
    _recommandLabel.font = [UIFont systemFontOfSize:13];
    _recommandLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_recommandLabel];
    
    _recordTable = [[UITableView alloc] initWithFrame:CGRectMake(0, _recommandLabel.bottom, self.width, self.height - _recommandLabel.height)];
    _recordTable.delegate = self;
    _recordTable.dataSource = self;
    [_recordTable registerNib:[UINib nibWithNibName:@"BroughtHistoryCell"
                                             bundle:[NSBundle mainBundle]]
       forCellReuseIdentifier:@"BroughtHistory_Cell"];
    _recordTable.mj_header = [MJRefreshHeader headerWithRefreshingBlock:^{
        if ([_BHdelegate respondsToSelector:@selector(pullBack)]) {
            [_BHdelegate pullBack];
            [_recordTable.mj_header endRefreshing];
        }
    }];
    [self addSubview:_recordTable];
    
    _dataArr = [NSArray array];
    
}

#pragma mark - 重写set方法
- (void)setDataArr:(NSArray *)dataArr{

    if (_dataArr != dataArr) {
        
        _dataArr = dataArr;
        [_recordTable reloadData];
        
    }
    
}

#pragma mark - UITableViewDelegate,UItableViewDatasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _dataArr.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    BroughtHistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BroughtHistory_Cell"
                                                                forIndexPath:indexPath];
    NSDictionary *dic = [_dataArr objectAtIndex:indexPath.row];
    if (![[dic objectForKey:@"photoUrl"] isKindOfClass:[NSNull class]]) {
        [cell.headPic setImageWithURL:[NSURL URLWithString:dic[@"photoUrl"]] placeholderImage:[UIImage imageNamed:@"我的-头像"]];
    }else{
        [cell.headPic setImage:[UIImage imageNamed:@"我的-头像"]];
    }
    
    if (![[dic objectForKey:@"nickName"] isKindOfClass:[NSNull class]]) {
        
        cell.userName.text = [dic objectForKey:@"nickName"];
    }else{
        cell.userName.text = @"名字消失在了二次元空间";
    }

    cell.joinTimes.text = [NSString stringWithFormat:@"参与了:%@次",[dic objectForKey:@"qty"]];
    cell.userIP.text = [NSString stringWithFormat:@"ip：%@",[dic objectForKey:@"buyIp"]];
    
    return cell;
    
}

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//
//    return 24.f;
//    
//}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 88.f;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    NSLogZS(@"点击了第%ld个单元格",(long)indexPath.row);
    
}

#pragma mark - 监听渲染事件
//- (void)layoutSubviews{
//
//    [super layoutSubviews];
//
//}

@end

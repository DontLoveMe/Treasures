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
    
}

#pragma mark - UITableViewDelegate,UItableViewDatasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 3;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 4;
    
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UILabel *headLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 24.f)];
    headLabel.text = @"2016-08-01";
    headLabel.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.3];
    headLabel.textAlignment = NSTextAlignmentLeft;
    headLabel.font = [UIFont systemFontOfSize:14];
    return headLabel;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    BroughtHistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BroughtHistory_Cell"
                                                                forIndexPath:indexPath];
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 24.f;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 88.f;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    NSLogZS(@"点击了第%ld个单元格",indexPath.row);
    
}

#pragma mark - 监听渲染事件
//- (void)layoutSubviews{
//
//    [super layoutSubviews];
//
//}

@end

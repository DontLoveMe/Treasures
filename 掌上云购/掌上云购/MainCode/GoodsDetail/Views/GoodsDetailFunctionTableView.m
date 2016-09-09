//
//  GoodsDetailFunctionTableView.m
//  掌上云购
//
//  Created by coco船长 on 16/8/16.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import "GoodsDetailFunctionTableView.h"

@implementation GoodsDetailFunctionTableView

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

    self.delegate = self;
    self.dataSource = self;
    
    self.scrollEnabled = NO;
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}

////重写set方法
//- (void)setProgress:(NSInteger)progress{
//
//    if (_progress != progress) {
//        
//        _progress = progress;
//        [self reloadData];
//        
//    }
//
//}

- (void)setDataDic:(NSDictionary *)dataDic{

    if (_dataDic != dataDic) {
        
        _dataDic = dataDic;
        [self reloadData];
        
    }

}

#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 4;
    
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (_dataDic == nil) {
        return nil;
    }
    
    if (_isAnnounced == 1) {
        
        //购买相关
        UIView  *goodsDetailView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 100.f)];
        goodsDetailView.backgroundColor = [UIColor whiteColor];
        //标语
        UILabel *siloganLabel = [[UILabel alloc] initWithFrame:CGRectMake(8.f, 8.f, KScreenWidth - 16.f, 20.f)];
        siloganLabel.text = @"只要参与，就有机遇";
        siloganLabel.textAlignment = NSTextAlignmentLeft;
        siloganLabel.font = [UIFont systemFontOfSize:13];
        siloganLabel.textColor = [UIColor darkGrayColor];
        [goodsDetailView addSubview:siloganLabel];
        
        //期号
        UILabel *issueLabel = [[UILabel alloc] initWithFrame:CGRectMake(8.f, siloganLabel.bottom + 4.f, KScreenWidth - 16.f, 20.f)];
        issueLabel.text = [NSString stringWithFormat:@"本期期号：%@",[_dataDic objectForKey:@"drawTimes"]];
        issueLabel.textAlignment = NSTextAlignmentLeft;
        issueLabel.font = [UIFont systemFontOfSize:13];
        issueLabel.textColor = [UIColor redColor];
        [goodsDetailView addSubview:issueLabel];
        
        //进度条
        ProgressView *progressImg = [[ProgressView alloc] initWithFrame:CGRectMake(8.f, issueLabel.bottom + 4, (KScreenWidth - 18.f) / 2, 8.f)];
        NSInteger total =  [[_dataDic objectForKey:@"totalShare"] integerValue];
        NSInteger now = [[_dataDic objectForKey:@"sellShare"] integerValue];
        progressImg.progress = now * 100 / total ;
        [goodsDetailView addSubview:progressImg];
        
        if (_isJoin == 0) {
            
            UILabel *noJoinLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, progressImg.bottom + 4.f, KScreenWidth, 20.f)];
            noJoinLabel.backgroundColor = [UIColor colorWithWhite:0.7 alpha:1];
            noJoinLabel.textAlignment = NSTextAlignmentCenter;
            noJoinLabel.font = [UIFont systemFontOfSize:13];
            noJoinLabel.text = @"你还未参与本商品夺宝";
            noJoinLabel.textColor = [UIColor darkGrayColor];
            [goodsDetailView addSubview:noJoinLabel];
            
        }else if (_isJoin == 1){
            
            UILabel *JoinedLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, progressImg.bottom + 4.f, KScreenWidth, 20.f)];
            JoinedLabel.backgroundColor = [UIColor colorWithWhite:0.7 alpha:1];
            JoinedLabel.textAlignment = NSTextAlignmentLeft;
            JoinedLabel.font = [UIFont systemFontOfSize:13];
            JoinedLabel.text = @"你参与了：782次";
            JoinedLabel.textColor = [UIColor darkGrayColor];
            [goodsDetailView addSubview:JoinedLabel];
            
            UILabel *treasureNum = [[UILabel alloc] initWithFrame:CGRectMake(0, JoinedLabel.bottom, KScreenWidth, 20.f)];
            treasureNum.backgroundColor = [UIColor colorWithWhite:0.7 alpha:1];
            treasureNum.textAlignment = NSTextAlignmentLeft;
            treasureNum.font = [UIFont systemFontOfSize:13];
            treasureNum.text = [NSString stringWithFormat:@"夺宝号码:%@",[_dataDic objectForKey:@"buyNumbers"]];
            treasureNum.textColor = [UIColor darkGrayColor];
            [goodsDetailView addSubview:treasureNum];
            
            UIButton *previewAllButton = [[UIButton alloc] initWithFrame:CGRectMake(KScreenWidth - 72.f, progressImg.bottom + 8.f, 64.f, 32.f)];
            [previewAllButton setTitle:@"查看全部"
                              forState:UIControlStateNormal];
            previewAllButton.titleLabel.font = [UIFont systemFontOfSize:13];
            [previewAllButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
            previewAllButton.backgroundColor = [UIColor whiteColor];
            [previewAllButton addTarget:self
                                 action:@selector(previewAll:)
                       forControlEvents:UIControlEventTouchUpInside];
            [goodsDetailView addSubview:previewAllButton];
            
        }
        return  goodsDetailView;
        
    }else if(_isAnnounced == 2){
    
        //开奖相关
        UIView  *goodsDetailView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 100.f)];
        goodsDetailView.backgroundColor = [UIColor whiteColor];
        
        //期号
        UILabel *issueLabel = [[UILabel alloc] initWithFrame:CGRectMake(8.f, 8.f, KScreenWidth - 16.f, 20.f)];
        issueLabel.text = [NSString stringWithFormat:@"本期期号：%@",[_dataDic objectForKey:@"drawTimes"]];
        issueLabel.textAlignment = NSTextAlignmentLeft;
        issueLabel.font = [UIFont systemFontOfSize:13];
        issueLabel.textColor = [UIColor darkGrayColor];
        [goodsDetailView addSubview:issueLabel];
        
        UILabel *countDownLabel = [[UILabel alloc] initWithFrame:CGRectMake(8.f, issueLabel.bottom + 4.f, KScreenWidth - 16.f, 20.f)];
        countDownLabel.text = [NSString stringWithFormat:@"预计揭晓时间：%@",[_dataDic objectForKey:@"countdownEndDate"]];
        countDownLabel.textAlignment = NSTextAlignmentLeft;
        countDownLabel.font = [UIFont systemFontOfSize:13];
        countDownLabel.textColor = [UIColor redColor];
        [goodsDetailView addSubview:countDownLabel];
        
        UIButton *previewCountWayButton = [[UIButton alloc] initWithFrame:CGRectMake(KScreenWidth - 72.f, 8.f, 64.f, 32.f)];
        [previewCountWayButton setTitle:@"计算方式"
                          forState:UIControlStateNormal];
        previewCountWayButton.titleLabel.font = [UIFont systemFontOfSize:13];
        [previewCountWayButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        previewCountWayButton.backgroundColor = [UIColor whiteColor];
        [previewCountWayButton addTarget:self
                                  action:@selector(countWayAction:)
                        forControlEvents:UIControlEventTouchUpInside];
        [goodsDetailView addSubview:previewCountWayButton];
        
        if (_isJoin == 0) {
            
            UILabel *noJoinLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, countDownLabel.bottom + 4.f, KScreenWidth, 20.f)];
            noJoinLabel.backgroundColor = [UIColor colorWithWhite:0.7 alpha:1];
            noJoinLabel.textAlignment = NSTextAlignmentCenter;
            noJoinLabel.font = [UIFont systemFontOfSize:13];
            noJoinLabel.text = @"你还未参与本商品夺宝";
            noJoinLabel.textColor = [UIColor darkGrayColor];
            [goodsDetailView addSubview:noJoinLabel];
            
        }else if (_isJoin == 1){
            
            UILabel *JoinedLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, countDownLabel.bottom + 4.f, KScreenWidth, 20.f)];
            JoinedLabel.backgroundColor = [UIColor colorWithWhite:0.7 alpha:1];
            JoinedLabel.textAlignment = NSTextAlignmentLeft;
            JoinedLabel.font = [UIFont systemFontOfSize:13];
            JoinedLabel.text = @"你参与了：782次";
            JoinedLabel.textColor = [UIColor darkGrayColor];
            [goodsDetailView addSubview:JoinedLabel];
            
            UILabel *treasureNum = [[UILabel alloc] initWithFrame:CGRectMake(0, JoinedLabel.bottom, KScreenWidth, 20.f)];
            treasureNum.backgroundColor = [UIColor colorWithWhite:0.7 alpha:1];
            treasureNum.textAlignment = NSTextAlignmentLeft;
            treasureNum.font = [UIFont systemFontOfSize:13];
            treasureNum.text = [NSString stringWithFormat:@"夺宝号码:%@",[_dataDic objectForKey:@"buyNumbers"]];
            treasureNum.textColor = [UIColor darkGrayColor];
            [goodsDetailView addSubview:treasureNum];
            
            UIButton *previewAllButton = [[UIButton alloc] initWithFrame:CGRectMake(KScreenWidth - 72.f, countDownLabel.bottom + 8.f, 64.f, 32.f)];
            [previewAllButton setTitle:@"查看全部"
                              forState:UIControlStateNormal];
            previewAllButton.titleLabel.font = [UIFont systemFontOfSize:13];
            [previewAllButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
            previewAllButton.backgroundColor = [UIColor whiteColor];
            [previewAllButton addTarget:self
                                 action:@selector(previewAll:)
                       forControlEvents:UIControlEventTouchUpInside];
            [goodsDetailView addSubview:previewAllButton];
            
        }
        return  goodsDetailView;
        
    }else if (_isAnnounced == 3){
        
        NSDictionary *prizeDic = [_dataDic objectForKey:@"saleDraw"];
        if ([prizeDic isEqual:[NSNull null]]) {
            return nil;
        }
        //开奖相关
        UIView  *goodsDetailView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 100.f)];
        goodsDetailView.backgroundColor = [UIColor whiteColor];
        
        //获奖者name
        UILabel *prizeNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(8.f, 8.f, KScreenWidth - 16.f, 20.f)];
        prizeNameLabel.text = [NSString stringWithFormat:@"获奖者:%@",[prizeDic objectForKey:@"nickName"]];
        prizeNameLabel.textAlignment = NSTextAlignmentLeft;
        prizeNameLabel.font = [UIFont systemFontOfSize:13];
        prizeNameLabel.textColor = [UIColor redColor];
        [goodsDetailView addSubview:prizeNameLabel];
        
        //获奖者id
        UILabel *prizeIdLabel = [[UILabel alloc] initWithFrame:CGRectMake(8.f, prizeNameLabel.bottom, KScreenWidth - 16.f, 20.f)];
        prizeIdLabel.text = [NSString stringWithFormat:@"获奖者ID:%@",[prizeDic objectForKey:@"drawNumber"]];
        prizeIdLabel.textAlignment = NSTextAlignmentLeft;
        prizeIdLabel.font = [UIFont systemFontOfSize:13];
        prizeIdLabel.textColor = [UIColor darkGrayColor];
        [goodsDetailView addSubview:prizeIdLabel];
        
        //期号
        UILabel *issueLabel = [[UILabel alloc] initWithFrame:CGRectMake(8.f, prizeIdLabel.bottom, KScreenWidth - 16.f, 20.f)];
        issueLabel.text = [NSString stringWithFormat:@"本期期号：%@",[_dataDic objectForKey:@"drawTimes"]];
        issueLabel.textAlignment = NSTextAlignmentLeft;
        issueLabel.font = [UIFont systemFontOfSize:13];
        issueLabel.textColor = [UIColor darkGrayColor];
        [goodsDetailView addSubview:issueLabel];
        
        //参与次数
        UILabel *joinCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(8.f, issueLabel.bottom, KScreenWidth - 16.f, 20.f)];
        joinCountLabel.text = [NSString stringWithFormat:@"本期参与：%ld",[[prizeDic objectForKey:@"qty"] integerValue]];
        joinCountLabel.textAlignment = NSTextAlignmentLeft;
        joinCountLabel.font = [UIFont systemFontOfSize:13];
        joinCountLabel.textColor = [UIColor darkGrayColor];
        [goodsDetailView addSubview:joinCountLabel];
        
        //揭晓时间
        UILabel *countDownLabel = [[UILabel alloc] initWithFrame:CGRectMake(8.f, joinCountLabel.bottom + 4.f, KScreenWidth - 16.f, 20.f)];
        countDownLabel.text = [NSString stringWithFormat:@"揭晓时间：%@",[_dataDic objectForKey:@"countdownEndDate"]];
        countDownLabel.textAlignment = NSTextAlignmentLeft;
        countDownLabel.font = [UIFont systemFontOfSize:13];
        countDownLabel.textColor = [UIColor redColor];
        [goodsDetailView addSubview:countDownLabel];
        
        //幸运号码
        UILabel *luckyNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(8.f, countDownLabel.bottom, KScreenWidth - 16.f, 20.f)];
        luckyNumLabel.text =[NSString stringWithFormat:@"幸运号码：%@",[prizeDic objectForKey:@"drawNumber"]];
        luckyNumLabel.textAlignment = NSTextAlignmentLeft;
        luckyNumLabel.font = [UIFont systemFontOfSize:13];
        luckyNumLabel.textColor = [UIColor redColor];
        [goodsDetailView addSubview:luckyNumLabel];
        
        //查看计算方式
        UIButton *previewCountWayButton = [[UIButton alloc] initWithFrame:CGRectMake(KScreenWidth - 72.f,countDownLabel.bottom - 28.f, 64.f, 20.f)];
        [previewCountWayButton setTitle:@"计算详情"
                               forState:UIControlStateNormal];
        previewCountWayButton.titleLabel.font = [UIFont systemFontOfSize:13];
        [previewCountWayButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        previewCountWayButton.backgroundColor = [UIColor whiteColor];
        [previewCountWayButton addTarget:self
                                  action:@selector(countWayAction:)
                        forControlEvents:UIControlEventTouchUpInside];
        [goodsDetailView addSubview:previewCountWayButton];
        
        if (_isJoin == 0) {
            
            UILabel *noJoinLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, countDownLabel.bottom + 4.f, KScreenWidth, 20.f)];
            noJoinLabel.backgroundColor = [UIColor colorWithWhite:0.7 alpha:1];
            noJoinLabel.textAlignment = NSTextAlignmentCenter;
            noJoinLabel.font = [UIFont systemFontOfSize:13];
            noJoinLabel.text = @"你还未参与本商品夺宝";
            noJoinLabel.textColor = [UIColor darkGrayColor];
            [goodsDetailView addSubview:noJoinLabel];
            
        }else if (_isJoin == 1){
            
            UILabel *JoinedLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, countDownLabel.bottom + 4.f, KScreenWidth, 20.f)];
            JoinedLabel.backgroundColor = [UIColor colorWithWhite:0.7 alpha:1];
            JoinedLabel.textAlignment = NSTextAlignmentLeft;
            JoinedLabel.font = [UIFont systemFontOfSize:13];
            JoinedLabel.text = @"你参与了：782次";
            JoinedLabel.textColor = [UIColor darkGrayColor];
            [goodsDetailView addSubview:JoinedLabel];
            
            UILabel *treasureNum = [[UILabel alloc] initWithFrame:CGRectMake(0, JoinedLabel.bottom, KScreenWidth, 20.f)];
            treasureNum.backgroundColor = [UIColor colorWithWhite:0.7 alpha:1];
            treasureNum.textAlignment = NSTextAlignmentLeft;
            treasureNum.font = [UIFont systemFontOfSize:13];
            treasureNum.text = [NSString stringWithFormat:@"夺宝号码:%@",[_dataDic objectForKey:@"buyNumbers"]];
            treasureNum.textColor = [UIColor darkGrayColor];
            [goodsDetailView addSubview:treasureNum];
            
            UIButton *previewAllButton = [[UIButton alloc] initWithFrame:CGRectMake(KScreenWidth - 72.f, countDownLabel.bottom + 8.f, 64.f, 32.f)];
            [previewAllButton setTitle:@"查看全部"
                              forState:UIControlStateNormal];
            previewAllButton.titleLabel.font = [UIFont systemFontOfSize:13];
            [previewAllButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
            previewAllButton.backgroundColor = [UIColor whiteColor];
            [previewAllButton addTarget:self
                                 action:@selector(previewAll:)
                       forControlEvents:UIControlEventTouchUpInside];
            [goodsDetailView addSubview:previewAllButton];
            
        }
            
        return  goodsDetailView;
    }
    
    return nil;
    
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    if (indexPath.row != 3) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }else{
        cell.textLabel.font = [UIFont systemFontOfSize:13];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
    }
    NSArray *titleArr = @[@"图文详情",@"往期揭晓",@"晒单分享",@"参与记录(上滑)"];
    cell.textLabel.text = titleArr[indexPath.row];
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    if (_isAnnounced == 1) {
        
        if (_isJoin == 0) {
            
            return  92.f;
            
        }else if (_isJoin == 1){
            
            return 118.f;
            
        }
        
    }else if (_isAnnounced == 2){
    
        if (_isJoin == 0) {
            
            return  84.f;
            
        }else if (_isJoin == 1){
            
            return 104.f;
            
        }
    
    }else if (_isAnnounced == 3){
    
        if (_isJoin == 0) {
            
            return 132.f;
            
        }else if(_isJoin == 1){
        
            return 152.f;
        }
        
    }
    
    return 0;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 44;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (indexPath.row == 0) {
        
        //图文详情
        GoodsDetailPTController *GDPTVC = [[GoodsDetailPTController alloc] init];
        GDPTVC.goodsId = [_dataDic objectForKey:@"id"];
        GDPTVC.hidesBottomBarWhenPushed = YES;
        [[self viewController].navigationController pushViewController:GDPTVC
                                                              animated:YES];
        
    }else if (indexPath.row == 1) {
        
        //往期揭晓
        AnnouncedHistoryController *AHVC = [[AnnouncedHistoryController alloc]init];
        AHVC.hidesBottomBarWhenPushed = YES;
        AHVC.goodsID = [_dataDic objectForKey:@"id"];
        AHVC.hidesBottomBarWhenPushed = YES;
        [[self viewController].navigationController pushViewController:AHVC
                                                              animated:YES];
        
    }else if (indexPath.row == 2) {
        
        //晒单分享
        SunSharingViewController *VC = [[SunSharingViewController alloc]init];
        VC.hidesBottomBarWhenPushed = YES;
        VC.productID = [_dataDic objectForKey:@"id"];
        [[self viewController].navigationController pushViewController:VC animated:YES];
    
    }else if (indexPath.row == 3) {
        NSLogZS(@"请上拉");
    }else{
        NSLogZS(@"点击了第%ld个单元格",(long)indexPath.row);
    }
    
}


#pragma mark - functionButtonAction
- (void)countWayAction:(UIButton *)button{

    NSLogZS(@"查看计算方法了");
    CountWayController *CWVC = [[CountWayController alloc] init];
    CWVC.isAnnounced = _isAnnounced;
    [[self viewController].navigationController pushViewController:CWVC
                                                          animated:YES];

}

- (void)previewAll:(UIButton *)button{

    NSLogZS(@"点击查看全部了");
    PreviewAllController *PAVC = [[PreviewAllController alloc] init];
    PAVC.dataDic = _dataDic;
    [[self viewController].navigationController pushViewController:PAVC
                                                          animated:YES];
    
}

//取到视图控制器
- (UIViewController *)viewController {
    
    UIResponder *next = self.nextResponder;
    
    do {
        
        if ([next isKindOfClass:[UIViewController class]]) {
            
            return (UIViewController *)next;
        }
        
        next = next.nextResponder;
        
    } while (next != nil);
    
    return nil;
}

@end

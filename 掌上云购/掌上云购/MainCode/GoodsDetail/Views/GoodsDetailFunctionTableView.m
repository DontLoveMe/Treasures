//
//  GoodsDetailFunctionTableView.m
//  掌上云购
//
//  Created by coco船长 on 16/8/16.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import "GoodsDetailFunctionTableView.h"
#import "HisIconImageView.h"

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
    self.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
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
        siloganLabel.text = @"赶快加入夺宝吧，万一中了呢？";
        siloganLabel.textAlignment = NSTextAlignmentLeft;
        siloganLabel.font = [UIFont systemFontOfSize:13];
        siloganLabel.textColor = [UIColor darkGrayColor];
        [goodsDetailView addSubview:siloganLabel];
        
        //期号
        UILabel *issueLabel = [[UILabel alloc] initWithFrame:CGRectMake(8.f, siloganLabel.bottom + 4.f, KScreenWidth - 16.f, 20.f)];
        issueLabel.text = [NSString stringWithFormat:@"期号：%@",[_dataDic objectForKey:@"drawTimes"]];
        issueLabel.textAlignment = NSTextAlignmentLeft;
        issueLabel.font = [UIFont systemFontOfSize:13];
        issueLabel.textColor = [UIColor darkGrayColor];
        [goodsDetailView addSubview:issueLabel];
        
        //进度条
        ProgressView *progressImg = [[ProgressView alloc] initWithFrame:CGRectMake(8.f, issueLabel.bottom + 4, KScreenWidth - 18.f, 8.f)];
        NSInteger total =  [[_dataDic objectForKey:@"totalShare"] integerValue];
        NSInteger now = [[_dataDic objectForKey:@"sellShare"] integerValue];
        progressImg.progress = now * 100 / total ;
        [goodsDetailView addSubview:progressImg];
        
        //总需人次
        UILabel *totalLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, progressImg.bottom+8, 150, 13)];
        totalLabel.text = [NSString stringWithFormat:@"总需人次：%@",_dataDic[@"totalShare"]];
        totalLabel.textColor = [UIColor darkGrayColor];
        totalLabel.textAlignment = NSTextAlignmentLeft;
        totalLabel.font = [UIFont systemFontOfSize:13];
        [goodsDetailView addSubview:totalLabel];
        
        //剩余人次
        UILabel *surplusLabel = [[UILabel alloc] initWithFrame:CGRectMake(KScreenWidth-150, progressImg.bottom+8, 142, 13)];
        surplusLabel.text = [NSString stringWithFormat:@"剩余人次：%@",_dataDic[@"surplusShare"]];
        surplusLabel.textColor = [UIColor colorFromHexRGB:ThemeColor];
        surplusLabel.textAlignment = NSTextAlignmentRight;
        surplusLabel.font = [UIFont systemFontOfSize:13];
        [goodsDetailView addSubview:surplusLabel];
        
        //横线
        UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(0, totalLabel.bottom + 8.f, KScreenWidth, 1)];
        line.image = [UIImage imageNamed:@"横线"];
        [goodsDetailView addSubview:line];
        
        
        if (_isJoin == 0) {
            //未参与背景
            UIImageView *lbBgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, line.bottom + 4.f, KScreenWidth-20, 20.f)];
            lbBgView.image = [UIImage imageNamed:@"Label背景"];
             [goodsDetailView addSubview:lbBgView];
            
            UILabel *noJoinLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, line.bottom + 4.f, KScreenWidth, 20.f)];
//            noJoinLabel.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
            noJoinLabel.textAlignment = NSTextAlignmentCenter;
            noJoinLabel.font = [UIFont systemFontOfSize:13];
            noJoinLabel.text = @"你还未参与本商品夺宝";
            noJoinLabel.textColor = [UIColor darkGrayColor];
            [goodsDetailView addSubview:noJoinLabel];
            
        }else if (_isJoin == 1){
            
            //黄色背景
            UIImageView *lbBgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, line.bottom + 7.f, KScreenWidth, 42.f)];
            lbBgView.image = [UIImage imageNamed:@"背景长黄"];
            [goodsDetailView addSubview:lbBgView];
            
            UILabel *JoinedLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, line.bottom + 8.f, KScreenWidth- 72.f, 20.f)];
            JoinedLabel.backgroundColor = [UIColor clearColor];
            JoinedLabel.textAlignment = NSTextAlignmentLeft;
            JoinedLabel.font = [UIFont systemFontOfSize:13];
            JoinedLabel.text = [NSString stringWithFormat:@"  你参与了:%@人次",[_dataDic objectForKey:@"buyNumberCount"]];
            JoinedLabel.textColor = [UIColor whiteColor];
            [goodsDetailView addSubview:JoinedLabel];
            
            UILabel *treasureNum = [[UILabel alloc] initWithFrame:CGRectMake(0, JoinedLabel.bottom, KScreenWidth- 72.f, 20.f)];
            treasureNum.backgroundColor = [UIColor clearColor];
            treasureNum.textAlignment = NSTextAlignmentLeft;
            treasureNum.font = [UIFont systemFontOfSize:13];
            treasureNum.text = [NSString stringWithFormat:@"  夺宝号码:%@",[_dataDic objectForKey:@"buyNumbers"]];
            treasureNum.textColor = [UIColor whiteColor];
            [goodsDetailView addSubview:treasureNum];
            
            UIButton *previewAllButton = [[UIButton alloc] initWithFrame:CGRectMake(KScreenWidth - 72.f, line.bottom + 14.f, 64.f, 28.f)];
            [previewAllButton setTitle:@"查看全部"
                              forState:UIControlStateNormal];
            previewAllButton.titleLabel.font = [UIFont systemFontOfSize:13];
            [previewAllButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [previewAllButton setBackgroundImage:[UIImage imageNamed:@"按钮框-白"] forState:UIControlStateNormal];
            previewAllButton.backgroundColor = [UIColor clearColor];
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
        
        //黄色背景
        UIImageView *lbBgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 7.f, KScreenWidth, 42.f)];
        lbBgView.image = [UIImage imageNamed:@"背景长黄"];
        [goodsDetailView addSubview:lbBgView];
        //期号
        UILabel *issueLabel = [[UILabel alloc] initWithFrame:CGRectMake(8.f, 8.f, KScreenWidth - 80.f, 20.f)];
        issueLabel.text = [NSString stringWithFormat:@"期号：%@",[_dataDic objectForKey:@"drawTimes"]];
        issueLabel.textAlignment = NSTextAlignmentLeft;
        issueLabel.font = [UIFont systemFontOfSize:13];
        issueLabel.textColor = [UIColor whiteColor];
        issueLabel.backgroundColor = [UIColor clearColor];
        [goodsDetailView addSubview:issueLabel];
        
        _countDownLabel = [[UILabel alloc] initWithFrame:CGRectMake(8.f, issueLabel.bottom, KScreenWidth - 80.f, 20.f)];
//        _countDownLabel.text = [NSString stringWithFormat:@"预计揭晓时间：%@",[_dataDic objectForKey:@"countdownEndDate"]];
        _countDownLabel.textAlignment = NSTextAlignmentLeft;
        _countDownLabel.font = [UIFont systemFontOfSize:13];
        _countDownLabel.textColor = [UIColor whiteColor];
        _countDownLabel.backgroundColor = [UIColor clearColor];
        [goodsDetailView addSubview:_countDownLabel];
        
        if (![[_dataDic objectForKey:@"countdownTime"] isKindOfClass:[NSNull class]]) {
            
            self.countDownTime = [[_dataDic objectForKey:@"countdownTime"] integerValue];
        }
        
        UIButton *previewCountWayButton = [[UIButton alloc] initWithFrame:CGRectMake(KScreenWidth - 72.f, 15.f, 64.f, 28.f)];
        [previewCountWayButton setTitle:@"计算详情"
                          forState:UIControlStateNormal];
        previewCountWayButton.titleLabel.font = [UIFont systemFontOfSize:13];
        [previewCountWayButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        previewCountWayButton.backgroundColor = [UIColor clearColor];
        [previewCountWayButton setBackgroundImage:[UIImage imageNamed:@"按钮框-白"] forState:UIControlStateNormal];
        [previewCountWayButton addTarget:self
                                  action:@selector(countWayAction:)
                        forControlEvents:UIControlEventTouchUpInside];
        [goodsDetailView addSubview:previewCountWayButton];
        
        if (_isJoin == 0) {
            
            UILabel *noJoinLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, _countDownLabel.bottom + 4.f, KScreenWidth, 20.f)];
            noJoinLabel.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
            noJoinLabel.textAlignment = NSTextAlignmentCenter;
            noJoinLabel.font = [UIFont systemFontOfSize:13];
            noJoinLabel.text = @"你还未参与本商品夺宝";
            noJoinLabel.textColor = [UIColor darkGrayColor];
            [goodsDetailView addSubview:noJoinLabel];
            
        }else if (_isJoin == 1){
            
            UILabel *JoinedLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, _countDownLabel.bottom + 4.f, KScreenWidth-80, 20.f)];
//            JoinedLabel.backgroundColor = [UIColor orangeColor];
            JoinedLabel.textAlignment = NSTextAlignmentLeft;
            JoinedLabel.font = [UIFont systemFontOfSize:13];
            JoinedLabel.text = [NSString stringWithFormat:@"你参与了:%@",[_dataDic objectForKey:@"buyNumberCount"]];
            JoinedLabel.textColor = [UIColor darkGrayColor];
            [goodsDetailView addSubview:JoinedLabel];
            
            UILabel *treasureNum = [[UILabel alloc] initWithFrame:CGRectMake(8, JoinedLabel.bottom, KScreenWidth-80, 20.f)];
            treasureNum.backgroundColor = [UIColor clearColor];
            treasureNum.textAlignment = NSTextAlignmentLeft;
            treasureNum.font = [UIFont systemFontOfSize:13];
            treasureNum.text = [NSString stringWithFormat:@"夺宝号码:%@",[_dataDic objectForKey:@"buyNumbers"]];
            treasureNum.textColor = [UIColor darkGrayColor];
            [goodsDetailView addSubview:treasureNum];
            
            UIButton *previewAllButton = [[UIButton alloc] initWithFrame:CGRectMake(KScreenWidth - 72.f, _countDownLabel.bottom + 8.f, 64.f, 32.f)];
            [previewAllButton setTitle:@"查看全部"
                              forState:UIControlStateNormal];
            previewAllButton.titleLabel.font = [UIFont systemFontOfSize:13];
            [previewAllButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            previewAllButton.backgroundColor = [UIColor clearColor];
            [previewAllButton setBackgroundImage:[UIImage imageNamed:@"按钮背景"] forState:UIControlStateNormal];
            [previewAllButton addTarget:self
                                 action:@selector(previewAll:)
                       forControlEvents:UIControlEventTouchUpInside];
            [goodsDetailView addSubview:previewAllButton];
            //s横线
            UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(0, previewAllButton.bottom + 4.f, KScreenWidth, 10.f)];
            //            line.image = [UIImage imageNamed:@"横线"];
            line.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
            [goodsDetailView addSubview:line];
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
        
        //s横线
        UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 1)];
        line.image = [UIImage imageNamed:@"横线"];
        [goodsDetailView addSubview:line];
        
        //图片
        HisIconImageView *picView = [[HisIconImageView alloc] initWithFrame:CGRectMake(8, 16, 75, 75)];
        picView.layer.cornerRadius = 75/2;
        picView.layer.masksToBounds = YES;
        NSDictionary *saleDraw = _dataDic[@"saleDraw"];
        picView.buyUserId = [saleDraw[@"drawUserId"] integerValue];
        if (![saleDraw[@"photoUrl"] isKindOfClass:[NSNull class]]) {
            NSString *photoUrl = saleDraw[@"photoUrl"];
            NSURL *imgUrl;
            if ([photoUrl hasPrefix:@"http"]) {
                imgUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@",saleDraw[@"photoUrl"]]];
            }else{
               imgUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",AliyunPIC_URL,saleDraw[@"photoUrl"]]];
            }

            [picView setImageWithURL:imgUrl placeholderImage:[UIImage imageNamed:@"我的-头像"]];
        }else {
            
            picView.image = [UIImage imageNamed:@"未加载图片"];
        }
        [goodsDetailView addSubview:picView];
        
        //图片
        UIImageView *luckyView = [[UIImageView alloc] initWithFrame:CGRectMake(KScreenWidth-88, 8, 70, 70)];
        luckyView.image = [UIImage imageNamed:@"幸运标识"];
        luckyView.alpha = 0.5;
        [goodsDetailView addSubview:luckyView];
        
        
        //获奖者name
        UILabel *prizeNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(picView.right+8.f, 8.f, KScreenWidth - 86.f, 20.f)];
        prizeNameLabel.text = [NSString stringWithFormat:@"获奖者:%@",[prizeDic objectForKey:@"nickName"]];
        prizeNameLabel.textAlignment = NSTextAlignmentLeft;
        prizeNameLabel.font = [UIFont boldSystemFontOfSize:13];
        prizeNameLabel.textColor = [UIColor blackColor];
        [goodsDetailView addSubview:prizeNameLabel];
        
        //获奖者id
        UILabel *prizeIdLabel = [[UILabel alloc] initWithFrame:CGRectMake(picView.right+8.f, prizeNameLabel.bottom, KScreenWidth - 86.f, 20.f)];
        prizeIdLabel.text = [NSString stringWithFormat:@"获奖者ID:%@",[prizeDic objectForKey:@"drawUserId"]];
        prizeIdLabel.textAlignment = NSTextAlignmentLeft;
        prizeIdLabel.font = [UIFont systemFontOfSize:13];
        prizeIdLabel.textColor = [UIColor darkGrayColor];
        [goodsDetailView addSubview:prizeIdLabel];
        
        //期号
        UILabel *issueLabel = [[UILabel alloc] initWithFrame:CGRectMake(picView.right+8.f, prizeIdLabel.bottom, KScreenWidth - 86.f, 20.f)];
        issueLabel.text = [NSString stringWithFormat:@"本期期号：%@",[_dataDic objectForKey:@"drawTimes"]];
        issueLabel.textAlignment = NSTextAlignmentLeft;
        issueLabel.font = [UIFont systemFontOfSize:13];
        issueLabel.textColor = [UIColor darkGrayColor];
        [goodsDetailView addSubview:issueLabel];
        
        //参与次数
        UILabel *joinCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(picView.right+8.f, issueLabel.bottom, KScreenWidth - 86.f, 20.f)];
        joinCountLabel.text = [NSString stringWithFormat:@"本期参与：%ld",[[prizeDic objectForKey:@"qty"] integerValue]];
        joinCountLabel.textAlignment = NSTextAlignmentLeft;
        joinCountLabel.font = [UIFont systemFontOfSize:13];
        joinCountLabel.textColor = [UIColor darkGrayColor];
        [goodsDetailView addSubview:joinCountLabel];

        //揭晓时间
        UILabel *countDownLabel = [[UILabel alloc] initWithFrame:CGRectMake(picView.right+8.f, joinCountLabel.bottom, KScreenWidth - 76.f, 20.f)];
        countDownLabel.text = [NSString stringWithFormat:@"揭晓时间：%@",[_dataDic objectForKey:@"countdownEndDate"]];
        countDownLabel.textAlignment = NSTextAlignmentLeft;
        countDownLabel.font = [UIFont systemFontOfSize:13];
        countDownLabel.textColor = [UIColor darkGrayColor];
        [goodsDetailView addSubview:countDownLabel];
        
        //幸运号码背景
        UIImageView *lkBgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, countDownLabel.bottom + 8.f, KScreenWidth-20, 50.f)];
        lkBgView.image = [UIImage imageNamed:@"幸运号码背景"];
        [goodsDetailView addSubview:lkBgView];
        
        //幸运号码
        UILabel *luckyNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(16.f, countDownLabel.bottom+24, KScreenWidth - 16.f, 20.f)];
        luckyNumLabel.text =[NSString stringWithFormat:@"幸运号码：%@",[prizeDic objectForKey:@"drawNumber"]];
        luckyNumLabel.textAlignment = NSTextAlignmentLeft;
        luckyNumLabel.font = [UIFont systemFontOfSize:13];
        luckyNumLabel.textColor = [UIColor whiteColor];
        [goodsDetailView addSubview:luckyNumLabel];
        
        //查看计算方式
        UIButton *previewCountWayButton = [[UIButton alloc] initWithFrame:CGRectMake(KScreenWidth - 80.f,countDownLabel.bottom + 20.f, 64.f, 31.f)];
        [previewCountWayButton setTitle:@"计算详情"
                               forState:UIControlStateNormal];
        previewCountWayButton.titleLabel.font = [UIFont systemFontOfSize:13];
        [previewCountWayButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [previewCountWayButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [previewCountWayButton setBackgroundImage:[UIImage imageNamed:@"按钮框-白"] forState:UIControlStateNormal];
        previewCountWayButton.backgroundColor = [UIColor clearColor];
        [previewCountWayButton addTarget:self
                                  action:@selector(countWayAction:)
                        forControlEvents:UIControlEventTouchUpInside];
        [goodsDetailView addSubview:previewCountWayButton];
        
        if (_isJoin == 0) {
            
            UILabel *noJoinLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, lkBgView.bottom + 4.f, KScreenWidth, 20.f)];
            noJoinLabel.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
            noJoinLabel.textAlignment = NSTextAlignmentCenter;
            noJoinLabel.font = [UIFont systemFontOfSize:13];
            noJoinLabel.text = @"你还未参与本商品夺宝";
            noJoinLabel.textColor = [UIColor darkGrayColor];
            [goodsDetailView addSubview:noJoinLabel];
            
        }else if (_isJoin == 1){
            //s横线
            UIImageView *line1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, lkBgView.bottom + 4.f, KScreenWidth, 10.f)];
//            line.image = [UIImage imageNamed:@"横线"];
            line1.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
            [goodsDetailView addSubview:line1];
            
            UILabel *JoinedLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, line1.bottom + 4.f, KScreenWidth-80, 20.f)];
            JoinedLabel.backgroundColor = [UIColor clearColor];
            JoinedLabel.textAlignment = NSTextAlignmentLeft;
            JoinedLabel.font = [UIFont systemFontOfSize:13];
            JoinedLabel.text = [NSString stringWithFormat:@"你参与了:%@",[_dataDic objectForKey:@"buyNumberCount"]];
            JoinedLabel.textColor = [UIColor blackColor];
            [goodsDetailView addSubview:JoinedLabel];
            
            UILabel *treasureNum = [[UILabel alloc] initWithFrame:CGRectMake(8, JoinedLabel.bottom, KScreenWidth-80, 20.f)];
            treasureNum.backgroundColor = [UIColor clearColor];
            treasureNum.textAlignment = NSTextAlignmentLeft;
            treasureNum.font = [UIFont systemFontOfSize:13];
            treasureNum.text = [NSString stringWithFormat:@"夺宝号码:%@",[_dataDic objectForKey:@"buyNumbers"]];
            treasureNum.textColor = [UIColor blackColor];
            [goodsDetailView addSubview:treasureNum];
            
            UIButton *previewAllButton = [[UIButton alloc] initWithFrame:CGRectMake(KScreenWidth - 72.f, line1.bottom + 8.f, 64.f, 28.f)];
            [previewAllButton setTitle:@"查看全部"
                              forState:UIControlStateNormal];
            previewAllButton.titleLabel.font = [UIFont systemFontOfSize:13];
            [previewAllButton setBackgroundImage:[UIImage imageNamed:@"按钮背景"] forState:UIControlStateNormal];
            [previewAllButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            previewAllButton.backgroundColor = [UIColor clearColor];
            [previewAllButton addTarget:self
                                 action:@selector(previewAll:)
                       forControlEvents:UIControlEventTouchUpInside];
            [goodsDetailView addSubview:previewAllButton];
            
            //下方横线
//            UIImageView *line2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, previewAllButton.bottom + 8.f, KScreenWidth, 1.f)];
//            line2.image = [UIImage imageNamed:@"横线"];
////            line1.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
//            [goodsDetailView addSubview:line2];
        }
            
        return  goodsDetailView;
    }
    
    return nil;
    
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *titleArr = @[@"图文详情",@"往期揭晓",@"晒单分享",@"参与记录(上滑)"];
    if (indexPath.row == 0) {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
        cell.backgroundColor = [UIColor whiteColor];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.font = [UIFont systemFontOfSize:13];
        cell.textLabel.text = titleArr[indexPath.row];
        cell.detailTextLabel.textColor = [UIColor colorWithWhite:0.85 alpha:1];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:12];
        cell.detailTextLabel.text = @"建议在WIFI下查看";
        
        return cell;
    }
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    cell.backgroundColor = [UIColor whiteColor];
    if (indexPath.row != 3) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }else{
        cell.textLabel.font = [UIFont systemFontOfSize:12];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
    }
    
    cell.textLabel.font = [UIFont systemFontOfSize:13];
    cell.textLabel.text = titleArr[indexPath.row];
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    if (_isAnnounced == 1) {
        
        if (_isJoin == 0) {
            
            return  92.f+30;
            
        }else if (_isJoin == 1){
            
            return 118.f+30;
            
        }
        
    }else if (_isAnnounced == 2){
    
        if (_isJoin == 0) {
            
            return  84.f;
            
        }else if (_isJoin == 1){
            
            return 104.f;
            
        }
    
    }else if (_isAnnounced == 3){
    
        if (_isJoin == 0) {
            
            return 132.f+70;
            
        }else if(_isJoin == 1){
        
            return 152.f+70;
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
    CWVC.drawID = [_dataDic objectForKey:@"drawId"];
    if (![_dataDic[@"isSpeed"] isKindOfClass:[NSNull class]]) {
        
        CWVC.isSpeed = [[_dataDic objectForKey:@"isSpeed"] boolValue];
    }
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
- (void)setCountDownTime:(NSInteger)countDownTime {
//    if (_countDownTime != countDownTime ) {
    
        _countDownTime = countDownTime;
        if (self.countDown) {
            [self.countDown destoryTimer];
        }else {
            self.countDown = [[CountDown alloc] init];
        }
        
        __weak __typeof(self) weakSelf= self;
        [self.countDown countDownWithTimeStamp:countDownTime completeBlock:^(NSInteger hour, NSInteger minute, NSInteger second, NSInteger millisecond) {
            //倒计时方法，每10毫秒调用一次
            if (hour<=0&&minute<=0&&second<=0&&millisecond<=0) {
                
                [weakSelf.countDown destoryTimer];
                
                    weakSelf.countDownLabel.text = @"正在计算开奖结果";
//
                    [self performSelector:@selector(afterDelayAction) withObject:nil afterDelay:8];

                
            }else {
                
                
                if (hour>0) {
                    
                    weakSelf.countDownLabel.text = [NSString stringWithFormat:@"揭晓倒计时：%02ld : %02ld : %02ld ",hour , minute,second];
                    
                }else {
                    
                    weakSelf.countDownLabel.text = [NSString stringWithFormat:@"揭晓倒计时：%02ld : %02ld : %02ld", minute,second,millisecond];
                }
            }
        }];
//    }
}
- (void)afterDelayAction {
    self.countDownBlock();
}

@end

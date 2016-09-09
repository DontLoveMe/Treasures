//
//  RedEnvelopeController.m
//  掌上云购
//
//  Created by 刘毅 on 16/8/15.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import "RedEnvelopeController.h"
#import "UseRedElpTableView.h"
#import "LoveView.h"

@interface RedEnvelopeController ()

@end

@implementation RedEnvelopeController {
    
    NSInteger _selectBtnTag;
    UIImageView *_lineView;
    UIScrollView *_scrollView;
    
    UseRedElpTableView *_useTableView;//红包可用
    UseRedElpTableView *_noUseTableView;//不可用红包
    
    UICollectionView *_collectionView;
    NSString *_identify;
    
    LoveView *_loveView;//猜你喜欢label
}

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
    
    self.title = @"我的红包";
    self.view.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    [self initNavBar];
    
    [self createSubviews];
    
    [self createBottomView];
    [self requestUserRedEnvelope];
    [self requestNoUserRedEnvelope];
}

- (void)createSubviews {
    //上方两个按钮
    NSArray *arr = @[@"可使用",@"已使用／过期"];
    CGFloat w = KScreenWidth/2;
    for (int i = 0; i < arr.count; i ++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = 200 + i;
        button.frame = CGRectMake(w*i, 0, w, 40);
        button.backgroundColor = [UIColor whiteColor];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorFromHexRGB:ThemeColor] forState:UIControlStateSelected];
        [button setTitle:arr[i] forState:UIControlStateNormal];
//        [button setBackgroundImage:[UIImage imageNamed:@"normal"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        if (i == 0) {
            _selectBtnTag = 200;
            button.selected = YES;
        }
    }
    //按钮下方的横线
    _lineView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 38, w, 2)];
    _lineView.backgroundColor = [UIColor colorFromHexRGB:ThemeColor];
    [self.view addSubview:_lineView];
    //底部的滑动视图
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_lineView.frame), KScreenWidth, KScreenHeight-40-64)];
    _scrollView.contentSize = CGSizeMake(KScreenWidth*arr.count, KScreenHeight-40-64);
    _scrollView.pagingEnabled = YES;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.delegate = self;
    [self.view addSubview:_scrollView];
    
    //滑动视图每页的视图
    _useTableView = [[UseRedElpTableView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, _scrollView.height)];
    [_scrollView addSubview:_useTableView];
    
    _noUseTableView = [[UseRedElpTableView alloc] initWithFrame:CGRectMake(KScreenWidth, 0, KScreenWidth, _scrollView.height)];
    [_scrollView addSubview:_noUseTableView];

    MJRefreshNormalHeader *useHeader = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self requestUserRedEnvelope];
    }];
    _useTableView.mj_header = useHeader;
    
    MJRefreshNormalHeader *noUseHeader = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self requestNoUserRedEnvelope];
    }];
    _noUseTableView.mj_header = noUseHeader;
}

- (void)requestUserRedEnvelope {
    //取出存储的用户信息
        NSDictionary *userDic = [[NSUserDefaults standardUserDefaults] objectForKey:@"userDic"];
        NSNumber *userId = userDic[@"id"];
    [self showHUD:@"加载数据"];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:@{@"userId":userId} forKey:@"paramsMap"];
    [params setObject:@1 forKey:@"page"];
    [params setObject:@200 forKey:@"rows"];
    
    NSString *url = [NSString stringWithFormat:@"%@%@",BASE_URL,RedPacketList_URL];
    [ZSTools post:url
           params:params
          success:^(id json) {
              
              BOOL isSuccess = [[json objectForKey:@"flag"] boolValue];
              [self hideSuccessHUD:json[@"msg"]];
              if (isSuccess) {
                  _useTableView.data = json[@"data"];
                  if (_useTableView.data.count>0) {
                      _useTableView.noView.hidden = YES;
                      _loveView.hidden = YES;
                  }else {
                      _useTableView.noView.hidden = NO;
                  }
                  [_useTableView reloadData];
                  [_useTableView.mj_header endRefreshing];
              }
              
              
          } failure:^(NSError *error) {
              
              [self hideFailHUD:@"加载失败"];
              NSLogZS(@"%@",error);
          }];
}
- (void)requestNoUserRedEnvelope {
    //取出存储的用户信息
        NSDictionary *userDic = [[NSUserDefaults standardUserDefaults] objectForKey:@"userDic"];
        NSNumber *userId = userDic[@"id"];
    [self showHUD:@"加载数据"];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:@{@"userId":userId} forKey:@"paramsMap"];
    [params setObject:@1 forKey:@"page"];
    [params setObject:@200 forKey:@"rows"];
    
    NSString *url = [NSString stringWithFormat:@"%@%@",BASE_URL,RedPacketDisabledList_URL];
    [ZSTools post:url
           params:params
          success:^(id json) {
              
              BOOL isSuccess = [[json objectForKey:@"flag"] boolValue];
              [self hideSuccessHUD:json[@"msg"]];
              if (isSuccess) {
                  _noUseTableView.data = json[@"data"];
                  
                  if (_noUseTableView.data.count>0) {
                      _noUseTableView.noView.hidden = YES;
                      _loveView.hidden = YES;
                  }else {
                      _noUseTableView.noView.hidden = NO;
                  }
                  [_noUseTableView reloadData];
                  [_noUseTableView.mj_header endRefreshing];
              }
              
              
          } failure:^(NSError *error) {
              
              [self hideFailHUD:@"加载失败"];
              NSLogZS(@"%@",error);
          }];
}

#pragma mark - ScrollView delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat pageWidth = _scrollView.frame.size.width;
    
    NSInteger page = (_scrollView.contentOffset.x - pageWidth/2)/pageWidth + 1;
    
    //改变选中button的样式
    [self changeButtonState:page + 200];
}
- (void)buttonAction:(UIButton *)button {
    if (button.tag != _selectBtnTag) {
        UIButton *selectBtn = [self.view viewWithTag:_selectBtnTag];
        selectBtn.selected = NO;
        //改变选中button的样式
        [self changeButtonState:button.tag];
        //去选中那一页
        [self goToPage:button.tag - 200];
     }

}
//改变选中button的样式
- (void)changeButtonState:(NSInteger)tag {
    UIButton *button = [self.view viewWithTag:tag];
    button.selected = YES;
    _selectBtnTag = tag;
    
    [UIView animateWithDuration:0.3 animations:^{
        CGRect frame = _lineView.frame;
        frame.origin.x = KScreenWidth/2*(button.tag - 200);
        _lineView.frame = frame;
    }];
}
//去选中那一页
- (void)goToPage:(NSInteger)page {
    CGRect frame;
    frame.origin.x = KScreenWidth * page;
    frame.origin.y = 0;
    frame.size = _scrollView.frame.size;
    [_scrollView scrollRectToVisible:frame animated:YES];

}

//创建下方视图
- (void)createBottomView {
    
    CGFloat w = (KScreenWidth-8*4)/3;
    
    _loveView = [[LoveView alloc] initWithFrame:CGRectMake(0, KScreenHeight-w*1.4-35-64, KScreenWidth, w*1.4+35)];
    [self.view addSubview:_loveView];
    

}

@end

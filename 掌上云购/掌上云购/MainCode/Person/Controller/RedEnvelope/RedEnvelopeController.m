//
//  RedEnvelopeController.m
//  掌上云购
//
//  Created by 刘毅 on 16/8/15.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import "RedEnvelopeController.h"
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
    
    LoveView *_loveView;//猜你喜欢
}

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
    if (_isMsgPush) {
        
        [self.navigationController popToRootViewControllerAnimated:YES];
    }else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我的红包";
    self.view.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    [self initNavBar];
    
    [self createSubviews];
    
    [self createBottomView];
    
    [self usableListCount ];
    [self requestUserRedEnvelope];
//    [self requestNoUserRedEnvelope];
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
    _useTableView.isPay = _isPay;
    _useTableView.redTableDelegate = self;
    [_scrollView addSubview:_useTableView];
    
    _noUseTableView = [[UseRedElpTableView alloc] initWithFrame:CGRectMake(KScreenWidth, 0, KScreenWidth, _scrollView.height)];
    [_scrollView addSubview:_noUseTableView];
    [self setRefreshHeader:_useTableView];
    [self setRefreshHeader:_noUseTableView];
//    _useTableView.mj_header = header;
//    _noUseTableView.mj_header = header;
}
- (void)setRefreshHeader:(UITableView *)tableView {
    //下拉时动画
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        
        switch (_selectBtnTag) {
            case 200:
                
                [self requestUserRedEnvelope];
                break;
            case 201:
                
                [self requestNoUserRedEnvelope];
                break;
            default:
                break;
        }
        
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
    tableView.mj_header = header;
}
#pragma mark - 数据请求
//获取红包个数
- (void)usableListCount{
    //取出存储的用户信息
    NSDictionary *userDic = [[NSUserDefaults standardUserDefaults] objectForKey:@"userDic"];
    if(userDic == nil){
        return;
    }
    NSNumber *userId = userDic[@"id"];
    //    [self showHUD:@"加载中"];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:userId forKey:@"userId"];
    
    NSString *url = [NSString stringWithFormat:@"%@%@",BASE_URL,UsableListCount_URL];
    [ZSTools post:url
           params:params
          success:^(id json) {
              
              BOOL isSuccess = [[json objectForKey:@"flag"] boolValue];
              //              [self hideSuccessHUD:[json objectForKey:@"msg"]];
              if (isSuccess) {
                  
                  UIButton *button = [self.view viewWithTag:200];
                  [button setTitle:[NSString stringWithFormat:@"可使用(%@)",json[@"data"]] forState:UIControlStateNormal];
              }
              //              [_collectionView reloadData];
              
          } failure:^(NSError *error) {
              
              //              [self hideFailHUD:@"加载失败"];
              NSLogZS(@"%@",error);
          }];
}
//请求可用的红包数据
- (void)requestUserRedEnvelope {
    //取出存储的用户信息
        NSDictionary *userDic = [[NSUserDefaults standardUserDefaults] objectForKey:@"userDic"];
        NSNumber *userId = userDic[@"id"];
    [self showHUD:@"加载数据"];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if (_businessId == nil) {
        [params setObject:@{@"userId":userId} forKey:@"paramsMap"];
    }else {
        [params setObject:@{@"userId":userId,@"batchNumber":_businessId} forKey:@"paramsMap"];
    }
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
                      _loveView.hidden = NO;
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
//请求用完的红包数据
- (void)requestNoUserRedEnvelope {
    //取出存储的用户信息
        NSDictionary *userDic = [[NSUserDefaults standardUserDefaults] objectForKey:@"userDic"];
        NSNumber *userId = userDic[@"id"];
    [self showHUD:@"加载数据"];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if (_businessId == nil) {
        [params setObject:@{@"userId":userId} forKey:@"paramsMap"];
    }else {
        [params setObject:@{@"userId":userId,@"batchNumber":_businessId} forKey:@"paramsMap"];
    }
    [params setObject:@1 forKey:@"page"];
    [params setObject:@200 forKey:@"rows"];
    
    NSString *url = [NSString stringWithFormat:@"%@%@",BASE_URL,RedPacketDisabledList_URL];
    [ZSTools post:url
           params:params
          success:^(id json) {
              
              BOOL isSuccess = [[json objectForKey:@"flag"] boolValue];
              [self hideSuccessHUD:@"数据加载成功"];
              if (isSuccess) {
                  _noUseTableView.data = json[@"data"];
                  
                  if (_noUseTableView.data.count>0) {
                      _noUseTableView.noView.hidden = YES;
                      _loveView.hidden = YES;
                  }else {
                      _noUseTableView.noView.hidden = NO;
                      _loveView.hidden = NO;
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
        
        //改变选中button的样式
        [self changeButtonState:button.tag];
        //去选中那一页
        [self goToPage:button.tag - 200];
        
     }

}
//改变选中button的样式
- (void)changeButtonState:(NSInteger)tag {
    if(tag == _selectBtnTag) return;
   
    UIButton *selectBtn = [self.view viewWithTag:_selectBtnTag];
    selectBtn.selected = NO;
    UIButton *button = [self.view viewWithTag:tag];
    button.selected = YES;
    _selectBtnTag = tag;
    
    switch (_selectBtnTag) {
        case 200:
            
            [self requestUserRedEnvelope];
            break;
        case 201:
            
            [self requestNoUserRedEnvelope];
            break;
        default:
            break;
    }
    
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
    
    _loveView = [[LoveView alloc] initWithFrame:CGRectMake(0, KScreenHeight-w*1.4-37-64, KScreenWidth, w*1.4+35)];
    [self.view addSubview:_loveView];
    

}

#pragma mark - 红包列表选中回调
- (void)paySelectCellDic:(NSDictionary *)redEnveloperDic{

    if ([_isPay isEqualToString:@"2"]) {
        
        NSInteger limitNum;
        if ([[redEnveloperDic objectForKey:@"consumeAmount"] isEqual:[NSNull null]]) {
            limitNum = 0;
        }else {
            limitNum = [[redEnveloperDic objectForKey:@"consumeAmount"] integerValue];
        }
        if (_constNum < limitNum) {
            
            UIAlertController *alerVC = [UIAlertController alertControllerWithTitle:@"温馨提示"
                                                                            message:@"未达到红包使用条件，再去选两件上品就可以使用了哦！"
                                                                     preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"好"
                                                                   style:UIAlertActionStyleCancel
                                                                 handler:^(UIAlertAction * _Nonnull action) {
                                                                     
                                                                     [alerVC dismissViewControllerAnimated:YES
                                                                                                completion:nil];
                                                                     
                                                                 }];
            [alerVC addAction:cancelAction];
            [self presentViewController:alerVC
                               animated:YES
                             completion:^{
                                 
                             }];
            return;
            
        }
        
        if ([_redDellegate respondsToSelector:@selector(paySelectDic:)]) {
            [_redDellegate paySelectDic:redEnveloperDic];
        }
        [self.navigationController popViewControllerAnimated:YES];
        
    }else{
        
        
    }

}

@end

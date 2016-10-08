//
//  GoodsDetailPTController.m
//  掌上云购
//
//  Created by coco船长 on 16/8/18.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import "GoodsDetailPTController.h"

@interface GoodsDetailPTController ()

@end

@implementation GoodsDetailPTController
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
    
}

- (void)NavAction:(UIButton *)button{
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"图文详情";
    
    [self initNavBar];
    
    [self initViews];
    
}

- (void)initViews{
    
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight - kNavigationBarHeight)];
    _webView.backgroundColor = [UIColor colorFromHexRGB:@"f6f5f5"];
    _webView.delegate = self;
    //自动适配屏幕
    _webView.scalesPageToFit = YES;
    [self.view addSubview:_webView];
    
    //设置风火轮
    _activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    
}

- (void)setGoodsId:(NSString *)goodsId{

    _goodsId = goodsId;
    
    [self requestData];

}

#pragma mark - 请求网络
- (void)requestData{

    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:@{@"productId":_goodsId}
               forKey:@"paramsMap"];
    
    NSString *url = [NSString stringWithFormat:@"%@%@",BASE_URL,GoodsTPdetail_URL];
    
    [ZSTools post:url
           params:params
          success:^(id json) {

//              NSString *urlString = [NSString stringWithFormat:@"<div>p>img style='width:100%;'>%@</div>",[json objectForKey:@"data"]];
              [_webView loadHTMLString:[json objectForKey:@"data"]
                               baseURL:nil];
              
          } failure:^(NSError *error) {
              
          }];

}

#pragma mark - UIWebViewDelegate
- (void)webViewDidStartLoad:(UIWebView *)webView {
    
    [_activityView startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    [_activityView stopAnimating];
    
    _activityView.hidden = YES;
    
    
}

@end

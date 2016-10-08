//
//  CustomerCareController.m
//  掌上云购
//
//  Created by 刘毅 on 16/8/17.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import "CustomerCareController.h"

@interface CustomerCareController ()

@property (nonatomic,strong)UIWebView *webView;

@end

@implementation CustomerCareController

#pragma mark - 导航栏
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
    
    if (_webView.canGoBack) {
        [_webView goBack];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"客服";
    
    [self initNavBar];
//    self.navigationController.navigationBar.hidden = YES;
    //创建UIWebView：
    
    _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight-64)];
    
//    _webView.scalesPageToFit = YES;//自动对页面进行缩放以适应屏幕
 
    [self.view addSubview:_webView];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",BASE_URL,ArticleContent_URL];
    NSURL* url = [NSURL URLWithString:urlStr];//创建URL
    NSURLRequest* request = [NSURLRequest requestWithURL:url];//创建NSURLRequest
    [_webView loadRequest:request];//加载
    
    
}


@end

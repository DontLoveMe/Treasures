//
//  HtmlTypeController.m
//  掌上云购
//
//  Created by 刘毅 on 16/9/23.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import "HtmlTypeController.h"

@interface HtmlTypeController ()

@property (nonatomic,strong)UIWebView *webView;

@end

@implementation HtmlTypeController
- (void)initNavBar{
    
    self.navigationItem.backBarButtonItem = nil;
    UIButton *leftButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40.f, 25.f)];
    leftButton.tag = 101;
    [leftButton setTitle:@"关闭" forState:UIControlStateNormal];
    //    [leftButton setBackgroundImage:[UIImage imageNamed:@"返回.png"]
    //                          forState:UIControlStateNormal];
    [leftButton addTarget:self
                   action:@selector(NavAction:)
         forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftItem;
    
}

- (void)NavAction:(UIButton *)button{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initNavBar];
    //创建UIWebView：
    
    _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight-64)];
    
    //    _webView.scalesPageToFit = YES;//自动对页面进行缩放以适应屏幕
    
    [self.view addSubview:_webView];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",BASE_URL,_htmlUrl];
    NSURL* url = [NSURL URLWithString:urlStr];//创建URL
    NSURLRequest* request = [NSURLRequest requestWithURL:url];//创建NSURLRequest
    [_webView loadRequest:request];//加载
}





@end

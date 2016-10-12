//
//  DelegateTxtController.m
//  掌上云购
//
//  Created by 刘毅 on 16/10/11.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import "DelegateTxtController.h"

@interface DelegateTxtController ()

@end

@implementation DelegateTxtController

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
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initNavBar];
    
    self.title = @"掌上云购用户协议";
    //取到txt文件的路径
    NSString *txtPath = [[NSBundle mainBundle] pathForResource:@"useragreement" ofType:@"txt"];
    
    //    NSLog(@"txtPath:%@",txtPath);
    
    ///编码可以解决 .txt 中文显示乱码问题
    
    NSStringEncoding *useEncodeing = nil;
    
    //带编码头的如utf-8等，这里会识别出来
    
    NSString *body = [NSString stringWithContentsOfFile:txtPath usedEncoding:useEncodeing error:nil];
    
    //识别不到，按GBK编码再解码一次.这里不能先按GB18030解码，否则会出现整个文档无换行bug。
    
    if (!body) {
        
        body = [NSString stringWithContentsOfFile:txtPath encoding:0x80000632 error:nil];
        
        //        NSLog(@"%@",body);
        
    }
    
    //还是识别不到，按GB18030编码再解码一次.
    
    if (!body) {
        
        body = [NSString stringWithContentsOfFile:txtPath encoding:0x80000631 error:nil];
        
        //        NSLog(@"%@",body);
        
    }
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight-64)];
    [self.view addSubview:textView];
    textView.font = [UIFont systemFontOfSize:15];
    textView.text = body;
}

@end

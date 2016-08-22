//
//  CountWayController.m
//  掌上云购
//
//  Created by coco船长 on 16/8/18.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import "CountWayController.h"

@interface CountWayController ()

@end

@implementation CountWayController
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
    self.title = @"计算详情";
    
    [self initNavBar];
    
    [self initViews];
    
}

- (void)initViews{

    //计算公式
    _formulaLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 24.f)];
    _formulaLabel.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];
    _formulaLabel.text = @"在这里显示计算公式";
    _formulaLabel.textColor = [UIColor blackColor];
    _formulaLabel.font = [UIFont systemFontOfSize:14];
    _formulaLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:_formulaLabel];
    
    //A区
    _characterAView = [[UIView alloc] initWithFrame:CGRectMake(0, _formulaLabel.bottom + 8, KScreenWidth, 40.f)];
    _characterAView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_characterAView];
    
    _characterAdescriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 20)];
    _characterAdescriptionLabel.backgroundColor = [UIColor colorWithWhite:0.4 alpha:0.4];
    _characterAdescriptionLabel.text = @"数值A:这个公式采用的参与人数的后50个人的余数";
    _characterAdescriptionLabel.textColor = [UIColor blackColor];
    _characterAdescriptionLabel.font = [UIFont systemFontOfSize:14];
    _characterAdescriptionLabel.textAlignment = NSTextAlignmentLeft;
    [_characterAView addSubview:_characterAdescriptionLabel];
    
    _characterAdataLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, _characterAdescriptionLabel.bottom, KScreenWidth, 20)];
    _characterAdataLabel.backgroundColor = [UIColor colorWithWhite:0.4 alpha:0.4];
    _characterAdataLabel.text = @"数值A：还没买满";
    _characterAdataLabel.textColor = [UIColor blackColor];
    _characterAdataLabel.font = [UIFont systemFontOfSize:14];
    _characterAdataLabel.textAlignment = NSTextAlignmentLeft;
    [_characterAView addSubview:_characterAdataLabel];
    
    //B区
    _characterBView = [[UIView alloc] initWithFrame:CGRectMake(0, _characterAView.bottom + 8, KScreenWidth, 40.f)];
    _characterAView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_characterBView];
    
    _characterBdescriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 20)];
    _characterBdescriptionLabel.backgroundColor = [UIColor colorWithWhite:0.4 alpha:0.4];
    _characterBdescriptionLabel.text = @"数值B:实时彩的最新开奖码";
    _characterBdescriptionLabel.textColor = [UIColor blackColor];
    _characterBdescriptionLabel.font = [UIFont systemFontOfSize:14];
    _characterBdescriptionLabel.textAlignment = NSTextAlignmentLeft;
    [_characterBView addSubview:_characterBdescriptionLabel];
    
    _characterBdataLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, _characterAdescriptionLabel.bottom, KScreenWidth, 20)];
    _characterBdataLabel.backgroundColor = [UIColor colorWithWhite:0.4 alpha:0.4];
    _characterBdataLabel.text = @"数值B：实时彩还没开奖";
    _characterBdataLabel.textColor = [UIColor blackColor];
    _characterBdataLabel.font = [UIFont systemFontOfSize:14];
    _characterBdataLabel.textAlignment = NSTextAlignmentLeft;
    [_characterBView addSubview:_characterBdataLabel];
    
    _resultLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, _characterBView.bottom + 8.f, KScreenWidth, 20.f)];
    _resultLabel.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.3];
    if (_isAnnounced == 2) {
        _resultLabel.text = @"获奖号:1234";
    }else{
        _resultLabel.text = @"获奖号:暂时还没开奖";
    }
    _resultLabel.textColor = [UIColor blackColor];
    _resultLabel.font = [UIFont systemFontOfSize:14];
    _resultLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:_resultLabel];

}

@end

//
//  AnnouncedHistoryController.m
//  掌上云购
//
//  Created by coco船长 on 16/8/18.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import "AnnouncedHistoryController.h"

@interface AnnouncedHistoryController ()

@end

@implementation AnnouncedHistoryController
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
    self.title = @"往期揭晓";
    
    [self initNavBar];

    [self initViews];
    
}

- (void)initViews{

    _announcedTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight - kNavigationBarHeight)];
    _announcedTableView.delegate = self;
    _announcedTableView.dataSource = self;
    _announcedTableView.backgroundColor = [UIColor whiteColor];
    _announcedTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_announcedTableView registerNib:[UINib nibWithNibName:@"AnnounceHistoryCell"
                                                    bundle:[NSBundle mainBundle]]
              forCellReuseIdentifier:@"AnnounceHistory_Cell"];
    [self.view addSubview:_announcedTableView];
    
}

#pragma mark - UITableViewDelegate,UItableViewDatasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 8;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    AnnounceHistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AnnounceHistory_Cell"
                                                                forIndexPath:indexPath];
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 122;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    NSLogZS(@"点击了第%ld个单元格",indexPath.row);
    
}

@end

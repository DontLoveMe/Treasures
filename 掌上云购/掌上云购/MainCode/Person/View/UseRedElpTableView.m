//
//  UseRedElpTableView.m
//  掌上云购
//
//  Created by 刘毅 on 16/8/16.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import "UseRedElpTableView.h"
#import "UseRedCell.h"
#import "RedEnvelopeModel.h"

@implementation UseRedElpTableView {
    
    NSString *_identify;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame style:UITableViewStylePlain];
    if (self) {
        
        self.delegate = self;
        self.dataSource = self;
        
        _identify = @"UseRedCell";
        [self registerNib:[UINib nibWithNibName:@"UseRedCell" bundle:nil] forCellReuseIdentifier:_identify];
        
        [self createNoView:frame];
    }
    return self;
}

- (void)createNoView:(CGRect)frame {
    _noView = [[UIView alloc] initWithFrame:CGRectMake((frame.size.width-220)/2, (frame.size.height-240)/2-50, 220, 240)];
//    _noView.backgroundColor = [UIColor grayColor];
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake((_noView.width-150)/2, 15, 150, 150)];
    imgView.image = [UIImage imageNamed:@"无红包"];
    [_noView addSubview:imgView];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake((_noView.width-100)/2, CGRectGetMaxY(imgView.frame)+10, 100, 40);
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitle:@"立即购买" forState:UIControlStateNormal];
//    [button setBackgroundImage:[UIImage imageNamed:@"normal"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_noView addSubview:button];
    
    
    [self addSubview:_noView];
}
- (void)buttonAction:(UIButton *)button {
    
}
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
#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.data.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UseRedCell *cell = [tableView dequeueReusableCellWithIdentifier:_identify forIndexPath:indexPath];
    cell.reModel = [RedEnvelopeModel mj_objectWithKeyValues:self.data[indexPath.row]];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 93;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}
@end

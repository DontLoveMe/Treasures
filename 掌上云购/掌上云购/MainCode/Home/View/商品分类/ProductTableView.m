//
//  ProductTableView.m
//  test
//
//  Created by 刘毅 on 16/7/28.
//  Copyright © 2016年 刘毅. All rights reserved.
//

#import "ProductTableView.h"
#import "ProductTableCell.h"

@implementation ProductTableView {
    
    NSString *_identify;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame style:UITableViewStylePlain];
    if (self) {
     
        self.delegate = self;
        self.dataSource = self;
        
        _identify = @"ProductTableCell";
        [self registerNib:[UINib nibWithNibName:@"ProductTableCell" bundle:nil] forCellReuseIdentifier:_identify];
    }
    return self;
}
#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ProductTableCell *cell = [tableView dequeueReusableCellWithIdentifier:_identify forIndexPath:indexPath];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 80;
}

@end

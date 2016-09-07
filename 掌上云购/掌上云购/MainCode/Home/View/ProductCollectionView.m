//
//  ProductCollectionView.m
//  test
//
//  Created by 刘毅 on 16/7/28.
//  Copyright © 2016年 刘毅. All rights reserved.
//

#import "ProductCollectionView.h"
#import "ProductCell.h"
#import "GoodsModel.h"

@implementation ProductCollectionView {
    
    NSString *_identify;
}

- (instancetype)initWithFrame:(CGRect)frame {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(frame.size.width/2-0.5, frame.size.width*1.3/2);
    layout.minimumLineSpacing = 1;
    layout.minimumInteritemSpacing = 1;
    
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        
        self.backgroundColor = [UIColor colorWithWhite:0.90 alpha:1];
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        
        self.dataSource = self;
        self.delegate = self;
//
        _identify = @"ProductCell";
        [self registerNib:[UINib nibWithNibName:@"ProductCell" bundle:nil] forCellWithReuseIdentifier:_identify];
    }
    return self;
}

- (void)setData:(NSArray *)data {
    _data = data;
    [self reloadData];
}

#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.data.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ProductCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:_identify forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    cell.gsModel = [GoodsModel mj_objectWithKeyValues:self.data[indexPath.row]];
//    cell.titleLabel.text = self.data[indexPath.row];
    return cell;
}

@end

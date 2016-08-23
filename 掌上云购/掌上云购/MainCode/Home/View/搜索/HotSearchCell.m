//
//  HotSearchCell.m
//  掌上云购
//
//  Created by 刘毅 on 16/8/22.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import "HotSearchCell.h"
#import "HotCollectionCell.h"

@implementation HotSearchCell {
    
    NSString *_identify;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _hotData = @[@"苹果 7",@"三星盖世 7",@"苹果 6S",@"尼康 D7000",@"福特锐界",@"特斯拉",];
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake((KScreenWidth-45)/3, 30);
    layout.sectionInset = UIEdgeInsetsMake(8, 8, 8, 8);
    
    _collectionView.collectionViewLayout = layout;
    
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    
    _identify = @"HotCollectionCell";
    [_collectionView registerNib:[UINib nibWithNibName:@"HotCollectionCell" bundle:nil] forCellWithReuseIdentifier:_identify];
}
#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _hotData.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HotCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:_identify forIndexPath:indexPath];
    cell.titleLabel.text = _hotData[indexPath.row];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    self.hotSearchString(_hotData[indexPath.row]);
}
@end

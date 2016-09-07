//
//  LoveView.m
//  掌上云购
//
//  Created by 刘毅 on 16/9/7.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import "LoveView.h"

@implementation LoveView {
    NSString *_identify;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initSubviews];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initSubviews];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews {
    
    CGFloat w = (self.width-8*4)/3;
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(w, w*1.3);
    layout.sectionInset = UIEdgeInsetsMake(5, 6, 5, 6);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 25, self.width, w*1.3+10) collectionViewLayout:layout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_collectionView];
    
    
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    
    _identify = @"collectionCell";
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:_identify];
    
//    _loveLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, CGRectGetMinY(_collectionView.frame)-20, 120, 20)];
//    _loveLabel.text = @"猜你喜欢";
//    _loveLabel.textColor = [UIColor blackColor];
//    _loveLabel.font = [UIFont systemFontOfSize:16];
//    [self.view addSubview:_loveLabel];
    
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:_identify forIndexPath:indexPath];
    cell.backgroundColor = [UIColor grayColor];
    UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"揭晓-图片.jpg"]];
    cell.backgroundView = imgView;
    
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}
- (void)layoutSubviews {
    
}

@end

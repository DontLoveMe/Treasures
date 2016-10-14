//
//  ProductCollectionView.m
//  test
//
//  Created by 刘毅 on 16/7/28.
//  Copyright © 2016年 刘毅. All rights reserved.
//

#import "ProductCollectionView.h"

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
    cell.nowIndexpath = indexPath;
    cell.productDelegate = self;
//    cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"collectionCell背景"]];
    cell.backgroundColor = [UIColor whiteColor];
    cell.gsModel = [GoodsModel mj_objectWithKeyValues:self.data[indexPath.row]];
//    cell.titleLabel.text = self.data[indexPath.row];
    return cell;
    
}

#pragma mark - 加入购物车成功的动画
- (void)addToCartWithIndexpath:(NSIndexPath *)nowIndexpath{
    
    //数据
    NSDictionary *dic = [_data objectAtIndex:nowIndexpath.row];
    
    //设置动画图片初始位置
    ProductCell *cell = (ProductCell *)[self cellForItemAtIndexPath:nowIndexpath];
    
    UIImageView *activityImgview = [[UIImageView alloc] initWithFrame:CGRectMake(nowIndexpath.row % 2 * (cell.width + 1), nowIndexpath.row / 2 * (cell.height + 1) + self.top, cell.productImg.width,cell.productImg.height)];
    //设置图片
    NSArray *picList = [dic objectForKey:@"proPictureList"];
    if (picList.count != 0) {
        
        [activityImgview setImageWithURL:[NSURL URLWithString:[picList[0] objectForKey:@"img650"]]];
        
    }
    
    [self addSubview:activityImgview];
    
    [UIView animateWithDuration:1
                     animations:^{
                         
                         CGAffineTransform transform = CGAffineTransformMakeTranslation(KScreenWidth * 7 / 10 - activityImgview.centerX - self.left, KScreenHeight - kNavigationBarHeight - kTabBarHeight - activityImgview.centerY + self.contentOffset.y);
                         transform = CGAffineTransformScale(transform, 0.01, 0.01);
                         activityImgview.transform = CGAffineTransformRotate(transform, 2 * M_PI_2);
                         //
                     }completion:^(BOOL finished) {
                         
                         //动画结束后隐藏图片
                         activityImgview.hidden = YES;
                         
                     }];
    
}

- (BaseViewController *)viewController {
    
    UIResponder *next = self.nextResponder;
    
    do {
        
        if ([next isKindOfClass:[BaseViewController class]]) {
            
            return (BaseViewController *)next;
        }
        
        next = next.nextResponder;
        
    } while (next != nil);
    
    return nil;
}

@end

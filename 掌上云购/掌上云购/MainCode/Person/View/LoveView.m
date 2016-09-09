//
//  LoveView.m
//  掌上云购
//
//  Created by 刘毅 on 16/9/7.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import "LoveView.h"
#import "LoveCell.h"
#import "GoodsModel.h"
#import "GoodsDetailController.h"

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
- (void)requestLoveData {
    NSString *url = [NSString stringWithFormat:@"%@%@",BASE_URL,LoveProduct_URL];
    
    
    [ZSTools post:url
           params:nil
          success:^(id json) {
              
              BOOL flag = [json objectForKey:@"flag"];
              if (flag) {
                  self.loveData = json[@"data"];
                  [_collectionView reloadData];
              }
              
          } failure:^(NSError *error) {
              
          }];
}
- (void)initSubviews {
    [self requestLoveData];
    
    self.backgroundColor = [UIColor whiteColor];
    
    CGFloat w = (self.width-8*4)/3;
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(w, w*1.4);
    layout.sectionInset = UIEdgeInsetsMake(5, 6, 5, 6);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 25, self.width, w*1.4+10) collectionViewLayout:layout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_collectionView];
    
    
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    
    _identify = @"LoveCell";
    [_collectionView registerNib:[UINib nibWithNibName:@"LoveCell" bundle:nil] forCellWithReuseIdentifier:_identify];
    
    _loveLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, CGRectGetMinY(_collectionView.frame)-20, 120, 20)];
    _loveLabel.text = @"猜你喜欢";
    _loveLabel.textColor = [UIColor blackColor];
    _loveLabel.font = [UIFont systemFontOfSize:16];
    [self addSubview:_loveLabel];
    
}
#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _loveData.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LoveCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:_identify forIndexPath:indexPath];
    GoodsModel *gsModel = [GoodsModel mj_objectWithKeyValues:_loveData[indexPath.row]];
    cell.gsModel = gsModel;
   
    
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    GoodsDetailController *gsdtVC = [[GoodsDetailController alloc] init];
    GoodsModel *gsModel = [GoodsModel mj_objectWithKeyValues:self.loveData[indexPath.row]];
    gsdtVC.goodsId = gsModel.ID;
    gsdtVC.drawId = gsModel.drawId;
    gsdtVC.isAnnounced = 1;
    [[self viewController].navigationController pushViewController:gsdtVC animated:YES];
}
- (void)layoutSubviews {
    
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
@end

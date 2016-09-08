//
//  PreviewAllController.m
//  掌上云购
//
//  Created by coco船长 on 16/9/8.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import "PreviewAllController.h"

@interface PreviewAllController ()

@end

@implementation PreviewAllController

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
    self.title = @"夺宝记录";
    self.view.backgroundColor = [UIColor colorFromHexRGB:@"F2F2F2"];
    [self initNavBar];
    
    CollectionViewLeftAlignedLayout *layout = [[CollectionViewLeftAlignedLayout alloc] init];
    
    layout.sectionInset = UIEdgeInsetsMake(8, 8, 8, 8);
    
    joinRecordCollectionView.collectionViewLayout = layout;
    joinRecordCollectionView.backgroundColor = [UIColor colorFromHexRGB:@"F2F2F2"];
    joinRecordCollectionView.delegate = self;
    joinRecordCollectionView.dataSource = self;
    
    [joinRecordCollectionView registerNib:[UINib nibWithNibName:@"HotCollectionCell" bundle:nil] forCellWithReuseIdentifier:@"HotCollection_Cell"];
    
}

- (void)viewWillAppear:(BOOL)animated{

    goodName.text = [NSString stringWithFormat:@"商品名:%@",[_dataDic objectForKey:@"name"]];
    
    drawNum.text = [NSString stringWithFormat:@"期号:%@",[_dataDic objectForKey:@"drawTimes"]];
    
    if (![[_dataDic objectForKey:@"countdownEndDate"] isKindOfClass:[NSNull class]]) {
        drawTime.text = [NSString stringWithFormat:@"揭晓时间：%@",[_dataDic objectForKey:@"countdownEndDate"]];
    }else{
        
        drawTime.text = @"该商品尚未筹满";
        
    }
    
    if (![[_dataDic objectForKey:@"countdownEndDate"] isKindOfClass:[NSNull class]]) {
        drawTime.text = [NSString stringWithFormat:@"揭晓时间：%@",[_dataDic objectForKey:@"countdownEndDate"]];
    }else{
        
        drawTime.text = @"揭晓时间：该商品尚未筹满";
        luckyNum.text = @"本期幸运号码:尚未开奖";
    }
    
    NSMutableString *joinNumStr = [[_dataDic objectForKey:@"buyNumbers"] mutableCopy];
    
    NSScanner *theScanner;
    
    NSString *text = nil;
    
    theScanner = [NSScanner scannerWithString:joinNumStr];
    
    joinRecordList = [NSMutableArray array];
    
    while ([theScanner isAtEnd] == NO) {
        
        // find start of tag
        
        [theScanner scanUpToString:@"," intoString:&text] ;
        
        [joinRecordList addObject:text];
        
        if (joinNumStr.length > text.length){
            [joinNumStr deleteCharactersInRange:NSMakeRange(0, text.length + 1)];
        }else{
            [joinNumStr deleteCharactersInRange:NSMakeRange(0, text.length)];
        }

        
        theScanner = [NSScanner scannerWithString:joinNumStr];
        NSLog(@"%@",text);
        
    }
    
    NSLogZS(@"%@",joinNumStr);
    [joinRecordCollectionView reloadData];
    
}

#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return joinRecordList.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HotCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HotCollection_Cell" forIndexPath:indexPath];
//    cell.titleLabel.text = _hotData[indexPath.row][@"name"];
    cell.titleLabel.text = joinRecordList[indexPath.row];
    return cell;
}

#pragma mark - CollectionViewDelegateLeftAlignedLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *hotStr = joinRecordList[indexPath.row];
    CGRect strRect = [hotStr boundingRectWithSize:CGSizeMake(KScreenWidth-32, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil];
    return CGSizeMake(strRect.size.width+10, 20);
}

@end

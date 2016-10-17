//
//  SnatchRecordCell.m
//  掌上云购
//
//  Created by 刘毅 on 16/8/9.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import "SnatchRecordCell.h"
#import "GoodsDetailController.h"

@implementation SnatchRecordCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setRcModel:(RecordModel *)rcModel {
    _rcModel = rcModel;
    
    NSArray *pArr = _rcModel.proPictureList;
    if (pArr.count>0) {
        Propicturelist *prtLs = pArr[0];
        NSURL *url = [NSURL URLWithString:prtLs.img170];
        [_imgView setImageWithURL:url placeholderImage:[UIImage imageNamed:@"未加载图片"]];
    }
    
    _titleLabel.text = rcModel.name;
    _issueLabel.text = [NSString stringWithFormat:@"期号：%@",rcModel.saleDraw.drawTimes
];
    _peopleNum.text = [NSString stringWithFormat:@"%ld",rcModel.partakeCount];
    
    if ([rcModel.saleDraw.nickName isKindOfClass:[NSNull class]]||rcModel.saleDraw.nickName.length == 0) {
        _getName.text = @"即将揭晓，请稍后…";
        _getLabel.hidden = YES;
        _getLabelWidth.constant = 0;
    }else {
        _getLabel.hidden = NO;
        _getName.text = rcModel.saleDraw.nickName;
        _getLabelWidth.constant = 50;
    }
    if (rcModel.winnersPartakeCount == 0) {
        _peopleNumber.hidden = YES;
        _getPeopleN.text = @"";
    }else {
        _peopleNumber.hidden = NO;
        _getPeopleN.text = [NSString stringWithFormat:@"%ld",rcModel.winnersPartakeCount];
    }

    //夺宝状态
    NSInteger isLimit = rcModel.proNumberStatus;
    if (isLimit == 1) {
        
        _againButton.userInteractionEnabled = NO;
        [_againButton setTitle:@"该商品已限期" forState:UIControlStateNormal];
        
    }
    
    NSInteger isSaleOutStatus = rcModel.proStatus;
    isSaleOutStatus = 1 - isSaleOutStatus;
    if (isSaleOutStatus == 1) {
        
        //已下架
        _againButton.userInteractionEnabled = NO;
        [_againButton setTitle:@"该商品下架" forState:UIControlStateNormal];
        
    }
    
}

//查看详情
- (IBAction)lookDetailAction:(UIButton *)sender {
    if (_rcModel.saleDraw.status == 2) {
        GoodsDetailController *gsDTVC = [[GoodsDetailController alloc] init];
        gsDTVC.goodsId = _rcModel.ID ;
        gsDTVC.drawId = _rcModel.drawId;
        gsDTVC.isAnnounced = 2;
        [[self viewController].navigationController pushViewController:gsDTVC animated:YES];
    }else if (_rcModel.saleDraw.status == 3){
        GoodsDetailController *gsDTVC = [[GoodsDetailController alloc] init];
        gsDTVC.goodsId = _rcModel.ID ;
        gsDTVC.drawId = _rcModel.drawId;
        gsDTVC.isAnnounced = 3;
        [[self viewController].navigationController pushViewController:gsDTVC animated:YES];
        
    }
    
}
//再次购买
- (IBAction)againShopAction:(UIButton *)sender {
    
    GoodsDetailController *gsDTVC = [[GoodsDetailController alloc] init];
    gsDTVC.goodsId = _rcModel.ID ;
//    gsDTVC.drawId = _rcModel.drawId;
    gsDTVC.isAnnounced = 1;
    [[self viewController].navigationController pushViewController:gsDTVC animated:YES];
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

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
        NSURL *url = [NSURL URLWithString:prtLs.img650];
        [_imgView setImageWithURL:url placeholderImage:[UIImage imageNamed:@"揭晓-图片.jpg"]];
    }
    
    _titleLabel.text = rcModel.name;
    _issueLabel.text = [NSString stringWithFormat:@"期号：%@",rcModel.saleDraw.drawTimes
];
    _peopleNum.text = [NSString stringWithFormat:@"%ld",rcModel.partakeCount];
    _getName.text = rcModel.saleDraw.nickName;
    _getPeopleN.text = [NSString stringWithFormat:@"%ld",rcModel.winnersPartakeCount];

}

//查看详情
- (IBAction)lookDetailAction:(UIButton *)sender {
}
//再次购买
- (IBAction)againShopAction:(UIButton *)sender {
    
    GoodsDetailController *gsDTVC = [[GoodsDetailController alloc] init];
    gsDTVC.goodsId = _rcModel.ID ;
    gsDTVC.drawId = _rcModel.drawId;
    gsDTVC.isAnnounced = 3;
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

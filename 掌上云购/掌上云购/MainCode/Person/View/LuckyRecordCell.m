//
//  LuckyRecordCell.m
//  掌上云购
//
//  Created by 刘毅 on 16/8/9.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import "LuckyRecordCell.h"
#import "ConfirmDataController.h"
#import "ConfirmGoodsController.h"
#import "AddShareController.h"

// 弹出分享菜单需要导入的头文件
#import <ShareSDKUI/ShareSDK+SSUI.h>
// 自定义分享菜单栏需要导入的头文件
#import <ShareSDKUI/SSUIShareActionSheetStyle.h>
//自定义分享编辑界面所需要导入的头文件
#import <ShareSDKUI/SSUIEditorViewStyle.h>

@implementation LuckyRecordCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setLkModel:(RecordModel *)lkModel {
    _lkModel = lkModel;
    
    NSArray *pArr = _lkModel.proPictureList;
    if (pArr.count>0) {
        Propicturelist *prtLs = pArr[0];
        NSURL *url = [NSURL URLWithString:prtLs.img400];
        [_imgView setImageWithURL:url placeholderImage:[UIImage imageNamed:@"未加载图片"]];
    }
    
//    NSURL *url = [NSURL URLWithString:plist.img650];
//    [_imgView setImageWithURL:url placeholderImage:[UIImage imageNamed:@"揭晓-图片.jpg"]];
    
    _titleLabel.text = _lkModel.name;
    _issueLabel.text = [NSString stringWithFormat:@"%@",_lkModel.saleDraw.drawTimes];
    _sumLabel.text = [NSString stringWithFormat:@"%ld人次",_lkModel.saleDraw.totalShare];
    _luckyNumLabel.text = _lkModel.saleDraw.drawNumber;
    _participateLabel.text = [NSString stringWithFormat:@"%ld人次",_lkModel.partakeCount];
    _timeLabel.text = [TimeFormat getNewTimeString:_lkModel.saleDraw.drawDate];
    

}


//确认收货
- (IBAction)goodsAction:(UIButton *)sender {
//    if ([_dic[@"isGoods"] boolValue]) {
//        
//        ConfirmDataController *cdVC = [[ConfirmDataController alloc] init];
//        if ([_dic[@"isSure"] boolValue]) {
//            cdVC.state = 1;
//        }else {
//            cdVC.state = 0;
//        }
//        [[self viewController].navigationController pushViewController:cdVC animated:YES];
//    }else {
//        ConfirmGoodsController *cgVC = [[ConfirmGoodsController alloc] init];
//        [[self viewController].navigationController pushViewController:cgVC animated:YES];
//
//    }
    self.suerBlock();
    
}
- (IBAction)isSunAction:(UIButton *)sender {
    
//    NSInteger orderStatus = [_lkModel.orderStatus integerValue];
//    if (orderStatus == 3 ||orderStatus == 7||orderStatus == 4) {
    
        NSString *urlStr = [NSString stringWithFormat:@"http://zsys58.com/pcpServer-wechat/product/detail/%@",_lkModel.ID];
        NSURL *url = [NSURL URLWithString:urlStr];
        //创建分享参数
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        [shareParams SSDKSetupShareParamsByText:@""//
                                         images:_imgView.image//[self getImage]//传入要分享的图片
                                            url:url
                                          title:_lkModel.name
                                           type:SSDKContentTypeAuto];
        
        [SSUIEditorViewStyle setiPhoneNavigationBarBackgroundColor:[UIColor colorFromHexRGB:ThemeColor]];
        //设置编辑界面标题颜色
        [SSUIEditorViewStyle setTitleColor:[UIColor whiteColor]];
        //设置取消发布标签文本颜色
        [SSUIEditorViewStyle setCancelButtonLabelColor:[UIColor whiteColor]];
        [SSUIEditorViewStyle setShareButtonLabelColor:[UIColor whiteColor]];
        //设置分享编辑界面状态栏风格
        [SSUIEditorViewStyle setStatusBarStyle:UIStatusBarStyleDefault];
        //设置简单分享菜单样式
        [SSUIShareActionSheetStyle setShareActionSheetStyle:ShareActionSheetStyleSystem];
        
        //分享@[@(SSDKPlatformTypeSinaWeibo),
        //@(SSDKPlatformTypeWechat),
        //@(SSDKPlatformTypeQQ)]
        [ShareSDK showShareActionSheet:nil
         //将要自定义顺序的平台传入items参数中
                                 items:@[@(SSDKPlatformTypeWechat)]
                           shareParams:shareParams
                   onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
                       
                       if (contentEntity) {
                           NSLogZS(@"分享成功");
                           UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示"
                                                                                                    message:@"分享成功" preferredStyle:UIAlertControllerStyleAlert];
                           UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"好"
                                                                                  style:UIAlertActionStyleCancel
                                                                                handler:^(UIAlertAction * _Nonnull action) {
                                                                                    [alertController dismissViewControllerAnimated:YES
                                                                                                                        completion:nil];
                                                                                }];
                           [alertController addAction:cancelAction];
                           [[self viewController] presentViewController:alertController
                                              animated:YES
                                            completion:nil];
                           
                       }
                       if (error){
                           NSLogZS(@"%@",error);
                           UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示"
                                                                                                    message:@"分享失败！" preferredStyle:UIAlertControllerStyleAlert];
                           UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"好"
                                                                                  style:UIAlertActionStyleCancel
                                                                                handler:^(UIAlertAction * _Nonnull action) {
                                                                                    [alertController dismissViewControllerAnimated:YES
                                                                                                                        completion:nil];
                                                                                }];
                           [alertController addAction:cancelAction];
                           [[self viewController] presentViewController:alertController
                                              animated:YES
                                            completion:nil];
                       }
                   }];
   

//    }else {
//        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示"
//                                                                                 message:@"请确认收货！" preferredStyle:UIAlertControllerStyleAlert];
//        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"好"
//                                                               style:UIAlertActionStyleCancel
//                                                             handler:^(UIAlertAction * _Nonnull action) {
//                                                                 [alertController dismissViewControllerAnimated:YES
//                                                                                                     completion:nil];
//                                                             }];
//        [alertController addAction:cancelAction];
//        [[self viewController] presentViewController:alertController
//                           animated:YES
//                         completion:nil];
//    }

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

//
//  InordertoDetailController.m
//  掌上云购
//
//  Created by 刘毅 on 16/8/15.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import "InordertoDetailController.h"
#import "InordertoshareModel.h"
//#import "HisIconImageView.h"

// 弹出分享菜单需要导入的头文件
#import <ShareSDKUI/ShareSDK+SSUI.h>
// 自定义分享菜单栏需要导入的头文件
#import <ShareSDKUI/SSUIShareActionSheetStyle.h>
//自定义分享编辑界面所需要导入的头文件
#import <ShareSDKUI/SSUIEditorViewStyle.h>

@interface InordertoDetailController ()

@property (nonatomic,strong)UIImageView *iconView;
@property (nonatomic,strong)UILabel *nikeName;
@property (nonatomic,strong)UILabel *timeLabel;
@property (nonatomic,strong)UIView *bgView;
@property (nonatomic,strong)UILabel *contentLabel;
@property (nonatomic,strong)NSArray *labels;
@property (nonatomic,strong)NSArray *imgViews;

@property (nonatomic,strong)InordertoshareModel *iShareModel;

@end

@implementation InordertoDetailController

#pragma mark - 导航栏
- (void)initNavBar{
    
    self.navigationItem.backBarButtonItem = nil;
    UIButton *leftButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, kNavigationBarItemWidth, kNavigationBarItemHight)];
    leftButton.tag = 101;
    [leftButton setBackgroundImage:[UIImage imageNamed:@"返回.png"]
                          forState:UIControlStateNormal];
    [leftButton addTarget:self
                   action:@selector(NavAction:)
         forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    self.navigationItem.rightBarButtonItem = nil;
    UIButton *rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40.f, 25.f)];
    rightButton.tag = 102;
    [rightButton setTitle:@"分享" forState:UIControlStateNormal];
//    [rightButton setBackgroundImage:[UIImage imageNamed:@"返回.png"]
//                          forState:UIControlStateNormal];
    [rightButton addTarget:self
                   action:@selector(NavAction:)
         forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightItem;
    
}

- (void)NavAction:(UIButton *)button{
    if (button.tag == 101) {
        
        [self.navigationController popViewControllerAnimated:YES];
    }else if (button.tag == 102) {
        
        NSString *urlStr = [NSString stringWithFormat:@"http://zsys58.com/pcpServer-wechat/user/userComment/detailComment/%ld?drawTimes=%@",(long)_iShareModel.ID,_iShareModel.drawTimes];
        NSURL *url = [NSURL URLWithString:urlStr];
        //创建分享参数
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        [shareParams SSDKSetupShareParamsByText:@""//_iShareModel.content
                                         images:[UIImage imageNamed:@"掌上云购"]//[self getImage]//传入要分享的图片
                                            url:url
                                          title:_iShareModel.productName//@"[掌上云购]一元秒杀快乐无限，掌上云购让您的生活高潮迭起！"
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
                           [self presentViewController:alertController
                                              animated:YES
                                            completion:nil];
                           [self requestShara];
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
                           [self presentViewController:alertController
                                              animated:YES
                                            completion:nil];
                       }
                   }];
    }
    
}
- (void)requestShara {
    
    NSDictionary *userDic = [[NSUserDefaults standardUserDefaults] objectForKey:@"userDic"];
    NSNumber *userId = userDic[@"id"];
    if (userId == nil || [userId isKindOfClass:[NSNull class]]) {
        return;
    }
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:@(_shareID) forKey:@"commentId"];
    [params setObject:userId forKey:@"buyUserId"];
    NSString *url = [NSString stringWithFormat:@"%@%@",BASE_URL,ShareSunshare_URL];
    [ZSTools post:url
           params:params
          success:^(id json) {
              
              BOOL isSuccess = [[json objectForKey:@"flag"] boolValue];
//              [self hideSuccessHUD:@"数据加载成功"];
              if (isSuccess) {
                 
              }
              
              
          } failure:^(NSError *error) {
              
              [self hideFailHUD:@"加载失败"];
              NSLogZS(@"%@",error);
          }];
}
// 从view上截图
- (UIImage *)getImage {
    
    UIGraphicsBeginImageContextWithOptions(_scrollView.contentSize, NO, 1.0);  //NO，YES 控制是否透明
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    // 生成后的image
    
    return image;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"晒单详情";
    
    [self initNavBar];
    
    [self requestData];
    
    [self createSubviews];
}

- (void)createSubviews {
    
    _iconView = [[HisIconImageView alloc] initWithFrame:CGRectMake(10, 10, 40, 40)];
    _iconView.layer.cornerRadius = _iconView.width/2;
    _iconView.layer.masksToBounds = YES;
//    _iconView.buyUserId = _buyUserId;
    _iconView.image = [UIImage imageNamed:@"我的-头像"];
    [_scrollView addSubview:_iconView];
    
    
    _nikeName = [[UILabel alloc] initWithFrame:CGRectMake(55, 10, KScreenWidth - 160, 40)];
//    _nikeName.backgroundColor = [UIColor grayColor];
    _nikeName.text = @"";
    _nikeName.textColor = [UIColor blackColor];
    _nikeName.textAlignment = NSTextAlignmentLeft;
    _nikeName.font = [UIFont systemFontOfSize:16];
    [_scrollView addSubview:_nikeName];
    
    _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(KScreenWidth-110, 10, 100, 40)];
//    _timeLabel.backgroundColor = [UIColor grayColor];
    _timeLabel.text = @"";
    _timeLabel.textColor = [UIColor blackColor];
    _timeLabel.textAlignment = NSTextAlignmentRight;
    _timeLabel.font = [UIFont systemFontOfSize:16];
    [_scrollView addSubview:_timeLabel];
    
    _bgView = [[UIView alloc] initWithFrame:CGRectMake(15, 55, KScreenWidth-30, 150)];
    _bgView.backgroundColor = [UIColor colorWithWhite:0.93 alpha:1];
    [_scrollView addSubview:_bgView];
    NSMutableArray *lbArr = [NSMutableArray array];
    for (int i = 0; i < 6; i++) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 5+25*i, _bgView.width-20, 20)];
        label.tag = 100+i;
        label.textColor = [UIColor blackColor];
        label.textAlignment = NSTextAlignmentLeft;
        label.font = [UIFont systemFontOfSize:14];
        if (i == 0) {
            label.font = [UIFont boldSystemFontOfSize:16];
        }
        [self.bgView addSubview:label];
        [lbArr addObject:label];
    }
    _labels = lbArr;
    _contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(_bgView.frame)+5, KScreenWidth-30, 16)];
//    _contentLabel.backgroundColor = [UIColor grayColor];
    _contentLabel.text = @"";
    _contentLabel.numberOfLines = 0;
    _contentLabel.textColor = [UIColor blackColor];
    _contentLabel.textAlignment = NSTextAlignmentLeft;
    _contentLabel.font = [UIFont systemFontOfSize:16];
    [_scrollView addSubview:_contentLabel];
    
    NSMutableArray *imgViewArr = [NSMutableArray array];
    for (int i = 0; i < 6; i ++) {
//        UIImage *img = [UIImage imageNamed:@"揭晓-图片.jpg"];
        
        UIImageView *imgView = [[UIImageView alloc]init];
//        imgView.contentMode = UIViewContentModeScaleAspectFit;
        imgView.hidden = YES;
        
        [imgViewArr addObject:imgView];
    }
    _imgViews = imgViewArr;
    _scrollView.contentSize = CGSizeMake(KScreenWidth, KScreenHeight+100);
}
- (void)requestData {
    
    [self showHUD:@"加载数据"];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:@{@"id":@(_shareID)} forKey:@"paramsMap"];
    NSString *url = [NSString stringWithFormat:@"%@%@",BASE_URL,SunshareDetail_URL];
    [ZSTools post:url
           params:params
          success:^(id json) {
              
              BOOL isSuccess = [[json objectForKey:@"flag"] boolValue];
              
              if (isSuccess) {
                  InordertoshareModel *iSModel = [InordertoshareModel mj_objectWithKeyValues:json[@"data"]];
                  _iShareModel = iSModel;
                  [self setSubViews:iSModel];
                  [self hideSuccessHUD:@"数据加载成功"];
              }else{
                  [self hideFailHUD:@"加载失败"];
              }
              
              
          } failure:^(NSError *error) {
              
              [self hideFailHUD:@"加载失败"];
              NSLogZS(@"%@",error);
          }];
}

- (void)setSubViews:(InordertoshareModel *)iSModel {
    
    _nikeName.text = iSModel.nickName;
    
    
    NSString *urlStr = iSModel.userPhotoUrl;
    if (urlStr.length == 0) {
        [_iconView setImage:[UIImage imageNamed:@"我的-头像"]];
    }else {
        NSURL *url = [NSURL URLWithString:urlStr];
        [_iconView setImageWithURL:url placeholderImage:[UIImage imageNamed:@"我的-头像"]];
    }

    //转时间格式
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [dateFormatter dateFromString:iSModel.createDate];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"MM-dd HH:mm"];
    
    NSString *currentDateStr = [dateFormatter stringFromDate:date];
    _timeLabel.text = currentDateStr;
    
    NSArray *mdArr = @[iSModel.title?iSModel.title:@"",
                       [NSString stringWithFormat:@"获得商品：%@",iSModel.productName?iSModel.productName:@""],
                       [NSString stringWithFormat:@"期号：%@",iSModel.drawTimes?iSModel.drawTimes:@""],
                       [NSString stringWithFormat:@"参与人次：%@",iSModel.buyTimes?iSModel.buyTimes:@""],
                       [NSString stringWithFormat:@"幸运号码：%@",iSModel.drawNumber?iSModel.drawNumber:@""],
                       [NSString stringWithFormat:@"揭晓时间：%@",iSModel.drawDate?iSModel.drawDate:@""]];
    for (int i = 0;i < _labels.count; i ++) {
        UILabel *lable = _labels[i];
        lable.text = mdArr[i];
    }
    
    _contentLabel.text = iSModel.content;
    
    CGRect contentRect = [ iSModel.content boundingRectWithSize:CGSizeMake(KScreenWidth-30, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil];
    _contentLabel.height = contentRect.size.height;
    NSArray *photoUrllist = iSModel.photoUrllist;
    
    __block CGFloat imgViewHeight = 0;
    __block CGFloat imgHeight = 0;
    for (int i = 0; i < _imgViews.count; i ++) {
        UIImageView *imgView = _imgViews[i];
//        imgView.backgroundColor = [UIColor grayColor];
        [_scrollView addSubview:imgView];
        if (i > photoUrllist.count-1||photoUrllist == nil||photoUrllist.count == 0) {
            imgView.hidden = YES;
            
        }else {
            imgView.hidden = NO;
            NSURL *url = [NSURL URLWithString:photoUrllist[i]];

            __weak typeof(UIImageView *) weakImg = imgView;

            [imgView setImageWithURLRequest:[NSURLRequest requestWithURL:url] placeholderImage:[UIImage imageNamed:@"未加载图片"] success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull image) {
                
                weakImg.image = image;
                
                weakImg.frame = CGRectMake(15, CGRectGetMaxY(_bgView.frame)+contentRect.size.height+10+imgViewHeight, KScreenWidth-30, image.size.height/image.size.width*(KScreenWidth-30));
                
                imgHeight = image.size.height/image.size.width*(KScreenWidth-30);
                imgViewHeight += imgHeight+10;
                
                _scrollView.contentSize = CGSizeMake(KScreenWidth, _iconView.height+_bgView.height+ contentRect.size.height+imgViewHeight+50);
            } failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {
                
            }];
        }
    }
//    _scrollView.contentSize = CGSizeMake(KScreenWidth, _iconView.height+_bgView.height+ contentRect.size.height+imgViewHeight+50);

}
@end

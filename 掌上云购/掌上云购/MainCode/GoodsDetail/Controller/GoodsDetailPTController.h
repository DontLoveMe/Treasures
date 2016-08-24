//
//  GoodsDetailPTController.h
//  掌上云购
//
//  Created by coco船长 on 16/8/18.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import "BaseViewController.h"

@interface GoodsDetailPTController : BaseViewController<UIWebViewDelegate>{

    UIWebView                   *_webView;
    
    UIActivityIndicatorView     *_activityView;

}

@property (nonatomic ,copy)NSString *goodsId;

@end

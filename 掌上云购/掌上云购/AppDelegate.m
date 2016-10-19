//
//  AppDelegate.m
//  掌上云购
//
//  Created by coco船长 on 16/8/22.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import "AppDelegate.h"

#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>

//腾讯开放平台（对应QQ和QQ空间）SDK头文件
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>

//微信SDK头文件
#import "WXApi.h"

//新浪微博SDK头文件
#import "WeiboSDK.h"

#import "PromptController.h"

@interface AppDelegate (){
    PromptController *pVC;

}

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    _window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    _window.backgroundColor = [UIColor whiteColor];
    
    [_window makeKeyAndVisible];
    
    TabbarViewcontroller *TVC = [[TabbarViewcontroller alloc] init];
    _window.rootViewController = TVC;
    
//    [self requestPrizeMsg];
  //推送测试
//    double delayInSeconds = 15.0;
//    
//    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
//    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
//        PromptController *pVC = [[PromptController alloc] init];
//        TabbarViewcontroller *tabbar = (TabbarViewcontroller *)self.window.rootViewController;
//        pVC.type = 1;
//        pVC.tabbarIndex = tabbar.selectedIndex;
//        pVC.titleLabel.text = @"恭喜Liuyi获得幸运，你的幸运号码为10000052";
//        [self.window.rootViewController presentViewController:pVC animated:YES completion:nil];
//        NSLog(@"=====================================%ld",TVC.selectedIndex) ; });
   
    
    /**
     *  设置ShareSDK的appKey，如果尚未在ShareSDK官网注册过App，请移步到http://mob.com/login 登录后台进行应用注册，
     *  在将生成的AppKey传入到此方法中。
     *  方法中的第二个第三个参数为需要连接社交平台SDK时触发，
     *  在此事件中写入连接代码。第四个参数则为配置本地社交平台时触发，根据返回的平台类型来配置平台信息。
     *  如果您使用的时服务端托管平台信息时，第二、四项参数可以传入nil，第三项参数则根据服务端托管平台来决定要连接的社交SDK。
     */
    [ShareSDK registerApp:@"17bce2ea96f7c"
     
          activePlatforms:@[
                            @(SSDKPlatformTypeSinaWeibo),
                            @(SSDKPlatformTypeWechat),
                            @(SSDKPlatformTypeQQ)]
                 onImport:^(SSDKPlatformType platformType)
     {
         switch (platformType)
         {
             case SSDKPlatformTypeWechat:
                 [ShareSDKConnector connectWeChat:[WXApi class]];
                 break;
             case SSDKPlatformTypeQQ:
                 [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
                 break;
             case SSDKPlatformTypeSinaWeibo:
                 [ShareSDKConnector connectWeibo:[WeiboSDK class]];
                 break;
                 
             default:
                 break;
         }
     }
          onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo)
     {
         
         switch (platformType)
         {
             case SSDKPlatformTypeSinaWeibo:
                 //设置新浪微博应用信息,其中authType设置为使用SSO＋Web形式授权
                 [appInfo SSDKSetupSinaWeiboByAppKey:@"2977151595"
                                           appSecret:@"a188c1aa32d4b842c77b95a62413ff0f"
                                         redirectUri:@"http://www.sharesdk.cn"
                                            authType:SSDKAuthTypeBoth];
                 break;
             case SSDKPlatformTypeWechat:
                 [appInfo SSDKSetupWeChatByAppId:@"wx771de2a13cbf2c72"
                                       appSecret:@"0a3cf0c70c919167198c570a148d986c"];
                 break;
             case SSDKPlatformTypeQQ:
                 [appInfo SSDKSetupQQByAppId:@"1105626495"
                                      appKey:@"D3F2YgTXEoauHWSz"
                                    authType:SSDKAuthTypeBoth];
                 break;
                 
             default:
                 break;
         }
     }];
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        UIUserNotificationType myTypes = UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
        
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:myTypes categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    }else {
        UIUserNotificationType myTypes = UIUserNotificationTypeBadge|UIUserNotificationTypeAlert|UIUserNotificationTypeSound;
        [[UIApplication sharedApplication]registerForRemoteNotifications];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:myTypes
                                                                                                              categories:nil]];
    }
    
    //在 App 启动时注册百度云推送服务，需要提供 Apikey
    [BPush registerChannel:launchOptions
                    apiKey:@"kRYXondRVDtp9eodsFNwVFxH"
                  pushMode:BPushModeDevelopment
           withFirstAction:nil
          withSecondAction:nil
              withCategory:nil
      useBehaviorTextInput:YES
                   isDebug:YES];
    // App 是用户点击推送消息启动
    NSDictionary *userInfo = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    if (userInfo) {
        NSLogZS(@"从消息启动:%@",userInfo);
        [BPush handleNotification:userInfo];
    }
#if TARGET_IPHONE_SIMULATOR
    Byte dt[32] = {0xc6, 0x1e, 0x5a, 0x13, 0x2d, 0x04, 0x83, 0x82, 0x12, 0x4c, 0x26, 0xcd, 0x0c, 0x16, 0xf6, 0x7c, 0x74, 0x78, 0xb3, 0x5f, 0x6b, 0x37, 0x0a, 0x42, 0x4f, 0xe7, 0x97, 0xdc, 0x9f, 0x3a, 0x54, 0x10};
    [self application:application didRegisterForRemoteNotificationsWithDeviceToken:[NSData dataWithBytes:dt length:32]];
#endif
    //角标清0
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    
    return YES;
}

// 此方法是 用户点击了通知，应用在前台 或者开启后台并且应用在后台 时调起
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler{
    
    completionHandler(UIBackgroundFetchResultNewData);
    // 应用在前台 或者后台开启状态下，不跳转页面，让用户选择。
    if (application.applicationState == UIApplicationStateActive || application.applicationState == UIApplicationStateBackground) {
        NSLogZS(@"acitve or background");
        NSLog(@"%@",userInfo[@"aps"][@"alert"]);
        NSLog(@"%@",userInfo[@"description"]);
        NSLog(@"%@",userInfo[@"title"]);
        NSDictionary *userDic = [[NSUserDefaults standardUserDefaults] objectForKey:@"userDic"];
        if(userDic == nil){
            return;
        }
        TabbarViewcontroller *tabbar = (TabbarViewcontroller *)self.window.rootViewController;
        if ([userInfo[@"msg_type"] integerValue] == 4) {
            if (pVC.parentViewController == self.window.rootViewController) {
                return;
            }
            pVC = [[PromptController alloc] init];
            pVC.type = 0;
            pVC.tabbarIndex = tabbar.selectedIndex;
            pVC.titleLabel.text = userInfo[@"aps"][@"alert"];
            
            [self.window.rootViewController presentViewController:pVC animated:YES completion:nil];
        }else {
            
            if (pVC.parentViewController == self.window.rootViewController) {
                return;
            }
            pVC = [[PromptController alloc] init];
            pVC.type = 1;
            pVC.tabbarIndex = tabbar.selectedIndex;
            pVC.titleLabel.text = userInfo[@"aps"][@"alert"];
            [self.window.rootViewController presentViewController:pVC animated:YES completion:nil];
        }
    }
    
}

// 在 iOS8 系统中，还需要添加这个方法。通过新的 API 注册推送服务
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings{
    
    [application registerForRemoteNotifications];
    
}


- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    
    NSLog(@"test:%@",deviceToken);
    [BPush registerDeviceToken:deviceToken];
    [BPush bindChannelWithCompleteHandler:^(id result, NSError *error) {
        //        [self.viewController addLogString:[NSString stringWithFormat:@"Method: %@\n%@",BPushRequestMethodBind,result]];
        // 需要在绑定成功后进行 settag listtag deletetag unbind 操作否则会失败
        if (result) {
            [BPush setTag:@"Mytag" withCompleteHandler:^(id result, NSError *error) {
                if (result) {
                    NSLogZS(@"设置tag成功");
                }
            }];
        }
    }];
    
    // 打印到日志 textView 中
    //    [self.viewController addLogString:[NSString stringWithFormat:@"Register use deviceToken : %@",deviceToken]];
    
}

// 当 DeviceToken 获取失败时，系统会回调此方法
- (void)application:(UIApplication *)application
didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
    
    NSLogZS(@"DeviceToken 获取失败，原因：%@",error);
    
}

- (void)application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo{
    
    // App 收到推送的通知
    [BPush handleNotification:userInfo];
    NSLogZS(@"********** ios7.0之前 **********");
    // 应用在前台 或者后台开启状态下，不跳转页面，让用户选择。
    if (application.applicationState == UIApplicationStateActive || application.applicationState == UIApplicationStateBackground) {
        NSLogZS(@"acitve or background");
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"收到一条消息" message:userInfo[@"aps"][@"alert"] preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        [alertController addAction:okAction];
        
        [alertController addAction:cancelAction];
        
        
        [self.window.rootViewController presentViewController:alertController animated:YES completion:nil];
    }
    
    NSLogZS(@"%@",userInfo);
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    [[JHFSDK sharedInstance] applicationWillEnterForeground:application];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    
    // 支付结果处理
    [[JHFSDK sharedInstance] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDict) {
        // standbyCallback为备用回调，当调起第三方支付客户端(比如：支付宝，微信支付)在操作时，商户app进程在后台被结束，只能通过这个block输出支付结果。
    }];
    
    return YES;
}

//请求中奖信息
- (void)requestPrizeMsg{

    NSDictionary *userDic = [[NSUserDefaults standardUserDefaults] objectForKey:@"userDic"];
    if(userDic == nil){
        return;
    }
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSNumber *userId = userDic[@"id"];
    [params setObject:userId forKey:@"id"];
    
    NSString *url = [NSString stringWithFormat:@"%@%@",BASE_URL,PrizeRemind_URL];
    [ZSTools post:url
           params:params
          success:^(id json) {
              
              if (![[json objectForKey:@"data"] isKindOfClass:[NSNull class]]) {
                  
                  NSDictionary *dataDic = [json objectForKey:@"data"];
                  if (pVC.parentViewController == self.window.rootViewController) {
                      return;
                  }
                  pVC = [[PromptController alloc] init];
                  pVC.type = 1;
                  pVC.titleLabel.text = [NSString stringWithFormat:@"恭喜你中奖，获得%@",dataDic[@"productId"]];
                  [self.window.rootViewController presentViewController:pVC animated:YES completion:nil];
                  
              }else{
                  
                  return;
                  
              }
              
          } failure:^(NSError *error) {
              
              return ;
              
          }];
}

@end

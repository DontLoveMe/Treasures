//
//  JHFSDK.h
//  JHFSDK
//
//
//

#import <Foundation/Foundation.h>
#import "JHFOrder.h"
#import "WXApi.h"

@protocol WXApiDelegate;

typedef void(^JHFCompletionBlock)(NSDictionary *resultDict);

@interface JHFSDK : NSObject<WXApiDelegate>

@property (nonatomic, strong) NSString *schema;
@property (nonatomic, strong) JHFCompletionBlock callback;
@property (nonatomic, strong) UIViewController *viewController;

+ (instancetype)sharedInstance;

- (UINavigationController *)payOrder:(JHFOrder *)order
                          fromScheme:(NSString *)scheme
                      viewController:(UIViewController *)viewController
                            callback:(JHFCompletionBlock)completionBlock;

- (void)processOrderWithPaymentResult:(NSURL *)resultUrl
                      standbyCallback:(JHFCompletionBlock)completionBlock;


- (void)applicationWillEnterForeground:(UIApplication *)application;

@end
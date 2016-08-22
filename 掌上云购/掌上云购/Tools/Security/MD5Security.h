//
//  MD5Security.h
//  湘女家政
//
//  Created by coco船长 on 15/11/24.
//  Copyright © 2015年 nevermore. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>

@interface MD5Security : NSObject

+ (NSString*)MD5String:(NSString*)string;

@end

//
//  MD5Security.m
//  湘女家政
//
//  Created by coco船长 on 15/11/24.
//  Copyright © 2015年 nevermore. All rights reserved.
//

#import "MD5Security.h"

@implementation MD5Security

+ (NSString*)MD5String:(NSString *)string{

    const char *cStr = [string UTF8String];
    unsigned char result[16];
    CC_MD5( cStr, (int)strlen(cStr), result );
    return [NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];

}

@end

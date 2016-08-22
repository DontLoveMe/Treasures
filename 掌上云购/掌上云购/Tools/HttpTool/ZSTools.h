//
//  ZSTools.h
//  掌上云购
//
//  Created by coco船长 on 16/8/3.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZSTools : NSObject

//GET--AFN+JSON
+ (void)get:(NSString *)url
     params:(NSDictionary *)params
    success:(void (^)(id json))success
    failure:(void (^)(NSError *error))failure;

//POST--AFN+JSON
+ (void)post:(NSString *)url
      params:(NSDictionary *)params
     success:(void (^)(id json))success
     failure:(void (^)(NSError *error))failure;

//GET--NETWORK
+ (BOOL)getNetwork;

//POST-UPDATE--FILE(MimeType)
+ (void)post:(NSString *)url
      params:(NSDictionary *)params
        data:(NSMutableDictionary *)datas
     success:(void (^)(id))success
     failure:(void (^)(NSError *))failure;

@end

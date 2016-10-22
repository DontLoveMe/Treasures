//
//  ZSTools.m
//  掌上云购
//
//  Created by coco船长 on 16/8/3.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import "ZSTools.h"


@implementation ZSTools

/**
 *  GET--AFN+JSON
 */
+ (void)get:(NSString *)url params:(NSDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure{
    
    // 1.创建请求管理者
    // *AFHTTPRequestOperationManager已经被废弃，如果你以前使用 AFHTTPRequestOperationManager，你将需要迁移去使用 AFHTTPSessionManager
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    NSMutableDictionary *paramsObj = [NSMutableDictionary dictionary];
    // 2.在这里将传过来的参数转换成json格式
    if (params) {
        NSString *obj = [params JSONString];
        NSData *aesdataresult = [SecurityUtil encryptAESData:obj];
        NSString *securityString = [SecurityUtil encodeBase64Data:aesdataresult];
        securityString = (__bridge NSString *)CFURLCreateStringByAddingPercentEscapes(
                                                                                      
                                                                                      NULL, /* allocator */
                                                                                      
                                                                                      (__bridge CFStringRef)securityString,
                                                                                      
                                                                                      NULL, /* charactersToLeaveUnescaped */
                                                                                      
                                                                                      (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                                      
                                                                                      kCFStringEncodingUTF8);
        paramsObj[@"param"] = securityString;
    } else {
        paramsObj = nil;
    }
    
    // 3.发送请求
    [mgr GET:url parameters:paramsObj progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (success) {
            NSString *sucurytyResult = [responseObject objectForKey:@"data"];
            NSData *dd=[sucurytyResult dataUsingEncoding:NSUTF8StringEncoding];
            NSData *data2=[GTMBase64 decodeData:dd];
            NSString *aesresult=[SecurityUtil decryptAESData:data2];
            NSData *jsonData = [aesresult dataUsingEncoding:NSUTF8StringEncoding];
            NSError *err;
            NSDictionary *testDataDic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                                        options:NSJSONReadingMutableContainers
                                                                          error:&err];
            NSMutableDictionary *responsDic = [NSMutableDictionary dictionaryWithDictionary:responseObject];
            if (err) {
                [responsDic setObject:aesresult forKey:@"data"];
            }else{
                [responsDic setObject:testDataDic forKey:@"data"];
            }
            
            success(responsDic);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failure) {
            failure(error);
        }
        
    }];
    
}

/**
 *  POST--AFN+JSON
 */
+ (void)post:(NSString *)url params:(NSDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure{
    
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    NSMutableDictionary *paramsObj = [NSMutableDictionary dictionary];
    if (params) {
        
        NSString *obj = [params JSONString];
        //项目加密方式
        NSData *aesdataresult = [SecurityUtil encryptAESData:obj];
        NSString *securityString = [SecurityUtil encodeBase64Data:aesdataresult];
        //特殊字符转码
        securityString = (__bridge NSString *)CFURLCreateStringByAddingPercentEscapes(
                                                                                      
                                                                                      NULL, /* allocator */
                                                                                      
                                                                                      (__bridge CFStringRef)securityString,
                                                                                      
                                                                                      NULL, /* charactersToLeaveUnescaped */
                                                                                      
                                                                                      (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                                      
                                                                                      kCFStringEncodingUTF8);
        paramsObj[@"param"] = securityString;
    } else {
        paramsObj = nil;
    }
    [mgr POST:url
   parameters:paramsObj
constructingBodyWithBlock:nil
     
     progress:^(NSProgress * _Nonnull uploadProgress) {
         
     } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
         
         if (success) {
             
             //项目解密
             NSString *sucurytyResult = [responseObject objectForKey:@"data"];
             NSData *dd=[sucurytyResult dataUsingEncoding:NSUTF8StringEncoding];
             NSData *data2=[GTMBase64 decodeData:dd];
             NSString *aesresult=[SecurityUtil decryptAESData:data2];
             
             //string转字典
             NSData *jsonData = [aesresult dataUsingEncoding:NSUTF8StringEncoding];
             NSError *err;
             NSDictionary *testDataDic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                                         options:NSJSONReadingMutableContainers
                                                                           error:&err];
             NSMutableDictionary *responsDic = [NSMutableDictionary dictionaryWithDictionary:responseObject];
             //是否成功
             if (err) {
                 [responsDic setObject:aesresult forKey:@"data"];
             }else{
                 [responsDic setObject:testDataDic forKey:@"data"];
             }
             
             success(responsDic);
         }
         
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         
         if (failure) {
             failure(error);
         }
         
     }];
    
}

/**
 *  GET--NET(获取当前网络状态)
 */
+ (BOOL)getNetwork{
    
    static BOOL network = YES;
    // 1.创建网络监控的管理者
    AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
    // 2.设置网络状态改变后的处理
    [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        // 当网络状态改变了, 就会调用这个block
        switch (status) {
            case AFNetworkReachabilityStatusUnknown: // 未知网络
                network = NO;
                NSLog(@"未知网络----------------------------");
                break;
                
            case AFNetworkReachabilityStatusNotReachable: // 没有网络(断网)
                network = NO;
                NSLog(@"没有网络(断网)-----------------------");
                break;
                
            case AFNetworkReachabilityStatusReachableViaWWAN: // 手机自带网络
                network = YES;
                NSLog(@"手机自带网络-------------------------");
                break;
                
            case AFNetworkReachabilityStatusReachableViaWiFi: // WIFI
                network = YES;
                NSLog(@"WIFI网络----------------------------");
                break;
        }
    }];
    // 3.开始监控
    [mgr startMonitoring];
    return network;
}

/**
 *  POST-UPDATE--FILE(MimeType)(POST上传文件)
 */
//+ (void)post:(NSString *)url
//      params:(NSDictionary *)params
//        data:(NSMutableDictionary *)datas
//     success:(void (^)(id))success
//     failure:(void (^)(NSError *))failure{
//    
//    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
//    NSMutableDictionary *paramsObj = [NSMutableDictionary dictionary];
//    if (params) {
//        NSString *obj = [params JSONString];
//        NSData *aesdataresult = [SecurityUtil encryptAESData:obj];
//        NSString *securityString = [SecurityUtil encodeBase64Data:aesdataresult];
//        securityString = (__bridge NSString *)CFURLCreateStringByAddingPercentEscapes(
//                                                                                      
//                                                                                      NULL, /* allocator */
//                                                                                      
//                                                                                      (__bridge CFStringRef)securityString,
//                                                                                      
//                                                                                      NULL, /* charactersToLeaveUnescaped */
//                                                                                      
//                                                                                      (CFStringRef)@"!*'();:@&=+$,/?%#[]",
//                                                                                      
//                                                                                      kCFStringEncodingUTF8);
//        paramsObj[@"param"] = securityString;
//    } else {
//        paramsObj = nil;
//    }
//    
//    [mgr POST:url
//       parameters:paramsObj constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//           
//           //将需要上传的文件数据添加到formData中
//           //循环遍历需要上传的文件数据
//           for (NSString *name in datas) {
//               
//               /**
//                *   多图片上传，这个功能，得根据后台的接收方式
//                *   遇到过的情况：
//                *   （1）以表单形式接收：一次上传多张，将文件data，拼接起来。
//                *   （2）每次请求后台只接收单张，但是需要上传多张：用串行队列调用此方法依次上传。
//                */
//               NSData *data = datas[name];
//               /**
//                *   传进来的datas -> 建议格式: @{@"图片名":(NSData *)picData,...}
//                *   FileData -> picData
//                *   name     -> 指后台指定的数据流对应的字段
//                *   fileName -> 图片名
//                *   mimeType -> 数据流对应的类型，mimeType的对照表就不列举，有需要的请百度
//                */
//               [formData appendPartWithFileData:data
//                                           name:@"fileData"
//                                       fileName:name
//                                       mimeType:@"image/jpeg"];
//           }
//           
//       } progress:^(NSProgress * _Nonnull uploadProgress) {
//           
//           NSLog(@"%lld",uploadProgress.completedUnitCount);
//           
//           
//       } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//           
//           if (success) {
//               NSString *sucurytyResult = [responseObject objectForKey:@"data"];
//               NSData *dd=[sucurytyResult dataUsingEncoding:NSUTF8StringEncoding];
//               NSData *data2=[GTMBase64 decodeData:dd];
//               NSString *aesresult=[SecurityUtil decryptAESData:data2];
//               NSData *jsonData = [aesresult dataUsingEncoding:NSUTF8StringEncoding];
//               NSError *err;
//               NSDictionary *testDataDic = [NSJSONSerialization JSONObjectWithData:jsonData
//                                                                           options:NSJSONReadingMutableContainers
//                                                                             error:&err];
//               NSMutableDictionary *responsDic = [NSMutableDictionary dictionaryWithDictionary:responseObject];
//               if (err) {
//                   [responsDic setObject:aesresult forKey:@"data"];
//               }else{
//                   [responsDic setObject:testDataDic forKey:@"data"];
//               }
//               
//               success(responsDic);
//           }
//           
//       } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//           
//           if (failure) {
//               failure(error);
//           }
//           
//       }];
//    
//}
+ (void)post:(NSString *)url
      params:(NSDictionary *)params
        data:(NSMutableDictionary *)datas
     success:(void (^)(id))success
     failure:(void (^)(NSError *))failure{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSMutableDictionary *paramsObj = [NSMutableDictionary dictionary];
    if (params) {
        NSString *obj = [params JSONString];
        paramsObj[@"param"] = obj;
    } else {
        paramsObj = nil;
    }
    
    [manager POST:url
       parameters:paramsObj constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
           
           //将需要上传的文件数据添加到formData中
           //循环遍历需要上传的文件数据
           for (NSString *name in datas) {
               
               /**
                *   多图片上传，这个功能，得根据后台的接收方式
                *   遇到过的情况：
                *   （1）以表单形式接收：一次上传多张，将文件data，拼接起来。
                *   （2）每次请求后台只接收单张，但是需要上传多张：用串行队列调用此方法依次上传。
                */
               NSData *data = datas[name];
               /**
                *   传进来的datas -> 建议格式: @{@"图片名":(NSData *)picData,...}
                *   FileData -> picData
                *   name     -> 指后台指定的数据流对应的字段
                *   fileName -> 图片名
                *   mimeType -> 数据流对应的类型，mimeType的对照表就不列举，有需要的请百度
                */
               [formData appendPartWithFileData:data
                                           name:@"fileData"
                                       fileName:name
                                       mimeType:@"image/jpeg"];
           }
           
       } progress:^(NSProgress * _Nonnull uploadProgress) {
           
           NSLog(@"%lld",uploadProgress.completedUnitCount);
           
           
       } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
           
           if (success) {
               success(responseObject);
           }
           
       } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
           
           if (failure) {
               failure(error);
           }
           
       }];
    
}


//特殊的地方(去掉空值不完全的地方)
+ (void)specialPost:(NSString *)url params:(NSDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure{
    
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    AFJSONResponseSerializer *response = [AFJSONResponseSerializer serializer];
    response.removesKeysWithNullValues = YES;
    mgr.responseSerializer = response;
    mgr.requestSerializer = [AFJSONRequestSerializer serializer];
    NSMutableDictionary *paramsObj = [NSMutableDictionary dictionary];
    if (params) {
        NSString *obj = [params JSONString];
        NSData *aesdataresult = [SecurityUtil encryptAESData:obj];
        NSString *securityString = [SecurityUtil encodeBase64Data:aesdataresult];
        securityString = (__bridge NSString *)CFURLCreateStringByAddingPercentEscapes(
                                                                                      
                                                                                      NULL, /* allocator */
                                                                                      
                                                                                      (__bridge CFStringRef)securityString,
                                                                                      
                                                                                      NULL, /* charactersToLeaveUnescaped */
                                                                                      
                                                                                      (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                                      
                                                                                      kCFStringEncodingUTF8);
        paramsObj[@"param"] = securityString;
    } else {
        paramsObj = nil;
    }
    [mgr POST:url parameters:paramsObj
constructingBodyWithBlock:nil
     
     progress:^(NSProgress * _Nonnull uploadProgress) {
         
     } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
         
         if (success) {
             NSString *sucurytyResult = [responseObject objectForKey:@"data"];
             NSData *dd=[sucurytyResult dataUsingEncoding:NSUTF8StringEncoding];
             NSData *data2=[GTMBase64 decodeData:dd];
             NSString *aesresult=[SecurityUtil decryptAESData:data2];
             NSData *jsonData = [aesresult dataUsingEncoding:NSUTF8StringEncoding];
             NSError *err;
             NSDictionary *testDataDic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                                         options:NSJSONReadingMutableContainers
                                                                           error:&err];
             NSMutableDictionary *responsDic = [NSMutableDictionary dictionaryWithDictionary:responseObject];
             if (err) {
                 [responsDic setObject:aesresult forKey:@"data"];
             }else{
                 [responsDic setObject:testDataDic forKey:@"data"];
             }
             
             success(responsDic);
         }
         
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         
         if (failure) {
             failure(error);
         }
         
     }];
    
}

@end

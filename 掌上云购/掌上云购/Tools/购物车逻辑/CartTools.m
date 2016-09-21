//
//  CartTools.m
//  掌上云购
//
//  Created by coco船长 on 16/8/25.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import "CartTools.h"

@implementation CartTools

/*
 *加入购物车：将选中物品数组与服务器数组合并
 *前置条件：传入数据的格式处理。只传入关键，有效键值对。（关键：即上传&展示时的必须字段）
 *加入事件分支：根据商品id，当有该id时，只作数量累加。没有该id时进行矢量累加。
 *注：关键字段：商品id，商品名，商品类别，商品图片，总需次数，剩余次数，购买次数，购买价格
 */

+ (NSArray *)getCartList{

    //获取应用程序沙盒的Documents目录
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *plistPath = [paths objectAtIndex:0];
    //得到完整的文件名
    NSString *filename=[plistPath stringByAppendingPathComponent:@"cartList.plist"];
    //判断是否已有此目录文件
    BOOL isExst = [[NSFileManager defaultManager] fileExistsAtPath:filename];
    
    if (isExst) {
        return [NSMutableArray arrayWithContentsOfFile:filename];
    }else{
        return [NSArray array];
    }

}

+ (BOOL)addCartList:(nullable NSArray *)cartArr{
    
    //获取应用程序沙盒的Documents目录
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *plistPath = [paths objectAtIndex:0];
    //得到完整的文件名
    NSString *filename=[plistPath stringByAppendingPathComponent:@"cartList.plist"];
    //判断是否已有此目录文件
    BOOL isExst = [[NSFileManager defaultManager] fileExistsAtPath:filename];
    
    if (isExst) {
    
        //已存在
        NSMutableArray *existArr = [NSMutableArray arrayWithContentsOfFile:filename];
        
        //遍历新加入的数组
        for (int i = 0 ; i < cartArr.count; i ++) {
            
            NSString *newGoodsID = [[cartArr objectAtIndex:i] objectForKey:@"id"];
            NSInteger existCount = existArr.count;
            NSInteger   haveSame = 0;
            
            if (existCount <= 0) {
                
                [existArr addObject:cartArr[i]];
                continue;
                
            }
            
            //遍历已存在的数组
            for (NSInteger j = existCount - 1; j >= 0; j --) {
                
                NSString *oldGoodsID = [[existArr objectAtIndex:j] objectForKey:@"id"];
                //根据id标识，矢量增加还是数量增加
                if (oldGoodsID == newGoodsID) {
                    
                    haveSame = 1;
                    
                }
                
                if (haveSame == 1) {
                    
                    //修改商品的进度
                    NSInteger newSurplusShare  =  [[[cartArr objectAtIndex:i] objectForKey:@"surplusShare"] integerValue];
                    [[existArr objectAtIndex:j] setObject:[NSNumber numberWithInteger:newSurplusShare] forKey:@"surplusShare"];
                    
                    NSArray *picArr = [[cartArr objectAtIndex:i] objectForKey:@"proPictureList"];
                    [[existArr objectAtIndex:j] setObject:picArr
                                                   forKey:@"proPictureList"];
                    
                    //修改购买数量
                    NSInteger oldTime = [[[existArr objectAtIndex:j] objectForKey:@"buyTimes"] integerValue];
                    NSInteger newTime = [[[cartArr objectAtIndex:i] objectForKey:@"buyTimes"] integerValue];
                    NSInteger totleTime = newTime + oldTime;
                    NSInteger superShare = [[[cartArr objectAtIndex:i] objectForKey:@"surplusShare"] integerValue];
                    if (totleTime > superShare) {
                    
                        [[existArr objectAtIndex:j] setObject:[NSNumber numberWithInteger:superShare] forKey:@"buyTimes"];
                        
                    }else{
                    
                        [[existArr objectAtIndex:j] setObject:[NSNumber numberWithInteger:totleTime] forKey:@"buyTimes"];
                        
                    }
                    
                    break;
                    
                }else if (haveSame == 0 && j == 0){
                    
                    [existArr insertObject:cartArr[i] atIndex:0];
                    
                }
                
            }
            
        }
        return [existArr writeToFile:filename atomically:YES];
        
    }else{
    
        //若不存在，直接将数据存入
        return [cartArr writeToFile:filename atomically:YES];
        
    }
    
}

+ (BOOL)removeGoodsWithIndexPath:(NSInteger)indexPath{

    //获取应用程序沙盒的Documents目录
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *plistPath = [paths objectAtIndex:0];
    //得到完整的文件名
    NSString *filename=[plistPath stringByAppendingPathComponent:@"cartList.plist"];
    //判断是否已有此目录文件
    BOOL isExst = [[NSFileManager defaultManager] fileExistsAtPath:filename];
    
    if (isExst) {
        
        //已存在
        NSMutableArray *existArr = [NSMutableArray arrayWithContentsOfFile:filename];
        
        if (indexPath >= existArr.count) {
            //数组越界抛出异常
            return NO;
        }else{
            [existArr removeObjectAtIndex:indexPath];
            return [existArr writeToFile:filename atomically:YES];
        }

    }else{
        return NO;
    }
}

+ (BOOL)realaseCartList{

    //获取应用程序沙盒的Documents目录
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *plistPath = [paths objectAtIndex:0];
    //得到完整的文件名
    NSString *filename=[plistPath stringByAppendingPathComponent:@"cartList.plist"];
    //判断是否已有此目录文件
    BOOL isExst = [[NSFileManager defaultManager] fileExistsAtPath:filename];
    
    if (isExst) {
        
        //已存在
        NSMutableArray *existArr = [NSMutableArray arrayWithContentsOfFile:filename];
        
        [existArr removeAllObjects];
        return [existArr writeToFile:filename atomically:YES];
        
    }else{
        
        return YES;
        
    }

}

//增加某一栏数量
+ (BOOL)addCountWithIndexPath:(NSInteger)indexPath{
    
    //获取应用程序沙盒的Documents目录
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *plistPath = [paths objectAtIndex:0];
    //得到完整的文件名
    NSString *filename=[plistPath stringByAppendingPathComponent:@"cartList.plist"];
    //判断是否已有此目录文件
    BOOL isExst = [[NSFileManager defaultManager] fileExistsAtPath:filename];
    if (isExst) {
        
        //已存在
        NSMutableArray *existArr = [NSMutableArray arrayWithContentsOfFile:filename];
        if (indexPath >= existArr.count) {
            
            NSLogZS(@"越界了");
            return NO;
            
        }else{
        
            //购买次数加一
            NSMutableDictionary *indexPathDic = [existArr objectAtIndex:indexPath];
            NSInteger times = [[indexPathDic objectForKey:@"buyTimes"] integerValue];
            NSInteger superShare = [[indexPathDic objectForKey:@"surplusShare"] integerValue];
            if (superShare > times) {
            
                times ++;
                
            }
            
            [indexPathDic setObject:[NSNumber numberWithInteger:times] forKey:@"buyTimes"];
            [existArr replaceObjectAtIndex:indexPath withObject:indexPathDic];
            return [existArr writeToFile:filename atomically:YES];
        
        }
        
    }else{
        
        return NO;
    
    }
    
}

//减少某一栏数量
+ (BOOL)decreaseCountWithIndexPath:(NSInteger)indexPath{

    //获取应用程序沙盒的Documents目录
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *plistPath = [paths objectAtIndex:0];
    //得到完整的文件名
    NSString *filename=[plistPath stringByAppendingPathComponent:@"cartList.plist"];
    //判断是否已有此目录文件
    BOOL isExst = [[NSFileManager defaultManager] fileExistsAtPath:filename];
    if (isExst) {
        
        //已存在
        NSMutableArray *existArr = [NSMutableArray arrayWithContentsOfFile:filename];
        if (indexPath >= existArr.count) {
            
            NSLogZS(@"越界了");
            return NO;
            
        }else{
            
            //购买次数加一
            NSMutableDictionary *indexPathDic = [existArr objectAtIndex:indexPath];
            NSInteger times = [[indexPathDic objectForKey:@"buyTimes"] integerValue];
            if (times > 1) {
                times --;
            }else{
                return NO;
            }
            [indexPathDic setObject:[NSNumber numberWithInteger:times] forKey:@"buyTimes"];
            [existArr replaceObjectAtIndex:indexPath withObject:indexPathDic];
            return [existArr writeToFile:filename atomically:YES];
            
        }
        
    }else{
        
        return NO;
        
    }
    
}

+ (BOOL)allRestWithIndexPath:(NSInteger)indexPath{

    //获取应用程序沙盒的Documents目录
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *plistPath = [paths objectAtIndex:0];
    //得到完整的文件名
    NSString *filename=[plistPath stringByAppendingPathComponent:@"cartList.plist"];
    //判断是否已有此目录文件
    BOOL isExst = [[NSFileManager defaultManager] fileExistsAtPath:filename];
    if (isExst) {
    
        //已存在
        NSMutableArray *existArr = [NSMutableArray arrayWithContentsOfFile:filename];
        if (indexPath >= existArr.count) {
            
            NSLogZS(@"越界了");
            return NO;
            
        }else{
            
            //包尾：剩下的全部买了
            NSMutableDictionary *indexPathDic = [existArr objectAtIndex:indexPath];
            NSInteger times = [[indexPathDic objectForKey:@"buyTimes"] integerValue];
            NSInteger superShare = [[indexPathDic objectForKey:@"surplusShare"] integerValue];
            if (superShare > times) {
                
                times = superShare;
                
            }
            
            [indexPathDic setObject:[NSNumber numberWithInteger:times] forKey:@"buyTimes"];
            [existArr replaceObjectAtIndex:indexPath withObject:indexPathDic];
            return [existArr writeToFile:filename atomically:YES];
            
        }
    
    }else{
    
        return NO;
        
    }

}

//输入购物车数量
+ (BOOL)inputCountWithIndexPath:(NSInteger)indexPath withCount:(NSInteger)count{

    //获取应用程序沙盒的Documents目录
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *plistPath = [paths objectAtIndex:0];
    //得到完整的文件名
    NSString *filename=[plistPath stringByAppendingPathComponent:@"cartList.plist"];
    //判断是否已有此目录文件
    BOOL isExst = [[NSFileManager defaultManager] fileExistsAtPath:filename];
    if (isExst) {
        //已存在
        NSMutableArray *existArr = [NSMutableArray arrayWithContentsOfFile:filename];
        if (indexPath >= existArr.count) {
            
            NSLogZS(@"越界了");
            return NO;
            
        }else{
            
            //输入购买数量：输入多少->小于剩余量
            NSMutableDictionary *indexPathDic = [existArr objectAtIndex:indexPath];
            NSInteger times = [[indexPathDic objectForKey:@"buyTimes"] integerValue];
            NSInteger superShare = [[indexPathDic objectForKey:@"surplusShare"] integerValue];
            if (superShare >= count) {
                
                times = count;
                
            }else{
                
                return NO;
            }
            
            [indexPathDic setObject:[NSNumber numberWithInteger:times] forKey:@"buyTimes"];
            [existArr replaceObjectAtIndex:indexPath withObject:indexPathDic];
            return [existArr writeToFile:filename atomically:YES];
            
        }
    }else{
        
        return NO;
        
    }
    
}

@end

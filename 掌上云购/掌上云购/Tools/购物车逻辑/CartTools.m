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
+ (BOOL)addCartList:(nullable NSArray *)cartArr{

//    //添加时，不能为空
//    if (cartArr.count == 0) {
//        
//        NSLogZS(@"添加不能为空");
//        return NO;
//    
//    }
    
    //获取应用程序沙盒的Documents目录
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *plistPath = [paths objectAtIndex:0];
    //得到完整的文件名
    NSString *filename=[plistPath stringByAppendingPathComponent:@"cartList.plist"];
    //判断是否已有此目录文件
    BOOL isExst = [[NSFileManager defaultManager] fileExistsAtPath:filename];
    
    if (isExst) {
    
        NSMutableArray *existArr = [NSMutableArray arrayWithContentsOfFile:filename];
//        (NSMutableArray *)[[NSFileManager defaultManager] contentsOfDirectoryAtPath:filename
//                                                                                       error:nil];
        
        for (int i = 0 ; i < cartArr.count; i ++) {
            
            [existArr addObject:cartArr[i]];
        }
        [existArr writeToFile:filename atomically:YES];
        
    }else{
    
        //若不存在，直接将数据存入
        [cartArr writeToFile:filename atomically:YES];
        
    }

    return NO;
    
}

+ (BOOL)removeGoodsWithIndexPath:(NSInteger)indexPath{

        return NO;
    
}

+ (BOOL)modefiGoodsWIthIndexPath:(NSInteger)indexPath{

        return NO;
    
}

+ (CGFloat)cartTotalCost{

        return NO;
    
}

@end

//
//  CartTools.h
//  掌上云购
//
//  Created by coco船长 on 16/8/25.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TabbarViewcontroller.h"

/*
 *购物车逻辑：
 *  以本地和服务器定触发机制合并更新的方式更新和保存。
 *  触发点：购物车界面即将展示、购物车界面即将消失、退出登录。
 *  触发操作：1.未登录状态：购物车操作本地文件，与后台数据无关。
 *          2.已登录状态：（1）购物车界面即将展示：拉取后台购物车，合并、保存至本地文件；
 *                      （2）购物车界面即将消失：上传购物车至后台，（注：返回购物车id）；
 *                      （3）退出登录：清空本地保存的购物车文件。
 *  存储位置：沙盒Doc目录下的cartList.plist。
 */

@interface CartTools : NSObject

//查询商品
+ (NSArray *)getCartList;
//增加商品
+ (BOOL)addCartList:(NSArray *)cartArr;
//删除某一栏
+ (BOOL)removeGoodsWithIndexPath:(NSInteger)indexPath;
//清空购物车
+ (BOOL)realaseCartList;
//增加某一栏数量
+ (BOOL)addCountWithIndexPath:(NSInteger)indexPath;
//减少某一栏数量
+ (BOOL)decreaseCountWithIndexPath:(NSInteger)indexPath;
//包尾
+ (BOOL)allRestWithIndexPath:(NSInteger)indexPath;
//输入某一栏数量
+ (BOOL)inputCountWithIndexPath:(NSInteger)indexPath withCount:(NSInteger)count;

@end

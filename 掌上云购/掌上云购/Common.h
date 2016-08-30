//
//  Common.h
//  掌上云购
//
//  Created by coco船长 on 16/8/3.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#ifndef Common_h
#define Common_h


//测试服务器
#define BASE_URL @"http://192.168.0.252:8889"

/*---------------登陆注册模块----------------------*/
//会员登陆
#define Login_URL   @"/pcpServer-inf/user/login"
//会员注册
#define Regist_URL  @"/pcpServer-inf/user/register"
//找回密码
#define FindPWD_URL @"/pcpServer-inf/user/updatepass"

/*---------------首页商品模块---------------------*/
//商品列表
#define GoodsList_URL @"/pcpServer-inf/product/list"
//商品详情
#define GoodsDetail_URL @"/pcpServer-inf/product/detail"
//参与记录
#define GoodsJoinRecords_URL @"/pcpServer-inf/sale/partiList"
//图文详情
#define GoodsTPdetail_URL @"/pcpServer-inf/product/detailHtml"
//历史期数
#define GoodsHistoryPrize_URL @"/pcpServer-inf/saleDraw/pastList"

/*---------------购物车模块---------------------*/
//查询云购物车数据
#define CartList_URL @"/pcpServer-inf/saleCart/list"
//上传本地购物车
#define CartListUpload_URL @"/pcpServer-inf/saleCart/add"

/*---------------我的云购模块---------------------*/
//我的云购记录列表
#define UserOrderList_URL @"/pcpServer-inf/sale/userOrderList"
//幸运记录列表
#define LuckyNumberList_URL @"/pcpServer-inf/sale/luckyNumberList"
//确认地址接口
#define ConfirmAddress_URL @"/pcpServer-inf/sale/confirmAddress"

/*---------------分类模块----------------------*/
#define CategorysList_URL @"/pcpServer-inf/proCategory/list"

/*---------------收货地址模块----------------------*/
//省、市、区
#define AreaProvince_URL @"/pcpServer-inf/area/province"
//新增收货地址
#define AddArea_URL @"/pcpServer-inf/user/consignee/ add"
//默认收货地址
#define DefaultArea_URL @"/pcpServer-inf/user/consignee/default"
//收货地址列表
#define AreaList_URL @"/pcpServer-inf/user/consignee/list"
//收货地址删除
#define DeleteArea_URL @"/pcpServer-inf/user/consignee/delete"
//收货地址修改
#define UpdateArea_URL @"/pcpServer-inf/user/consignee/update"

/*---------------发现模块---------------------*/
//晒单分享
#define Sunsharing_URL @"/pcpServer-inf/user/userComment/list"

/*---------------充值模块---------------------*/
#define RechargeList_URL @"/pcpServer-inf/saleMoneyRecharge/list"

#endif /* Common_h */

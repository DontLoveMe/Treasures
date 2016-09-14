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
//测试服务器1
//#define BASE_URL @"http://192.168.0.117:8080"
//外网服务器
//#define BASE_URL @"http://121.43.164.18:8080"
//玲姐服务器
//#define BASE_URL @"http://192.168.0.252:8889"

/*---------------登陆注册模块----------------------*/
//会员登陆
#define Login_URL   @"/pcpServer-inf/user/login"
//会员注册
#define Regist_URL  @"/pcpServer-inf/user/register"
//第三方登录
#define ThirdLogin_URL @"/pcpServer-inf/userThirdLogin/thirdLogin"
//第三方登录绑定手机
#define ThirdLoginPhone_URL @"/pcpServer-inf/userThirdLogin/thirdLoginPhone"
//修改密码
#define UpdatePWD_URL @"/pcpServer-inf/user/updatepass"
//找回密码
#define FindPWD_URL @"/pcpServer-inf/user/resetpass"
//请求验证码
#define SendCode_URL @"/pcpServer-inf/sms/sendCode"

/*---------------分类模块----------------------*/
//分类名列表
#define CategorysList_URL @"/pcpServer-inf/proCategory/list"

/*---------------首页商品模块---------------------*/
//首页banner
#define HomeBanner_URL @"/pcpServer-inf/cmsBanner/list"
//首页公告通知
#define HomePrizeList_URL @"/pcpServer-inf/saleDraw/drawComment"
//商品列表（搜索）
#define GoodsList_URL @"/pcpServer-inf/product/list"
//商品详情
#define GoodsDetail_URL @"/pcpServer-inf/product/detail"
//参与记录
#define GoodsJoinRecords_URL @"/pcpServer-inf/sale/partiList"
//图文详情
#define GoodsTPdetail_URL @"/pcpServer-inf/product/detailHtml"
//历史期数
#define GoodsHistoryPrize_URL @"/pcpServer-inf/saleDraw/pastList"
//历史期数
#define GoodsHistoryPrize_URL @"/pcpServer-inf/saleDraw/pastList"
//猜你喜欢
#define LoveProduct_URL @"/pcpServer-inf/product/love"
//计算方法
#define CountWay_URL @"/pcpServer-inf/sale/computationalFormula"


/*---------------最新揭晓模块---------------------*/
//最新揭晓列表
#define NewnestAnnounceList_URL @"/pcpServer-inf/saleDraw/announce"
//最新揭晓详情
#define NewnestAnnounceDetail_URL @"/pcpServer-inf/saleDraw/drawAnnounce"

/*---------------购物车模块---------------------*/
//查询云购物车数据
#define CartList_URL @"/pcpServer-inf/saleCart/list"
//上传本地购物车
#define CartListUpload_URL @"/pcpServer-inf/saleCart/add"
//提交订单
#define SubmitCartList_URL @"/pcpServer-inf/saleCart/submitPayment"
////支付订单
//#define PayOrder_URL @"/pcpServer-inf/saleOrderPay/orderpay"

/*---------------我的云购模块---------------------*/
//我的云购记录列表
#define UserOrderList_URL @"/pcpServer-inf/sale/userOrderList"
//幸运记录列表
#define LuckyNumberList_URL @"/pcpServer-inf/sale/luckyNumberList"
//确认地址接口
#define ConfirmAddress_URL @"/pcpServer-inf/sale/confirmAddress"
//订单详情接口
#define SaleOrderStatus_URL @"/pcpServer-inf/sale/saleOrderStatus"
//确定收货
#define ConfirmReceipt_URL @"/pcpServer-inf/sale/confirmReceipt"
//确定物品
#define ConfirmGoods_URL @"/pcpServer-inf/sale/confirmGoods"
//延期收货
#define DeferredReceipt_URL @"/pcpServer-inf/sale/deferredReceipt"
//已发卡密或充值到余额
#define RechargeBalance_URL @"/pcpServer-inf/sale/rechargeBalance"

//可用红包列表接口
#define RedPacketList_URL @"/pcpServer-inf/red/packet/list"
//已使用/失效红包列表接口
#define RedPacketDisabledList_URL @"/pcpServer-inf/red/packet/disabledList"
//消息列表接口
#define MessageList_URL @"/pcpServer-inf/messageSite/list"


/*---------------收货地址模块----------------------*/
//省、市、区
#define AreaProvince_URL @"/pcpServer-inf/area/province"
//新增收货地址
#define AddArea_URL @"/pcpServer-inf/user/consignee/add"
//默认收货地址
#define DefaultArea_URL @"/pcpServer-inf/user/consignee/default"
//收货地址列表
#define AreaList_URL @"/pcpServer-inf/user/consignee/list"
//收货地址删除
#define DeleteArea_URL @"/pcpServer-inf/user/consignee/delete"
//收货地址修改
#define UpdateArea_URL @"/pcpServer-inf/user/consignee/update"

/*---------------用户信息---------------------*/
//用户信息
#define UserInfo_URL @"/pcpServer-inf/user/getUserInfo"
//用户信息修改
#define EditUserInfo_URL @"/pcpServer-inf/user/editUserInfo"
//用户信息修改
#define BindingEmail_URL @"/pcpServer-inf/user/bindingEmail"

/*---------------发现模块---------------------*/
//晒单分享列表
#define Sunsharing_URL @"/pcpServer-inf/user/userComment/list"
//晒单详情
#define SunshareDetail_URL @"/pcpServer-inf/user/userComment/detail"
//新增晒单
#define InsertSunshare_URL @"/pcpServer-inf/user/userComment/insert"

/*---------------充值模块---------------------*/
//充值记录列表
#define RechargeList_URL @"/pcpServer-inf/saleMoneyRecharge/list"
//微信充值
#define WeixinRecharge_URL @"/pcpServer-inf/saleMoneyRecharge/weixinRecharge"

/*---------------文件上传---------------------*/
//文件上传
#define UpdataFile_URL @"/pcpfiles/file/upload"

#endif /* Common_h */

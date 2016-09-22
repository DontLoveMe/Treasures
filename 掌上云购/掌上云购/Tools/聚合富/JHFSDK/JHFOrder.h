//
//  JHFOrder.h
//  JHPayDemo
//
//
//

#import <Foundation/Foundation.h>

@interface JHFOrder : NSObject

@property (nonatomic, copy) NSString *version;     //版本号（*）
@property (nonatomic, copy) NSString *merid;       //商户编号（*）
@property (nonatomic, copy) NSString *mername;     //商户名称（*）
@property (nonatomic, copy) NSString *policyid;    //商户支付策略编号（*）
@property (nonatomic, copy) NSString *merorderid;  //商户订单号（*）
@property (nonatomic, copy) NSString *paymoney;    //订单支付金额（*）
@property (nonatomic, copy) NSString *productname; //商品名称
@property (nonatomic, copy) NSString *productdesc; //商品描述
@property (nonatomic, copy) NSString *userid;      //用户ID（*）
@property (nonatomic, copy) NSString *username;    //用户名称
@property (nonatomic, copy) NSString *email;       //用户邮箱
@property (nonatomic, copy) NSString *phone;       //用户联系电话
@property (nonatomic, copy) NSString *extra;       //商户附加信息
@property (nonatomic, copy) NSString *custom;      //商户定制信息
@property (nonatomic, copy) NSString *md5;         //MD5校验值（*）
@property (nonatomic, copy) NSString *cardtype;    //订单类型（*）
@property (nonatomic, copy) NSString *ostype;      //操作系统

// 拼接HTTP POST请求数据；订单数据校验接口
- (NSString *)httpBody;
// 拼接HTTP POST请求数据；微信支付宝支付服务器下单
- (NSString *)httpBody2;

@end

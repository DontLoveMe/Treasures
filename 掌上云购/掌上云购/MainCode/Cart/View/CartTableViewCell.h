//
//  CartTableViewCell.h
//  掌上云购
//
//  Created by 杨浩斌 on 16/8/15.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import <UIKit/UIKit.h>


//增减代理
@protocol CartFunctionDelegate <NSObject>

//增加事件
-(void)addCountAtIndexPath:(NSIndexPath *)indexPath;

//减少事件
-(void)reduceCountAtIndexPath:(NSIndexPath *)indexPath;

//包尾事件
-(void)allRestAtIndexPath:(NSIndexPath *)indexPath;

//输入事件
- (void)inputAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface CartTableViewCell : UITableViewCell<UITextFieldDelegate>

@property(nonatomic,strong)NSIndexPath* indexPath;
//标记图片
//@property(nonatomic,strong)UIImageView *goodsType;

//商品图片
@property(nonatomic,strong)UIImageView *goodsImg;

//商品名称
@property(nonatomic,strong)UILabel *goodsTitle;

//总人次
@property(nonatomic,strong)UILabel *totalNumber;

//剩余人次
@property(nonatomic,strong)UILabel *surplusNumber;

//价格
@property(nonatomic,strong)UILabel *price;

//人次
@property(nonatomic,strong)UILabel *passengers;

//购买数量标签
//@property(nonatomic,strong)UILabel *goodsNumLab;
@property(nonatomic,strong)UITextField *goodsNumLab;

//添加数量标签
@property(nonatomic,strong)UIButton *addBtn;

//删除数量标签
@property(nonatomic,strong)UIButton *deleteBtn;

//是否选中按钮
@property(nonatomic,strong)UIButton *isSelectBtn;

//是否选中图片
@property(nonatomic,strong)UIImageView *isSelectImg;

////复选框文字
//@property(nonatomic,strong)UILabel *checkboxText;
//
////选中状态
//@property(nonatomic,assign)BOOL selectState;

//包尾按钮
@property (nonatomic,strong)UIButton    *allRestButton;

@property (nonatomic ,weak)id <CartFunctionDelegate> functionDelegate;

@property (nonatomic ,assign)NSInteger maxSelectableNum;

@end

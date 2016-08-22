//
//  CartTableViewCell.h
//  掌上云购
//
//  Created by 杨浩斌 on 16/8/15.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import <UIKit/UIKit.h>


////添加用于按钮加减的代理
//@protocol CartTableViewCellDelegate <NSObject>
//
//-(void)btnClick:(UITableViewCell *)cell andFlag:(NSInteger)flag;
//
//
////删除按钮
//-(void)deleteClickedWithIndexPath:(NSIndexPath *)indexPath;
//
//@end

@interface CartTableViewCell : UITableViewCell


//标记图片
@property(nonatomic,strong)UIImageView *goodsType;

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
@property(nonatomic,strong)UILabel *goodsNumLab;

//添加数量标签
@property(nonatomic,strong)UIButton *addBtn;

//删除数量标签
@property(nonatomic,strong)UIButton *deleteBtn;

//是否选中按钮
@property(nonatomic,strong)UIButton *isSelectBtn;

//是否选中图片
@property(nonatomic,strong)UIImageView *isSelectImg;

//复选框文字
@property(nonatomic,strong)UILabel *checkboxText;

//选中状态
@property(nonatomic,assign)BOOL selectState;


//@property(nonatomic,assign)id<CartTableViewCellDelegate>delegate;



@end

//
//  CartTableViewCell.m
//  掌上云购
//
//  Created by 杨浩斌 on 16/8/15.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import "CartTableViewCell.h"
#import "UIView+SDAutoLayout.h"
@implementation CartTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self initWithUI];
    }

    return self;
}

-(void)initWithUI{

    //商品图片
    _goodsImg = [[UIImageView alloc]init];
    [self.contentView addSubview:_goodsImg];
    _goodsImg.sd_layout
    .leftSpaceToView(self.contentView,8)
    .topSpaceToView(self.contentView,8)
    .widthIs(90)
    .heightIs(85);
    //商品分类
//    _goodsType = [[UIImageView alloc]init];
//    [_goodsImg addSubview:_goodsType];
//    _goodsType.sd_layout
//    .leftSpaceToView(_goodsImg,0)
//    .topSpaceToView(_goodsImg,0)
//    .widthIs(20)
//    .heightIs(20);
    //商品名
    _goodsTitle = [[UILabel alloc]init];
    _goodsTitle.textColor = [UIColor blackColor];
    _goodsTitle.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:_goodsTitle];
    _goodsTitle.sd_layout
    .leftSpaceToView(_goodsImg,8)
    .topSpaceToView(self.contentView,8)
    .rightSpaceToView(self.contentView,8)
    .heightIs(20);
    //商品总量
    _totalNumber = [[UILabel alloc]init];
    _totalNumber.textColor = [UIColor blackColor];
    _totalNumber.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:_totalNumber];
    _totalNumber.sd_layout
    .leftEqualToView(_goodsTitle)
    .topSpaceToView(_goodsTitle,4)
    .widthIs(100)
    .heightIs(20);
    //商品剩余量
    _surplusNumber = [[UILabel alloc]init];
    _surplusNumber.textColor = [UIColor blackColor];
    _surplusNumber.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:_surplusNumber];
    _surplusNumber.sd_layout
    .leftSpaceToView(_totalNumber,8)
    .topEqualToView(_totalNumber)
    .widthIs(100)
    .heightIs(20);
    //减少按钮
    _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_deleteBtn setImage:[UIImage imageNamed:@"按钮-"] forState:UIControlStateNormal];
    [_deleteBtn addTarget:self
                action:@selector(reduceAction:)
      forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_deleteBtn];
    _deleteBtn.sd_layout
    .leftEqualToView(_totalNumber)
    .topSpaceToView(_totalNumber,4)
    .heightIs(28)
    .widthIs(28);
    //选择量
    _goodsNumLab = [[UITextField alloc]init];
    _goodsNumLab.textColor = [UIColor blackColor];
    _goodsNumLab.keyboardType = UIKeyboardTypeNumberPad;
    _goodsNumLab.delegate = self;
    _goodsNumLab.font = [UIFont systemFontOfSize:13];
    _goodsNumLab.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_goodsNumLab];
    _goodsNumLab.textColor = [UIColor redColor];
    _goodsNumLab.sd_layout
    .leftSpaceToView(_deleteBtn,0)
    .topEqualToView(_deleteBtn)
    .widthIs(50)
    .heightIs(28);
    //增加按钮
    _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_addBtn setImage:[UIImage imageNamed:@"按钮+"] forState:UIControlStateNormal];
    [_addBtn addTarget:self
                   action:@selector(addAction:)
         forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_addBtn];
    _addBtn.tag = 12;
    _addBtn.sd_layout
    .leftSpaceToView(_goodsNumLab,0)
    .topEqualToView(_goodsNumLab)
    .widthIs(28)
    .heightIs(28);
    //单位
    _passengers = [[UILabel alloc]init];
    _passengers.text = @"人次";
    _passengers.textColor = [UIColor blackColor];
    _passengers.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:_passengers];
    _passengers.sd_layout
    .leftSpaceToView(_addBtn,5)
    .topSpaceToView(_surplusNumber,20)
    .widthIs(35)
    .heightIs(10);
    //价格
    _price = [[UILabel alloc]init];
    _price.text = @"元/次";
    _price.textColor = [UIColor redColor];
    _price.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:_price];
    _price.sd_layout
    .leftEqualToView(_deleteBtn)
    .topSpaceToView(_deleteBtn,4)
    .widthIs(80)
    .heightIs(20);
    
//    //包尾
    _allRestButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_allRestButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_allRestButton setTitle:@"包尾" forState:UIControlStateNormal];
    [_allRestButton setBackgroundImage:[UIImage imageNamed:@"按钮背景"] forState:UIControlStateNormal];
    [_allRestButton addTarget:self
                       action:@selector(allRestAction:)
             forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_allRestButton];
    
    _allRestButton.sd_layout
    .leftSpaceToView(_passengers,5)
    .topEqualToView(_addBtn)
    .widthIs(50)
    .heightIs(25);
    
    //下面的线
    _bottomLine = [[UIImageView alloc] init];
    _bottomLine.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:_bottomLine];
    _bottomLine.sd_layout
    .xIs(12)
    .yIs(111)
    .widthIs(KScreenWidth - 24.f)
    .heightIs(1);
}

#pragma mark - ButtonAction
- (void)addAction:(UIButton *)button{

    if ([_functionDelegate respondsToSelector:@selector(addCountAtIndexPath:)]) {
        [_functionDelegate addCountAtIndexPath:_indexPath];
    }
    
}

- (void)reduceAction:(UIButton *)button{

    if ([_functionDelegate respondsToSelector:@selector(reduceCountAtIndexPath:)]) {
        [_functionDelegate reduceCountAtIndexPath:_indexPath];
    }

}

- (void)allRestAction:(UIButton *)button{

    if ([_functionDelegate respondsToSelector:@selector(allRestAtIndexPath:)]) {
        [_functionDelegate allRestAtIndexPath:_indexPath];
    }
    
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{

    if ([textField isFirstResponder]) {
        return YES;
    }else return NO;
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    if ([textField isFirstResponder]) {
        [textField resignFirstResponder];
    }
    if ([textField.text integerValue] == 0 || textField.text.length == 0){
        
        textField.text = @"1";
        return;
        
    }else if ([textField.text integerValue] <= _maxSelectableNum) {
        
        [CartTools inputCountWithIndexPath:_indexPath.row withCount:[textField.text integerValue]];
        [self getRootController].cartNum = [CartTools getCartList].count;
        if ([_functionDelegate respondsToSelector:@selector(inputAtIndexPath:)]) {
            [_functionDelegate inputAtIndexPath:_indexPath];
        }
        
    }else{
        
        textField.text = [NSString stringWithFormat:@"%ld",_maxSelectableNum];
        return;
        
    }
    
}

//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
//
//    if ([textField.text integerValue] == 0 || textField.text.length == 0){
//        
//        textField.text = @"1";
//        
//    }else if ([textField.text integerValue] <= _maxSelectableNum) {
//        
//        textField.text = textField.text;
////        NSMutableString *textFieldString = [textField.text mutableCopy];
////        [textFieldString insertString:string atIndex:range.location];
////        textField.text = textFieldString;
//        
//    }else{
//        
//        textField.text = [NSString stringWithFormat:@"%ld",_maxSelectableNum];
//        
//    }
//    NSLog(@"%@ ,ohther:%@",textField.text,string);
//    [CartTools inputCountWithIndexPath:_indexPath.row withCount:[textField.text integerValue]];
//    [self getRootController].cartNum = [CartTools getCartList].count;
//
//    return YES;
//
//}
//

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
 
    [super touchesBegan:touches withEvent:event];
    if ([_goodsNumLab isFirstResponder]) {
            [_goodsNumLab resignFirstResponder];
    }

}

//取到视图控制器
- (UIViewController *)viewController {
    
    UIResponder *next = self.nextResponder;
    
    do {
        
        if ([next isKindOfClass:[UIViewController class]]) {
            
            return (UIViewController *)next;
        }
        
        next = next.nextResponder;
        
    } while (next != nil);
    
    return nil;
}

- (TabbarViewcontroller *)getRootController{

    UIApplication *app = [UIApplication sharedApplication];
    UIWindow *windows = app.keyWindow;
    return (TabbarViewcontroller *)windows.rootViewController;

}


@end

//
//  AddAddressController.h
//  掌上云购
//
//  Created by 刘毅 on 16/8/17.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import "BaseViewController.h"
#import "AreaPickerView.h"
#import "AddressModel.h"

@interface AddAddressController : BaseViewController<UITextFieldDelegate,UITextViewDelegate,AreaPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UITextField *addressTF;
@property (weak, nonatomic) IBOutlet UITextView *detailAddressTV;
@property (weak, nonatomic) IBOutlet UIButton *defaultBtn;
@property (weak, nonatomic) IBOutlet UIButton *addButton;

@property (nonatomic,strong) NSNumber *provinceId;
@property (nonatomic,strong) NSNumber *cityId;
@property (nonatomic,strong) NSNumber *areaId;

@property (nonatomic,strong) NSNumber *isDefaul;

@property (nonatomic,strong) AddressModel *model;
@end

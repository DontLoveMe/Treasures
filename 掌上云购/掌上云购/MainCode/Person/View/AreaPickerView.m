//
//  AreaPickerView.m
//  掌上云购
//
//  Created by 刘毅 on 16/8/18.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import "AreaPickerView.h"
#import "AreaData.h"

@interface AreaPickerView()<UIPickerViewDelegate,UIPickerViewDataSource>

/** 背景 */
@property (nonatomic,strong)UIView         *bgView;
/** 标题 */
@property (nonatomic,strong)UILabel        *titleLabel;
/** 取消按钮 */
@property (nonatomic,strong)UIButton       *cancelBtn;
/** 完成按钮 */
@property (nonatomic,strong)UIButton       *completesBtn;
/** 选择器 */
@property (nonatomic,strong)UIPickerView   *pickerView;

/** 地区 */
/** 当前省数组 */
@property (nonatomic, strong)NSArray        *provinces;
/** 当前城市数组 */
@property (nonatomic, strong)NSArray        *citys;
/** 当前地区数组 */
@property (nonatomic, strong)NSArray        *areas;
/** 省份 */
@property (nonatomic, strong)NSDictionary   *province;
/** 城市 */
@property (nonatomic, strong)NSDictionary   *city;
/** 地区 */
@property (nonatomic, strong)NSDictionary   *area;

@end
@implementation AreaPickerView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initViews];
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initViews];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initViews];
    }
    return self;
}
#pragma mark - 初始化子视图
- (void)initViews {
    
    self.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.5];
    self.bgView = [[UIView alloc]initWithFrame:CGRectMake(0, KScreenHeight, KScreenWidth, 260*KScreenHeight/667)];
    self.bgView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.bgView];
    
    [self showAnimation];
    
    //取消
    self.cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.bgView addSubview:self.cancelBtn];
    
    self.cancelBtn.frame = CGRectMake(15, 0, 50, 44);
    self.cancelBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [self.cancelBtn addTarget:self action:@selector(cancelBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //完成
    self.completesBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.bgView addSubview:self.completesBtn];
    self.completesBtn.frame = CGRectMake(KScreenWidth-60, 0, 60, 44);
    self.completesBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.completesBtn setTitle:@"完成" forState:UIControlStateNormal];
    [self.completesBtn addTarget:self action:@selector(completeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.completesBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    //选择title
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.cancelBtn.frame), 0, KScreenWidth-110, 44)];
    [self.bgView addSubview:self.titleLabel];
    
    self.titleLabel.font = [UIFont systemFontOfSize:15];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.text = @"请选择地区";
    //线
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.cancelBtn.frame), KScreenWidth, 0.5)];
    [self.bgView addSubview:line];
    
    line.backgroundColor = [UIColor grayColor];
    
    //选择器
    self.pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(line.frame), KScreenWidth, CGRectGetHeight(self.bgView.frame)-CGRectGetMaxY(self.cancelBtn.frame))];
    [self.bgView addSubview:self.pickerView];
    
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
    
    self.provinces = [AreaData getProvinces];
    self.citys = [AreaData getAreas:[self.provinces firstObject][@"id"]];
    self.province = self.provinces[0];
    self.city = self.citys[0];
}



#pragma mark - UIPickerViewDataSource,UIPickerViewDelegate
//组数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
 
    return 3;
}
//个数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
        if (component == 0) {
            return self.provinces.count;
        }else if (component == 1) {
            return self.citys.count;
        }else{
            return self.areas.count;
        }
    
}
//高度
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    
    return 28;
}
//自定义单元格
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view{
    
    UILabel *label=[[UILabel alloc] init];
    label.textAlignment = NSTextAlignmentCenter;
   
        NSString *text;
        if (component == 0) {
            NSDictionary *provinceDic = self.provinces[row];
            text =  provinceDic[@"name"];
        }else if (component == 1){
            NSDictionary *cityDic = self.citys[row];
            text =  cityDic[@"name"];
        }else{
            if (self.areas.count > 0) {
                NSDictionary *areaDic = self.areas[row];
                text =  areaDic[@"name"];
            }else{
                text =  @"";
            }
        }
        label.text = text;
  
    return label;
   
}

//选中的单元格
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {

    if (component == 0) {
        NSDictionary *provinceDic = self.provinces[row];
  
        self.citys = [AreaData getCitys:provinceDic[@"id"]];
        
        self.areas = [AreaData getAreas:[self.citys firstObject][@"id"]];

        [pickerView reloadComponent:1];
        [pickerView reloadComponent:2];
        [pickerView selectRow:0 inComponent:1 animated:YES];
        [pickerView selectRow:0 inComponent:2 animated:YES];

        self.province = provinceDic;
        self.city = self.citys[0];
        if (self.areas.count > 0) {
            self.area = self.areas[0];
        }
    }else if (component == 1) {

        NSDictionary *cityDic = self.citys[row];
        self.areas = [AreaData getAreas:cityDic[@"id"]];
        
        [pickerView reloadComponent:2];
        [pickerView selectRow:0 inComponent:2 animated:YES];
        self.city = cityDic;
        if (self.areas.count > 0) {
            self.area = self.areas[0];
        }
    }else{
        self.area = self.areas[row];
    }
    NSString *area = @"";
    if (self.area) {
        area = self.area[@"name"];
    }
    _titleLabel.text = [NSString stringWithFormat:@"%@%@%@",self.province[@"name"],self.city[@"name"],area];
}


#pragma mark-----点击方法
//取消
- (void)cancelBtnClick{
    
    [self hideAnimation];
    
}
//完成
- (void)completeBtnClick{
    if (self.areas.count > 0) {
        [self.delegate areaPickerViewSelectProvince:_province city:_city area:_area];
    }else {
        [self.delegate areaPickerViewSelectProvince:_province city:_city area:nil];
    }
    
   
    [self hideAnimation];
    
}
//点击
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self hideAnimation];
    
}
#pragma mark - 显示隐藏动画
//隐藏动画
- (void)hideAnimation{
    
    [UIView animateWithDuration:0.5 animations:^{
        
        self.bgView.transform = CGAffineTransformIdentity;
        
    } completion:^(BOOL finished) {
        
        [self.bgView removeFromSuperview];
        [self removeFromSuperview];
        
    }];
    
}

//显示动画
- (void)showAnimation{
    
    [UIView animateWithDuration:0.5 animations:^{
        
        self.bgView.transform = CGAffineTransformMakeTranslation(0, -260*KScreenHeight/667);
    }];
    
}
@end

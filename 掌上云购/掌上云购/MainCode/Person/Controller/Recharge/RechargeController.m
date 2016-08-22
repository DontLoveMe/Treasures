//
//  RechargeController.m
//  掌上云购
//
//  Created by 刘毅 on 16/8/15.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import "RechargeController.h"
#import "RechargeCell.h"

@interface RechargeController ()

@end

@implementation RechargeController {
    
    UIImageView * _selectMoneyView;//勾
    NSArray * _moneys;//金额数组
    NSArray * _manners;//支付方式数组
    UITableView *_tableView;
    NSString *_identify;
    
    NSString *_moneyStr;//选择金额
    NSString *_mannerStr;//选择充值方式
    
    UITextField *_textField;
}

#pragma mark - 导航栏
- (void)initNavBar{
    
    self.navigationItem.backBarButtonItem = nil;
    UIButton *leftButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 20.f, 25.f)];
    leftButton.tag = 101;
    [leftButton setBackgroundImage:[UIImage imageNamed:@"返回.png"]
                          forState:UIControlStateNormal];
    [leftButton addTarget:self
                   action:@selector(NavAction:)
         forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftItem;
    
}

- (void)NavAction:(UIButton *)button{
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"充值";
    
    [self initNavBar];
    
    //创建充值金额视图
    [self createRechargeMoneyView];
    
    //创建充值方式视图
    [self createRechargeMannerView];
}

//创建充值金额视图
- (void)createRechargeMoneyView {
    
    UILabel *moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 150, 20)];
    moneyLabel.text = @"选择充值金额";
    moneyLabel.textColor = [UIColor blackColor];
    moneyLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:moneyLabel];
    
    _moneys = @[@"20",@"50",@"100",@"200",@"500",@"其他金额"];
    _moneyStr = @"20";
    
    CGFloat w = (KScreenWidth-15*4)/3;
    CGFloat y = CGRectGetMaxY(moneyLabel.frame)+8;
    for (int i = 0; i < _moneys.count; i ++) {
        if (i == _moneys.count-1) {
            
            _textField = [[UITextField alloc] initWithFrame:CGRectMake((w+15)*(i%3)+15, (40+10)*(i/3)+y, w, 40)];
            _textField.clipsToBounds = NO;
            _textField.textAlignment = UIKeyboardTypePhonePad;
            _textField.borderStyle = UITextBorderStyleLine;
            _textField.keyboardType = UIKeyboardTypeNumberPad;
            _textField.font = [UIFont systemFontOfSize:14];
            _textField.textColor = [UIColor blackColor];
            _textField.placeholder = _moneys[i];
            [self.view addSubview:_textField];
            _textField.delegate = self;
            
            return;
        }
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.backgroundColor = [UIColor grayColor];
        button.tag = 200 + i;
        button.frame = CGRectMake((w+15)*(i%3)+15, (40+10)*(i/3)+y, w, 40);
        [button setTitle:_moneys[i] forState:UIControlStateNormal];
//        [button setBackgroundImage:[UIImage imageNamed:@"normal"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        
        if (i == 0) {
            _selectMoneyView = [[UIImageView alloc] initWithFrame:CGRectMake(w-13, -7, 20, 20)];
//            _selectMoneyView.backgroundColor = [UIColor blueColor];
            _selectMoneyView.image = [UIImage imageNamed:@"对勾"];
            [button addSubview:_selectMoneyView];
        }
    }
    
}

//创建充值方式视图
- (void)createRechargeMannerView {
    
    UILabel *mannerLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 130, 150, 20)];
    mannerLabel.text = @"选择充值方式";
    mannerLabel.textColor = [UIColor blackColor];
    mannerLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:mannerLabel];
    
    _manners = @[@"微信支付",@"支付宝支付",@"银联支付"];
    _mannerStr = @"微信支付";
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(mannerLabel.frame)+5, KScreenWidth, 44*_manners.count) style:UITableViewStylePlain];
    _tableView.contentSize = CGSizeMake(KScreenWidth, 44*_manners.count);
    [self.view addSubview:_tableView];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    _identify = @"RechargeCell";
    [_tableView registerNib:[UINib nibWithNibName:@"RechargeCell" bundle:nil] forCellReuseIdentifier:_identify];
    
    
    UIButton *confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
    confirmButton.frame = CGRectMake((KScreenWidth-120)/2, KScreenHeight - 180, 120, 40);
    [confirmButton setTitle:@"确认支付" forState:UIControlStateNormal];
    [confirmButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [button setBackgroundImage:[UIImage imageNamed:@"normal"] forState:UIControlStateNormal];
    [confirmButton addTarget:self action:@selector(confirmAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:confirmButton];
}
#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _manners.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RechargeCell *cell = [tableView dequeueReusableCellWithIdentifier:_identify forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.iconView.image = [UIImage imageNamed:_manners[indexPath.row]];
    cell.contentLabel.text = _manners[indexPath.row];
    if (indexPath.row == 0) {
        cell.drawButton.selected = YES;
    }
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [_textField resignFirstResponder];
    if (indexPath.row != 0) {
     
        RechargeCell *cell = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]];
        cell.drawButton.selected = NO;
    }
    RechargeCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.drawButton.selected = YES;
    _mannerStr = _manners[indexPath.row];
}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    RechargeCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.drawButton.selected = NO;
}
#pragma mark - UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    [textField addSubview:_selectMoneyView];
}
- (void)textFieldDidEndEditing:(UITextField *)textField {
    _moneyStr = _textField.text;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [_textField resignFirstResponder];
}

- (void)buttonAction:(UIButton *)button {
    [button addSubview:_selectMoneyView];
    
    [_textField resignFirstResponder];
    
    _moneyStr = _moneys[button.tag - 200];
}
//确认支付
- (void)confirmAction:(UIButton *)button {
    if (_moneyStr.length == 0) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示"
                                                                                 message:@"请选择充值金额" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"好"
                                                               style:UIAlertActionStyleCancel
                                                             handler:^(UIAlertAction * _Nonnull action) {
                                                                 [alertController dismissViewControllerAnimated:YES
                                                                                                     completion:nil];
                                                             }];
        [alertController addAction:cancelAction];
        [self presentViewController:alertController
                           animated:YES
                         completion:nil];
        return;
    }
    NSLogZS(@"%@--%@",_moneyStr,_mannerStr);
}
@end

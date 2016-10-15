//
//  CartViewController.m
//  掌上云购
//
//  Created by coco船长 on 16/8/3.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import "CartViewController.h"

@interface CartViewController ()

@end

@implementation CartViewController
-(void)creatNav{
    
    //设置右视图
    _rightbtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    
    [_rightbtn setTitle:@"编辑" forState:UIControlStateNormal];
    
    [_rightbtn setTitle:@"取消" forState:UIControlStateSelected];
    
    [_rightbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [_rightbtn addTarget:self action:@selector(Clicked:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *custom = [[UIBarButtonItem alloc]initWithCustomView:_rightbtn];
    
    self.navigationItem.rightBarButtonItem = custom;
    
}

#pragma mark----编辑事件
-(void)Clicked:(UIButton *)btn{
    
    NSLog(@"编辑");
    if (btn.selected) {
        btn.selected = NO;
        [_tabview setEditing:NO animated:YES];
        _deleteView.hidden = YES;
        _bottomView.hidden = NO;
        _allSelectButton.selected = NO;
        specialTag = 0;
        [_tabview reloadData];
        
    }else{
        
        [self.view endEditing:YES];
        btn.selected = YES;
        [_tabview setEditing:YES animated:YES];
        _deleteView.hidden = NO;
        _bottomView.hidden = YES;
        specialTag = 1;
        selectNum = 0;
        _selectedNumLabel.text = [NSString stringWithFormat:@"已选%ld件",(long)selectNum];
        [_tabview reloadData];
    }
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    //购物车视图
    _dataArray = [NSMutableArray array];
    //是否在编辑状态下
    specialTag = 0;
    //已选数量
    selectNum = 0;
    
    //导航栏
    [self creatNav];
    
    //购物车无数据视图
    [self initBlankViews];
    
    //购物车视图;
    [self creatView];

}

-(void)initBlankViews{
    
    _backView = [[UIView alloc]init];
    [self.view addSubview:_backView];
    _backView.hidden = NO;
    _backView.backgroundColor = TableViewBackColor;
    _backView.sd_layout
    .leftSpaceToView(self.view,0)
    .topSpaceToView(self.view,0)
    .widthIs(KScreenWidth)
    .heightRatioToView(self.view,1);
    
    _carView = [[UIImageView alloc]init];
    _carView.image = [UIImage imageNamed:@"购物车图标"];

    _carView.contentMode = UIViewContentModeCenter;
    [_backView addSubview:_carView];
    _carView.sd_layout
    .widthIs(140)
    .leftSpaceToView(_backView,(KScreenWidth-_carView.frame.size.width)/2)
    .topSpaceToView(_backView,20)
    .heightIs(140);
    
    _textLabel = [[UILabel alloc]init];
    _textLabel.text = @"你的清单空空如也";
    _textLabel.textColor = [UIColor grayColor];
    _textLabel.textAlignment = NSTextAlignmentCenter;
    [_backView addSubview:_textLabel];
    _textLabel.sd_layout
    .leftSpaceToView(_backView,0)
    .topSpaceToView(_carView,10)
    .rightSpaceToView(_backView,0)
    .heightIs(20);
    
    _buyBtn = [[UIButton alloc]init];
    _buyBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [_buyBtn setTitle:@"立即夺宝" forState:UIControlStateNormal];
    [_buyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_buyBtn setBackgroundImage:[UIImage imageNamed:@"按钮背景-黄"] forState:UIControlStateNormal];
//    _buyBtn.backgroundColor = [UIColor redColor];
    [_buyBtn addTarget:self
                action:@selector(buyAction:)
      forControlEvents:UIControlEventTouchUpInside];
    [_backView addSubview:_buyBtn];
    _buyBtn.sd_layout
    .centerXEqualToView(_carView)
    .topSpaceToView(_textLabel,10)
    .widthIs(85)
    .heightIs(28);
    
    CGFloat w = (KScreenWidth-8*4)/3;
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(w, w*1.3);
    layout.sectionInset = UIEdgeInsetsMake(5, 6, 5, 6);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    _loveView = [[LoveView alloc] initWithFrame:CGRectMake(0, KScreenHeight-w*1.3-kNavigationBarHeight-kTabBarHeight-49, KScreenWidth, w*1.3+10)];
    
    [_backView addSubview:_loveView];
}

-(void)creatView{

    _deleteView = [[UIView alloc]initWithFrame:CGRectMake(0, KScreenHeight - kNavigationBarHeight - kTabBarHeight - 64, KScreenWidth, 64.f)];
    _deleteView.backgroundColor = [UIColor whiteColor];
    _deleteView.hidden = YES;
    [self.view addSubview:_deleteView];
    
    //全选按钮
    _allSelectButton  = [[UIButton alloc] initWithFrame:CGRectMake(12.f, 24.f, 20.f, 20.f)];
    _allSelectButton.layer.cornerRadius = 8.f;
    _allSelectButton.layer.masksToBounds = YES;
    [_allSelectButton setBackgroundImage:[UIImage imageNamed:@"复选框-未选中"] forState:UIControlStateNormal];
    [_allSelectButton setBackgroundImage:[UIImage imageNamed:@"复选框-选中"] forState:UIControlStateSelected
     ];
    [_allSelectButton addTarget:self
                         action:@selector(allSelectAction:) forControlEvents:UIControlEventTouchUpInside];
    [_deleteView addSubview:_allSelectButton];
    
    //删除按钮
    _deleteButton = [[UIButton alloc] initWithFrame:CGRectMake(KScreenWidth - 96, 16.f, 84.f, 32.f)];
    _deleteButton.layer.borderWidth = 1;
    _deleteButton.layer.borderColor = [[UIColor redColor] CGColor];
    _deleteButton.layer.cornerRadius = 5.f;
    _deleteButton.layer.masksToBounds = YES;
    [_deleteButton setTitle:@"确认删除" forState:UIControlStateNormal];
    [_deleteButton setTitle:@"确认删除" forState:UIControlStateSelected];
    [_deleteButton setTitleColor:[UIColor redColor]
                        forState:UIControlStateNormal];
    [_deleteButton setTitleColor:[UIColor redColor]
                        forState:UIControlStateSelected];
    _deleteButton.titleLabel.font = [UIFont systemFontOfSize: 13];
    [_deleteButton addTarget:self
                      action:@selector(deleteAction:)
            forControlEvents:UIControlEventTouchUpInside];
    [_deleteView addSubview:_deleteButton];
    //全选label
    _allSelectLabel = [[UILabel alloc] initWithFrame:CGRectMake(_allSelectButton.right + 16.f, 8.f, KScreenWidth - 124, 20.f)];
    _allSelectLabel.text = @"全选";
    _allSelectLabel.textAlignment = NSTextAlignmentLeft;
    _allSelectLabel.font = [UIFont systemFontOfSize:13];
    _allSelectLabel.textColor = [UIColor darkGrayColor];
    [_deleteView addSubview:_allSelectLabel];
    //已选label
    _selectedNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(_allSelectButton.right + 16.f, _allSelectLabel.bottom + 8.f, KScreenWidth - 124, 20.f)];
    _selectedNumLabel.text = @"已选几件";
    _selectedNumLabel.font = [UIFont systemFontOfSize:12];
    _selectedNumLabel.textAlignment = NSTextAlignmentLeft;
    _selectedNumLabel.textColor = [UIColor darkGrayColor];
    [_deleteView addSubview:_selectedNumLabel];;

    
    _bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, KScreenHeight - kNavigationBarHeight - kTabBarHeight - 64, KScreenWidth, 64.f)];
    _bottomView.backgroundColor = [UIColor whiteColor];
    _bottomView.hidden = NO;
    [self.view addSubview:_bottomView];

    //商品总数
    _goodstotal = [[UILabel alloc]init];
    _goodstotal.text = @"共 3 件商品,";
    _goodstotal.font = [UIFont systemFontOfSize:15];
    _goodstotal.textColor = [UIColor grayColor];
    [_bottomView addSubview:_goodstotal];
    _goodstotal.sd_layout
    .leftSpaceToView(_bottomView,8)
    .topSpaceToView(_bottomView,8)
    .widthIs(100)
    .heightIs(20);
    
    //商品总价格
    _pricetotal = [[UILabel alloc]init];
    _pricetotal.text = @"总计:";
    _pricetotal.font = [UIFont systemFontOfSize:15];
    _pricetotal.textColor = [UIColor grayColor];
    [_bottomView addSubview:_pricetotal];
    _pricetotal.sd_layout
    .leftSpaceToView(_goodstotal,5)
    .topEqualToView(_goodstotal)
    .widthIs(40)
    .heightIs(20);
    
    //商品总钱数
    _pricesum = [[UILabel alloc]init];
    _pricesum.textColor = [UIColor redColor];
    _pricesum.text = @"21元";
    _pricesum.font = [UIFont systemFontOfSize:15];
    [_bottomView addSubview:_pricesum];
    
    _pricesum.sd_layout
    .leftSpaceToView(_pricetotal,3)
    .topEqualToView(_pricetotal)
    .widthIs(80)
    .heightIs(20);
    
    _warntext = [[UILabel alloc]init];
    _warntext.text = @"夺宝有风险,参与需谨慎";
    _warntext.font = [UIFont systemFontOfSize:15];
    _warntext.textColor = [UIColor grayColor];
    [_bottomView addSubview:_warntext];
    _warntext.sd_layout
    .leftEqualToView(_goodstotal)
    .topSpaceToView(_goodstotal,10)
    .widthIs(200)
    .heightIs(20);
    
    _settlebtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _settlebtn.layer.masksToBounds = YES;
    _settlebtn.layer.cornerRadius = 5;
    _settlebtn.backgroundColor = [UIColor redColor];
    [_settlebtn setTitle:@"结算" forState:UIControlStateNormal];
    [_settlebtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_settlebtn addTarget:self action:@selector(PayClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_bottomView addSubview:_settlebtn];
    _settlebtn.sd_layout
    .rightSpaceToView(_bottomView,10)
    .topSpaceToView(_bottomView,20)
    .widthIs(60)
    .heightIs(30);
    
    _tabview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight - kNavigationBarHeight - kTabBarHeight - 64.f) style:UITableViewStylePlain];
    _tabview.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tabview.showsVerticalScrollIndicator = NO;
    _tabview.backgroundColor = TableViewBackColor;
    _tabview.dataSource = self;
    _tabview.delegate = self;
    [_tabview setEditing:NO animated:YES];
    [self.view addSubview:_tabview];
    
}

#pragma mark---按钮事件
- (void)buyAction:(UIButton *)button{

    id next = [self nextResponder];
    while (next != nil) {
        
        if ([next isKindOfClass:[TabbarViewcontroller class]]) {
            
            //获得标签控制器
            TabbarViewcontroller *tb = (TabbarViewcontroller *)next;
            //修改索引
            tb.selectedIndex = 0;
            //原选中标签修改
            tb.selectedItem.isSelected = NO;
            //选中新标签
            TabbarItem *item = (TabbarItem *)[tb.view viewWithTag:1];
            item.isSelected = YES;
            //设置为上一个选中
            tb.selectedItem = item;
            
            return;
        }
        next = [next nextResponder];
    }

}

-(void)PayClicked:(UIButton *)btn{

    [self.view endEditing:YES];
    //取出存储的用户信息
    NSDictionary *userDic = [[NSUserDefaults standardUserDefaults] objectForKey:@"userDic"];
    if(userDic != nil){

        PayViewController *VC = [[PayViewController alloc]init];
        VC.isimidiately = @"1";
        VC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:VC animated:YES];
        
    }else{
        
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"温馨提示"
                                                                         message:@"您尚未登录，是否马上登录?"
                                                                  preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *ensureAction = [UIAlertAction actionWithTitle:@"好的"
                                                               style:UIAlertActionStyleDefault
                                                             handler:^(UIAlertAction * _Nonnull action) {
                                                                 
                                                                 LoginViewController *lVC = [[LoginViewController alloc] init];
                                                                 UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:lVC];
                                                                 [self presentViewController:nav animated:YES completion:nil];
                                                                 
                                                             }];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消"
                                                               style:UIAlertActionStyleCancel
                                                             handler:^(UIAlertAction * _Nonnull action) {
                                                                 
                                                                 [alertVC dismissViewControllerAnimated:YES
                                                                                             completion:^{
                                                                                                 
                                                                                             }];
                                                                 
                                                             }];
        [alertVC addAction:ensureAction];
        [alertVC addAction:cancelAction];
        [self presentViewController:alertVC
                           animated:YES
                         completion:nil];
        
    }

}

- (void)allSelectAction:(UIButton *)btn{

    if (btn.selected) {
        
        btn.selected = NO;
        for (int i = 0; i < _dataArray.count; i ++) {
            
            [_tabview deselectRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]
                                    animated:YES];
        }
        selectNum = 0;
        _selectedNumLabel.text = [NSString stringWithFormat:@"已选%ld件",(long)selectNum];
    
    }else{
    
        btn.selected = YES;
        for (int i = 0; i < _dataArray.count; i ++) {
            
            [_tabview selectRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0] animated:YES
                            scrollPosition:UITableViewScrollPositionNone];
            
        }
        selectNum = _dataArray.count;
        _selectedNumLabel.text = [NSString stringWithFormat:@"已选%ld件",(long)selectNum];
    }
    
}

- (void)deleteAction:(UIButton *)button{

    NSArray *selectArr = _tabview.indexPathsForSelectedRows;
    
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"温馨提示"
                                                                     message:@"确定删除？"
                                                              preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction   *cancelAction = [UIAlertAction actionWithTitle:@"取消"
                                                             style:UIAlertActionStyleCancel
                                                           handler:^(UIAlertAction * _Nonnull action) {
                                                               
                                                               [alertVC dismissViewControllerAnimated:YES
                                                                                           completion:nil];
                                                               return;
                                                               
                                                           }];
    UIAlertAction   *ensureAction = [UIAlertAction actionWithTitle:@"删除"
                                                             style:UIAlertActionStyleDestructive
                                                           handler:^(UIAlertAction * _Nonnull action) {
                                                               
                                                               for (NSInteger i = selectArr.count - 1 ; i >= 0; i --) {
                                                                   
                                                                   NSIndexPath *indexPath = [selectArr objectAtIndex:i];
                                                                   [CartTools removeGoodsWithIndexPath:indexPath.row];
                                                                   _dataArray = [NSMutableArray arrayWithArray:[CartTools getCartList]];
                                                                   [self getRootController].cartNum = _dataArray.count;
                                                                   //如果购物车为空
                                                                   if (_dataArray.count == 0) {
                                                                       
                                                                       _tabview.hidden = YES;
                                                                       _bottomView.hidden = YES;
                                                                       _backView.hidden = NO;
                                                                       _rightbtn.hidden = YES;
                                                                       _deleteView.hidden = YES;
                                                                       
                                                                   }else{
                                                                       //如果购物车不为空
                                                                       //_allSelectLabel
                                                                       //            _selectedNumLabel
                                                                       //列表不隐藏
                                                                       _tabview.hidden = NO;
                                                                       //结算视图不隐藏
                                                                       _bottomView.hidden = NO;
                                                                       //无列表视图隐藏
                                                                       _backView.hidden = YES;
                                                                       //编辑按钮回复
                                                                       _rightbtn.hidden = NO;
                                                                       _rightbtn.selected = NO;
                                                                       _deleteView.hidden = YES;
                                                                       [_tabview setEditing:NO animated:YES];
                                                                       _bottomView.hidden = NO;
                                                                       specialTag = 0;
                                                                       //计算总价
                                                                       _goodstotal.text = [NSString stringWithFormat:@"共 %ld 件商品",(unsigned long)_dataArray.count];
                                                                       NSInteger totalPrice = 0;
                                                                       for (int i = 0; i < _dataArray.count; i ++) {
                                                                           
                                                                           NSDictionary *dic = [_dataArray objectAtIndex:i];
                                                                           NSInteger singlePrice = [[dic objectForKey:@"singlePrice"] integerValue];
                                                                           NSInteger num = [[dic objectForKey:@"buyTimes"] integerValue];
                                                                           totalPrice = totalPrice + singlePrice * num;
                                                                       }
                                                                       _pricesum.text = [NSString stringWithFormat:@"%ld 元",(long)totalPrice];
                                                                       
                                                                   }
                                                                   
                                                               }
                                                               [_tabview reloadData];
                                                               [alertVC dismissViewControllerAnimated:YES
                                                                                           completion:nil];
                                                               return ;
                                                           }];
    [alertVC addAction:cancelAction];
    [alertVC addAction:ensureAction];
    [self presentViewController:alertVC
                       animated:YES
                     completion:^{
                         
                     }];
    
}

#pragma mark----UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return _dataArray.count;

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    CartTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSDictionary *dic = [_dataArray objectAtIndex:indexPath.row];
    if (!cell) {
        
        cell = [[CartTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
     }
    cell.functionDelegate = self;
    
    cell.indexPath = indexPath;
    
    cell.goodsTitle.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"name"]];
        
    cell.totalNumber.text = [NSString stringWithFormat:@"总需人数:%@",[dic objectForKey:@"totalShare"]];
        
    cell.surplusNumber.text = [NSString stringWithFormat:@"剩余人数:%@",[dic objectForKey:@"surplusShare"]];

//    cell.goodsType.image = [UIImage imageNamed:@"10元标记"];
    
    NSArray *picArr = [dic objectForKey:@"proPictureList"];
    if (picArr.count > 0) {
        NSDictionary *picDic = [picArr firstObject];
        [cell.goodsImg setImageWithURL:[NSURL URLWithString:[picDic objectForKey:[[picDic  allKeys] firstObject]]] placeholderImage:[UIImage imageNamed:@"未加载图片"]];
//        [cell.goodsImg setImageWithURL:[NSURL URLWithString:[picDic objectForKey:[picDic objectForKey:@"img170"]]] placeholderImage:[UIImage imageNamed:@"未加载图片"]];
    }else{
        cell.goodsImg.image = [UIImage imageNamed:@"未加载图片"];
    }

    
    cell.goodsNumLab.text = [NSString stringWithFormat:@"%ld",[[dic objectForKey:@"buyTimes"] integerValue]];
    cell.maxSelectableNum = [[dic objectForKey:@"surplusShare"] integerValue];
    
    cell.price.text = [NSString stringWithFormat:@"%@元/次",[dic objectForKey:@"singlePrice"]];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 112;
    
}
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return @"删除";

}

//监听右滑删除按钮点击事件
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"温馨提示"
                                                                     message:@"确定删除？"
                                                              preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction   *cancelAction = [UIAlertAction actionWithTitle:@"取消"
                                                             style:UIAlertActionStyleCancel
                                                           handler:^(UIAlertAction * _Nonnull action) {
                                                               
                                                               [alertVC dismissViewControllerAnimated:YES
                                                                                           completion:nil];
                                                               return;
                                                               
                                                           }];
    UIAlertAction   *ensureAction = [UIAlertAction actionWithTitle:@"删除"
                                                             style:UIAlertActionStyleDestructive
                                                           handler:^(UIAlertAction * _Nonnull action) {
                                                               
                                                               
                                                               [CartTools removeGoodsWithIndexPath:indexPath.row];
                                                               _dataArray = [[CartTools getCartList] mutableCopy];
                                                               [self getRootController].cartNum = _dataArray.count;
                                                               if (_dataArray.count == 0) {
                                                                   
                                                                   _tabview.hidden = YES;
                                                                   _bottomView.hidden = YES;
                                                                   _backView.hidden = NO;
                                                                   _rightbtn.hidden = YES;
                                                                   _deleteView.hidden = YES;
                                                                   
                                                               }else{
                                                                   
                                                                   _tabview.hidden = NO;
                                                                   _bottomView.hidden = NO;
                                                                   _backView.hidden = YES;
                                                                   _rightbtn.hidden = NO;
                                                                   _deleteView.hidden = YES;
                                                                   //计算总价
                                                                   _goodstotal.text = [NSString stringWithFormat:@"共 %ld 件商品",(unsigned long)_dataArray.count];
                                                                   NSInteger totalPrice = 0;
                                                                   for (int i = 0; i < _dataArray.count; i ++) {
                                                                       
                                                                       NSDictionary *dic = [_dataArray objectAtIndex:i];
                                                                       NSInteger singlePrice = [[dic objectForKey:@"singlePrice"] integerValue];
                                                                       NSInteger num = [[dic objectForKey:@"buyTimes"] integerValue];
                                                                       totalPrice = totalPrice + singlePrice * num;
                                                                   }
                                                                   _pricesum.text = [NSString stringWithFormat:@"%ld 元",(long)totalPrice];
                                                                   [_tabview reloadData];
                                                                   
                                                               }
                                                               [alertVC dismissViewControllerAnimated:YES
                                                                                           completion:nil];
                                                               return ;
                                                           }];
    [alertVC addAction:cancelAction];
    [alertVC addAction:ensureAction];
    [self presentViewController:alertVC
                       animated:YES
                     completion:^{
                         
                     }];

    
}

//
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{

    return YES;
}

// 设置Cell的编辑样式。
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (specialTag) {
        
        return UITableViewCellEditingStyleDelete|UITableViewCellEditingStyleInsert;
   
    }else{
    
        return UITableViewCellEditingStyleDelete;
    
    }

}

//单元格点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [tableView endEditing:YES];
    //是否在编辑模式下
    if (specialTag) {
        
        selectNum ++;
//        _selectedNumLabel.text = [NSString stringWithFormat:@"已选%ld件",(long)selectNum];
        _deleteView.hidden = NO;
        _bottomView.hidden = YES;
        specialTag = 1;
//        selectNum = 0;
        _selectedNumLabel.text = [NSString stringWithFormat:@"已选%ld件",(long)selectNum];
//        [_tabview reloadData];
        if (selectNum == _dataArray.count) {
            
            _allSelectButton.selected = YES;
        }
        
    }else{
        
        [tableView deselectRowAtIndexPath:indexPath animated:NO];
        
    }
    
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(3_0){

    //是否在编辑模式下
    if (specialTag) {
        
        selectNum --;
        _selectedNumLabel.text = [NSString stringWithFormat:@"已选%ld件",(long)selectNum];
        if (selectNum != _dataArray.count) {
            
            _allSelectButton.selected = NO;
        }
        
    }else{
        
    }
    
}

//自己添加的delegate
//增加事件
-(void)addCountAtIndexPath:(NSIndexPath *)indexPath{

    NSLogZS(@"增加了");
    [CartTools addCountWithIndexPath:indexPath.row];
    _dataArray = [NSMutableArray arrayWithArray:[CartTools getCartList]];
    [self getRootController].cartNum = _dataArray.count;
    if (_dataArray.count == 0) {
        
        _tabview.hidden = YES;
        _bottomView.hidden = YES;
        _backView.hidden = NO;
        _rightbtn.hidden = YES;
        _deleteView.hidden = YES;
        
    }else{
        
        _tabview.hidden = NO;
        _bottomView.hidden = NO;
        _backView.hidden = YES;
        _rightbtn.hidden = NO;
        _deleteView.hidden = YES;
        //计算总价
        _goodstotal.text = [NSString stringWithFormat:@"共 %ld 件商品",(unsigned long)_dataArray.count];
        NSInteger totalPrice = 0;
        for (int i = 0; i < _dataArray.count; i ++) {
            
            NSDictionary *dic = [_dataArray objectAtIndex:i];
            NSInteger singlePrice = [[dic objectForKey:@"singlePrice"] integerValue];
            NSInteger num = [[dic objectForKey:@"buyTimes"] integerValue];
            totalPrice = totalPrice + singlePrice * num;
        }
        _pricesum.text = [NSString stringWithFormat:@"%ld 元",(long)totalPrice];
        [_tabview reloadData];
        
    }
    _rightbtn.selected = NO;
    [_tabview setEditing:NO animated:YES];
    _deleteView.hidden = YES;
    _bottomView.hidden = NO;
    _allSelectButton.selected = NO;
    specialTag = 0;
    selectNum = 0;
    [_tabview reloadData];
}

//减少事件
-(void)reduceCountAtIndexPath:(NSIndexPath *)indexPath{

    NSLogZS(@"减少了");
    [CartTools decreaseCountWithIndexPath:indexPath.row];
    _dataArray = [NSMutableArray arrayWithArray:[CartTools getCartList]];
    [self getRootController].cartNum = _dataArray.count;
    if (_dataArray.count == 0) {
        
        _tabview.hidden = YES;
        _bottomView.hidden = YES;
        _backView.hidden = NO;
        _rightbtn.hidden = YES;
        _deleteView.hidden = YES;
        
    }else{
        
        _tabview.hidden = NO;
        _bottomView.hidden = NO;
        _backView.hidden = YES;
        _rightbtn.hidden = NO;
        _deleteView.hidden = YES;
        //计算总价
        _goodstotal.text = [NSString stringWithFormat:@"共 %ld 件商品",(unsigned long)_dataArray.count];
        NSInteger totalPrice = 0;
        for (int i = 0; i < _dataArray.count; i ++) {
            
            NSDictionary *dic = [_dataArray objectAtIndex:i];
            NSInteger singlePrice = [[dic objectForKey:@"singlePrice"] integerValue];
            NSInteger num = [[dic objectForKey:@"buyTimes"] integerValue];
            totalPrice = totalPrice + singlePrice * num;
        }
        _pricesum.text = [NSString stringWithFormat:@"%ld 元",(long)totalPrice];
        [_tabview reloadData];
        
    }
    
    _rightbtn.selected = NO;
    [_tabview setEditing:NO animated:YES];
    _deleteView.hidden = YES;
    _bottomView.hidden = NO;
    _allSelectButton.selected = NO;
    specialTag = 0;
    selectNum = 0;
    [_tabview reloadData];
    
}

-(void)allRestAtIndexPath:(NSIndexPath *)indexPath{
    
    [CartTools allRestWithIndexPath:indexPath.row];
    _dataArray = [NSMutableArray arrayWithArray:[CartTools getCartList]];
    [self getRootController].cartNum = _dataArray.count;
    if (_dataArray.count == 0) {
        
        _tabview.hidden = YES;
        _bottomView.hidden = YES;
        _backView.hidden = NO;
        _rightbtn.hidden = YES;
        _deleteView.hidden = YES;
        
    }else{
        
        _tabview.hidden = NO;
        _bottomView.hidden = NO;
        _backView.hidden = YES;
        _rightbtn.hidden = NO;
        _deleteView.hidden = YES;
        //计算总价
        _goodstotal.text = [NSString stringWithFormat:@"共 %ld 件商品",(unsigned long)_dataArray.count];
        NSInteger totalPrice = 0;
        for (int i = 0; i < _dataArray.count; i ++) {
            
            NSDictionary *dic = [_dataArray objectAtIndex:i];
            NSInteger singlePrice = [[dic objectForKey:@"singlePrice"] integerValue];
            NSInteger num = [[dic objectForKey:@"buyTimes"] integerValue];
            totalPrice = totalPrice + singlePrice * num;
        }
        _pricesum.text = [NSString stringWithFormat:@"%ld 元",(long)totalPrice];
        [_tabview reloadData];
        
    }
    _rightbtn.selected = NO;
    [_tabview setEditing:NO animated:YES];
    _deleteView.hidden = YES;
    _bottomView.hidden = NO;
    _allSelectButton.selected = NO;
    specialTag = 0;
    selectNum = 0;
    [_tabview reloadData];
}

//输入事件
- (void)inputAtIndexPath:(NSIndexPath *)indexPath{

    _dataArray = [NSMutableArray arrayWithArray:[CartTools getCartList]];
    [self getRootController].cartNum = _dataArray.count;
    if (_dataArray.count == 0) {
        
        _tabview.hidden = YES;
        _bottomView.hidden = YES;
        _backView.hidden = NO;
        _rightbtn.hidden = YES;
        _deleteView.hidden = YES;
        
    }else{
        
        _tabview.hidden = NO;
        _bottomView.hidden = NO;
        _backView.hidden = YES;
        _rightbtn.hidden = NO;
        _deleteView.hidden = YES;
        //计算总价
        _goodstotal.text = [NSString stringWithFormat:@"共 %ld 件商品",(unsigned long)_dataArray.count];
        NSInteger totalPrice = 0;
        for (int i = 0; i < _dataArray.count; i ++) {
            
            NSDictionary *dic = [_dataArray objectAtIndex:i];
            NSInteger singlePrice = [[dic objectForKey:@"singlePrice"] integerValue];
            NSInteger num = [[dic objectForKey:@"buyTimes"] integerValue];
            totalPrice = totalPrice + singlePrice * num;
        }
        _pricesum.text = [NSString stringWithFormat:@"%ld 元",(long)totalPrice];
        [_tabview reloadData];
        
    }


}


#pragma mark - 加载数据
- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHidden:) name:UIKeyboardWillHideNotification object:nil];
    
    _dataArray = [NSMutableArray arrayWithArray:[CartTools getCartList]];
    [self getRootController].cartNum = _dataArray.count;
    if (_dataArray.count == 0) {
    
        _tabview.hidden = YES;
        _bottomView.hidden = YES;
        _backView.hidden = NO;
        _rightbtn.hidden = YES;
        _deleteView.hidden = YES;
        [_tabview reloadData];
    }else{
        
        _tabview.hidden = NO;
        _bottomView.hidden = NO;
        _backView.hidden = YES;
        _rightbtn.hidden = NO;
        _deleteView.hidden = YES;
        //计算总价
        _goodstotal.text = [NSString stringWithFormat:@"共 %ld 件商品",(unsigned long)_dataArray.count];
        NSInteger totalPrice = 0;
        for (int i = 0; i < _dataArray.count; i ++) {
            
            NSDictionary *dic = [_dataArray objectAtIndex:i];
            NSInteger singlePrice = [[dic objectForKey:@"singlePrice"] integerValue];
            NSInteger num = [[dic objectForKey:@"buyTimes"] integerValue];
            totalPrice = totalPrice + singlePrice * num;
        }
        _pricesum.text = [NSString stringWithFormat:@"%ld 元",(long)totalPrice];
        [_tabview reloadData];
    
    }

    
    if (_loveView) {
        [_loveView requestLoveData];
    }
}

- (void)viewWillDisappear:(BOOL)animated{

    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];

}

- (void)viewDidDisappear:(BOOL)animated{

    [super viewDidDisappear:animated];

    _rightbtn.selected = NO;
    [_tabview setEditing:NO animated:YES];
    _deleteView.hidden = YES;
    _bottomView.hidden = NO;
    _allSelectButton.selected = NO;
    specialTag = 0;
    [_tabview reloadData];

    
    //取出存储的用户信息
    NSDictionary *userDic = [[NSUserDefaults standardUserDefaults] objectForKey:@"userDic"];
    if (userDic) {
        [self updateCartList];
    }else{
        return;
    }
    
}

- (void)keyboardWasShown:(NSNotification*)aNotification{

    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    _tabview.height = KScreenHeight - kNavigationBarHeight - kTabBarHeight - 64.f - kbSize.height;
    _bottomView.top = KScreenHeight - kNavigationBarHeight - kTabBarHeight - 64.f - kbSize.height;
    _deleteView.top = KScreenHeight - kNavigationBarHeight - kTabBarHeight - 64.f - kbSize.height;

}

- (void)keyboardWillBeHidden:(NSNotification*)aNotification{

    _tabview.height = KScreenHeight - kNavigationBarHeight - kTabBarHeight - 64.f;
    _bottomView.top = KScreenHeight - kNavigationBarHeight - kTabBarHeight - 64;
    _deleteView.top = KScreenHeight - kNavigationBarHeight - kTabBarHeight - 64;

}

- (void)updateCartList{

    NSArray *uploadArr = [NSArray arrayWithArray:[CartTools getCartList]];
    [self getRootController].cartNum = uploadArr.count;
    NSMutableArray *updateList = [NSMutableArray array];
    
    //取出存储的用户信息
    NSDictionary *userDic = [[NSUserDefaults standardUserDefaults] objectForKey:@"userDic"];
    NSNumber *userId = userDic[@"id"];
    if (!userId) {
        return;
    }
    
    for (int i = 0; i < uploadArr.count; i ++) {
        
        NSDictionary *dic = [uploadArr objectAtIndex:i];
        NSDictionary *updateDic = @{@"productId":[dic objectForKey:@"id"],
                                    @"qty":[dic objectForKey:@"buyTimes"],
                                    @"buyUserId":userId,
                                    @"buyNum":@"1"};
        [updateList addObject:updateDic];
    
    }
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:userId forKey:@"buyUserId"];
    [params setObject:updateList forKey:@"list"];
    
    NSString *url = [NSString stringWithFormat:@"%@%@",BASE_URL,CartListUpload_URL];
    
    [ZSTools post:url
           params:params
          success:^(id json) {
              
              NSLogZS(@"%@",[json objectForKey:@"msg"]);
              
          } failure:^(NSError *error) {
              
              NSLogZS(@"%@",error);
              
          }];
    
}
//
//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    
//    [super touchesBegan:touches withEvent:event];
//    NSArray *cartArr = [CartTools getCartList];
//    [self getRootController].cartNum = cartArr.count;
//    for (int i = 0; i < cartArr.count; i++) {
//        
//        CartTableViewCell *cell = [_tabview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
//        if ([cell.goodsNumLab isFirstResponder]) {
//            [cell.goodsNumLab resignFirstResponder];
//        }
//        
//    }
//    
//}

- (TabbarViewcontroller *)getRootController{
    
    UIApplication *app = [UIApplication sharedApplication];
    UIWindow *windows = app.keyWindow;
    return (TabbarViewcontroller *)windows.rootViewController;
    
}

@end

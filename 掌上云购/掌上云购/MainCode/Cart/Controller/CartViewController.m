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
    
    [_rightbtn setTitle:@"完成" forState:UIControlStateSelected];
    
    [_rightbtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    
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
        specialTag = 0;
        [_tabview reloadData];
        
    }else{
        
        btn.selected = YES;
        [_tabview setEditing:YES animated:YES];
        _deleteView.hidden = NO;
        _bottomView.hidden = YES;
        specialTag = 1;
        [_tabview reloadData];
    }
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.title = @"购物车";
    
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
    _carView.layer.masksToBounds=YES;
    _carView.layer.cornerRadius=188/2.0f; //设置为图片宽度的一半出来为圆形
    _carView.layer.borderWidth=1.0f;
    [_backView addSubview:_carView];
    _carView.sd_layout
    .widthIs(188)
    .leftSpaceToView(_backView,(KScreenWidth-_carView.frame.size.width)/2)
    .topSpaceToView(_backView,20)
    .heightIs(188);
    
    _textLabel = [[UILabel alloc]init];
    _textLabel.text = @"你的清单空空如也";
    _textLabel.textColor = [UIColor grayColor];
    [_backView addSubview:_textLabel];
    _textLabel.sd_layout
    .leftSpaceToView(_backView,(KScreenWidth-_carView.frame.size.width)/2+25)
    .topSpaceToView(_carView,20)
    .widthIs(140)
    .heightIs(20);
    
    _buyBtn = [[UIButton alloc]init];
    [_buyBtn setTitle:@"立即购买" forState:UIControlStateNormal];
    [_buyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _buyBtn.backgroundColor = [UIColor redColor];
    [_backView addSubview:_buyBtn];
    _buyBtn.sd_layout
    .leftSpaceToView(_backView,(KScreenWidth-_carView.frame.size.width)/2+40)
    .topSpaceToView(_textLabel,10)
    .widthIs(100)
    .heightIs(40);
    
    CGFloat w = (KScreenWidth-8*4)/3;
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(w, w*1.3);
    layout.sectionInset = UIEdgeInsetsMake(5, 6, 5, 6);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    _collectView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, KScreenHeight-w*1.3-kNavigationBarHeight-kTabBarHeight-10, KScreenWidth, w*1.3+10) collectionViewLayout:layout];
    
    _collectView.backgroundColor = [UIColor whiteColor];
    [_backView addSubview:_collectView];
    
    _collectView.delegate = self;
    _collectView.dataSource = self;
    
    _identify = @"collectionCell";
    [_collectView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:_identify];

    _likeLabel = [[UILabel alloc]initWithFrame:CGRectMake(5.f, _collectView.top - 24.f, KScreenWidth - 10.f, 24.f)];
    _likeLabel.text = @"猜你喜欢";
    [_backView addSubview:_likeLabel];
    
}

#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return 10;

}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:_identify forIndexPath:indexPath];
    cell.backgroundColor = [UIColor grayColor];
    UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"揭晓-图片.jpg"]];
    cell.backgroundView = imgView;
    
    return cell;

}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

-(void)creatView{

    _deleteView = [[UIView alloc]initWithFrame:CGRectMake(0, KScreenHeight - kNavigationBarHeight - kTabBarHeight - 64, KScreenWidth, 64.f)];
    _deleteView.backgroundColor = [UIColor whiteColor];
    _deleteView.hidden = YES;
    [self.view addSubview:_deleteView];
    
    //全选按钮
    _allSelectButton  = [[UIButton alloc] initWithFrame:CGRectMake(12.f, 24.f, 16.f, 16.f)];
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
    .widthIs(40)
    .heightIs(20);
    
    _warntext = [[UILabel alloc]init];
    _warntext.text = @"夺宝有危险,参与需谨慎";
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
    _tabview.backgroundColor = TableViewBackColor;
    _tabview.dataSource = self;
    _tabview.delegate = self;
    [_tabview setEditing:NO animated:YES];
    [self.view addSubview:_tabview];
    
}

#pragma mark---按钮事件
-(void)PayClicked:(UIButton *)btn{

    PayViewController *VC = [[PayViewController alloc]init];
    
    [self.navigationController pushViewController:VC animated:YES];

}

- (void)allSelectAction:(UIButton *)btn{

    if (btn.selected) {
        
        btn.selected = NO;
        for (int i = 0; i < _dataArray.count; i ++) {
            
            [_tabview deselectRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]
                                    animated:YES];
        }
        selectNum = 0;
        _selectedNumLabel.text = [NSString stringWithFormat:@"已选%ld件",selectNum];
    
    }else{
    
        btn.selected = YES;
        for (int i = 0; i < _dataArray.count; i ++) {
            
            [_tabview selectRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0] animated:YES
                            scrollPosition:UITableViewScrollPositionNone];
            
        }
        selectNum = _dataArray.count;
        _selectedNumLabel.text = [NSString stringWithFormat:@"已选%ld件",selectNum];
    }
    
}

- (void)deleteAction:(UIButton *)button{

    NSArray *selectArr = _tabview.indexPathsForSelectedRows;
    
    for (int i = 0 ; i < selectArr.count; i ++) {
        
        NSIndexPath *indexPath = [selectArr objectAtIndex:i];
        [CartTools removeGoodsWithIndexPath:indexPath.row];
        
        _dataArray = [NSMutableArray arrayWithArray:[CartTools getCartList]];
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
            [_tabview setEditing:NO animated:YES];
            _bottomView.hidden = NO;
            specialTag = 0;
            //计算总价
            _goodstotal.text = [NSString stringWithFormat:@"共 %ld 件商品",_dataArray.count];
            NSInteger totalPrice = 0;
            for (int i = 0; i < _dataArray.count; i ++) {
                
                NSDictionary *dic = [_dataArray objectAtIndex:i];
                NSInteger singlePrice = [[dic objectForKey:@"singlePrice"] integerValue];
                NSInteger num = [[dic objectForKey:@"buyTimes"] integerValue];
                totalPrice = totalPrice + singlePrice * num;
            }
            _pricesum.text = [NSString stringWithFormat:@"%ld 元",totalPrice];
            [_tabview reloadData];
            
        }
        
    }
    
}

#pragma mark----UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return _dataArray.count;

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    CartTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    NSDictionary *dic = [_dataArray objectAtIndex:indexPath.row];
    if (!cell) {
        
        cell = [[CartTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
     }
    cell.functionDelegate = self;
    
    cell.indexPath = indexPath;
    
    cell.goodsTitle.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"name"]];
        
    cell.totalNumber.text = [NSString stringWithFormat:@"总需人数:%@",[dic objectForKey:@"totalShare"]];
        
    cell.surplusNumber.text = [NSString stringWithFormat:@"当前人数:%@",[dic objectForKey:@"surplusShare"]];

    cell.goodsType.image = [UIImage imageNamed:@"商品种类"];
        
    cell.goodsImg.image = [UIImage imageNamed:@"品牌图片"];
       
    cell.goodsNumLab.text = [NSString stringWithFormat:@"%ld",[[dic objectForKey:@"buyTimes"] integerValue]];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 112;
    
}

//监听右滑删除按钮点击事件
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [CartTools removeGoodsWithIndexPath:indexPath.row];
    _dataArray = [[CartTools getCartList] mutableCopy];
    _dataArray = [NSMutableArray arrayWithArray:[CartTools getCartList]];
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
        _goodstotal.text = [NSString stringWithFormat:@"共 %ld 件商品",_dataArray.count];
        NSInteger totalPrice = 0;
        for (int i = 0; i < _dataArray.count; i ++) {
            
            NSDictionary *dic = [_dataArray objectAtIndex:i];
            NSInteger singlePrice = [[dic objectForKey:@"singlePrice"] integerValue];
            NSInteger num = [[dic objectForKey:@"buyTimes"] integerValue];
            totalPrice = totalPrice + singlePrice * num;
        }
        _pricesum.text = [NSString stringWithFormat:@"%ld 元",totalPrice];
        [_tabview reloadData];
        
    }
    
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

    //是否在编辑模式下
    if (specialTag) {
        
        selectNum ++;
        _selectedNumLabel.text = [NSString stringWithFormat:@"已选%ld件",selectNum];
        
    }else{
        
        
        
    }
    
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(3_0){

    //是否在编辑模式下
    if (specialTag) {
        
        selectNum --;
        _selectedNumLabel.text = [NSString stringWithFormat:@"已选%ld件",selectNum];
        
    }else{
        
        
        
    }
    
}

//自己添加的delegate
//增加事件
-(void)addCountAtIndexPath:(NSIndexPath *)indexPath{

    NSLogZS(@"增加了");
    [CartTools addCountWithIndexPath:indexPath.row];
    _dataArray = [NSMutableArray arrayWithArray:[CartTools getCartList]];
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
        _goodstotal.text = [NSString stringWithFormat:@"共 %ld 件商品",_dataArray.count];
        NSInteger totalPrice = 0;
        for (int i = 0; i < _dataArray.count; i ++) {
            
            NSDictionary *dic = [_dataArray objectAtIndex:i];
            NSInteger singlePrice = [[dic objectForKey:@"singlePrice"] integerValue];
            NSInteger num = [[dic objectForKey:@"buyTimes"] integerValue];
            totalPrice = totalPrice + singlePrice * num;
        }
        _pricesum.text = [NSString stringWithFormat:@"%ld 元",totalPrice];
        [_tabview reloadData];
        
    }
    
}

//减少事件
-(void)reduceCountAtIndexPath:(NSIndexPath *)indexPath{

    NSLogZS(@"减少了");
    [CartTools decreaseCountWithIndexPath:indexPath.row];
    _dataArray = [NSMutableArray arrayWithArray:[CartTools getCartList]];
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
        _goodstotal.text = [NSString stringWithFormat:@"共 %ld 件商品",_dataArray.count];
        NSInteger totalPrice = 0;
        for (int i = 0; i < _dataArray.count; i ++) {
            
            NSDictionary *dic = [_dataArray objectAtIndex:i];
            NSInteger singlePrice = [[dic objectForKey:@"singlePrice"] integerValue];
            NSInteger num = [[dic objectForKey:@"buyTimes"] integerValue];
            totalPrice = totalPrice + singlePrice * num;
        }
        _pricesum.text = [NSString stringWithFormat:@"%ld 元",totalPrice];
        [_tabview reloadData];
        
    }
    
}

#pragma mark - 加载数据
- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    
    _dataArray = [NSMutableArray arrayWithArray:[CartTools getCartList]];
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
        _goodstotal.text = [NSString stringWithFormat:@"共 %ld 件商品",_dataArray.count];
        NSInteger totalPrice = 0;
        for (int i = 0; i < _dataArray.count; i ++) {
            
            NSDictionary *dic = [_dataArray objectAtIndex:i];
            NSInteger singlePrice = [[dic objectForKey:@"singlePrice"] integerValue];
            NSInteger num = [[dic objectForKey:@"buyTimes"] integerValue];
            totalPrice = totalPrice + singlePrice * num;
        }
        _pricesum.text = [NSString stringWithFormat:@"%ld 元",totalPrice];
        [_tabview reloadData];
    
    }
#warning 登陆的时候必须合并
//    [self requestCartList];
    
}

- (void)requestCartList{

    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:@"1" forKey:@"buyUserId"];
    
    NSString *url = [NSString stringWithFormat:@"%@%@",BASE_URL,CartList_URL];
    
    [ZSTools post:url
           params:params
          success:^(id json) {
              
              NSArray *dataArr = [json objectForKey:@"data"];
              NSMutableArray *cloudArr = [NSMutableArray array];
              for (int i = 0 ; i < dataArr.count; i ++) {
                  
                  NSDictionary *dic = [dataArr objectAtIndex:i];
                  NSInteger numbers = 1;
                  if (![[dic objectForKey:@"buyNumbers"] isEqual:[NSNull null]]) {
                      numbers = [[dic objectForKey:@"buyNumbers"] integerValue];
                  }

                  NSDictionary *goods = @{@"id":[dic objectForKey:@"id"],
                                        @"name":[dic objectForKey:@"name"],
//                              @"proPictureList":[dic objectForKey:@"proPictureList"],
                                  @"totalShare":[dic objectForKey:@"totalShare"],
                                @"surplusShare":[dic objectForKey:@"surplusShare"],
                                    @"buyTimes":[NSNumber numberWithInteger:numbers]};
                  [cloudArr addObject:goods];
                      
                  }
              if (cloudArr.count > 0) {
                  bool issuccess = [CartTools addCartList:cloudArr];
                  
                  if (issuccess) {
                      
                      _dataArray = [NSMutableArray arrayWithArray:[CartTools getCartList]];
                      [_tabview reloadData];
                      
                  }
                  
              }else{
              
                  
              }
              
          } failure:^(NSError *error) {
              
          }];
    
}

- (void)viewWillDisappear:(BOOL)animated{

    [super viewWillDisappear:animated];
    
    [self updateCartList];
    
}

- (void)updateCartList{

    NSArray *uploadArr = [NSArray arrayWithArray:[CartTools getCartList]];
    NSMutableArray *updateList = [NSMutableArray array];
    for (int i = 0; i < uploadArr.count; i ++) {
        
        NSDictionary *dic = [uploadArr objectAtIndex:i];
        NSDictionary *updateDic = @{@"productId":[dic objectForKey:@"id"],
                                    @"qty":[dic objectForKey:@"buyTimes"],
                                    @"buyUserId":@"1",
                                    @"buyNum":@"10"};
        [updateList addObject:updateDic];
    }
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:@"1" forKey:@"buyUserId"];
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

@end

//
//  CartViewController.m
//  掌上云购
//
//  Created by coco船长 on 16/8/3.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import "CartViewController.h"
#import "UIView+SDAutoLayout.h"
#import "PayViewController.h"
@interface CartViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource>
{


    UITableView *_tabview;
    
    NSMutableArray *_dataArray;
    
    NSString *_identify;

    
    BOOL _isData;

}

@property(nonatomic,strong)UIView *backView;

@property(nonatomic,strong)UIImageView *carView;

@property(nonatomic,strong)UILabel *textLabel;

@property(nonatomic,strong)UIButton *buyBtn;

@property(nonatomic,strong)UILabel *likeLabel;

@property(nonatomic,strong)UIScrollView *scrollView;

@property(nonatomic,strong)UICollectionView *collectView;

//商品总数
@property(nonatomic,strong)UILabel *goodstotal;

//商品总价格
@property(nonatomic,strong)UILabel *pricetotal;

//商品总钱数
@property(nonatomic,strong)UILabel *pricesum;

//警示语
@property(nonatomic,strong)UILabel *warntext;

//结算按钮
@property(nonatomic,strong)UIButton *settlebtn;
@end

@implementation CartViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    _dataArray = [NSMutableArray array];
    
    _isData = YES;
    
    self.title = @"购物车";
    
    if (_isData==YES) {
        
        //创建列表
        [self creatTableView];
        
        //添加编辑按钮
        [self creatNav];
        
        //创建底部View;
        [self creatView];
        
    }else{
    
        [self creatUI];
        
        [self createCollectionView];
        
    }

}

-(void)creatUI{
    
    _backView = [[UIView alloc]init];
    [self.view addSubview:_backView];
    _backView.backgroundColor = TableViewBackColor;
    _backView.sd_layout
    .leftSpaceToView(self.view,0)
    .topSpaceToView(self.view,0)
    .widthIs(KScreenWidth)
    .heightRatioToView(self.view,0.6);
    
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
    
    _likeLabel = [[UILabel alloc]init];
    _likeLabel.text = @"猜你喜欢";
    [self.view addSubview:_likeLabel];
    _likeLabel.sd_layout
    .leftSpaceToView(self.view,5)
    .topSpaceToView(_backView,10)
    .widthIs(100)
    .heightIs(20);

}

//创建下方视图
- (void)createCollectionView {
    
    CGFloat w = (KScreenWidth-8*4)/3;
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(w, w*1.3);
    layout.sectionInset = UIEdgeInsetsMake(5, 6, 5, 6);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    _collectView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, KScreenHeight-w*1.3-kNavigationBarHeight-kTabBarHeight-10, KScreenWidth, w*1.3+10) collectionViewLayout:layout];
    
    _collectView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_collectView];
    
    _collectView.delegate = self;
    _collectView.dataSource = self;
    
    _identify = @"collectionCell";
    [_collectView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:_identify];
   
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

-(void)creatNav{

    //设置右视图
    UIButton *rightbtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    
    [rightbtn setTitle:@"编辑" forState:UIControlStateNormal];
    
    [rightbtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    
    [rightbtn addTarget:self action:@selector(Clicked:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *custom = [[UIBarButtonItem alloc]initWithCustomView:rightbtn];
    
    self.navigationItem.rightBarButtonItem = custom;
    

}

-(void)creatView{

    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, KScreenHeight-180, KScreenWidth, KScreenHeight)];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    
    //商品总数
    _goodstotal = [[UILabel alloc]init];
    _goodstotal.text = @"共 3 件商品,";
    _goodstotal.textColor = [UIColor grayColor];
    [view addSubview:_goodstotal];
    _goodstotal.sd_layout
    .leftSpaceToView(view,5)
    .topSpaceToView(view,5)
    .widthIs(100)
    .heightIs(20);
    
    //商品总价格
    _pricetotal = [[UILabel alloc]init];
    _pricetotal.text = @"总计:";
    _pricetotal.textColor = [UIColor grayColor];
    [view addSubview:_pricetotal];
    _pricetotal.sd_layout
    .leftSpaceToView(_goodstotal,5)
    .topEqualToView(_goodstotal)
    .widthIs(40)
    .heightIs(20);
    
    //商品总钱数
    _pricesum = [[UILabel alloc]init];
    _pricesum.textColor = [UIColor redColor];
    _pricesum.text = @"21元";
    [view addSubview:_pricesum];
    
    _pricesum.sd_layout
    .leftSpaceToView(_pricetotal,3)
    .topEqualToView(_pricetotal)
    .widthIs(40)
    .heightIs(20);
    
    
    _warntext = [[UILabel alloc]init];
    _warntext.text = @"夺宝有危险,参与需谨慎";
    _warntext.textColor = [UIColor grayColor];
    [view addSubview:_warntext];
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
    [view addSubview:_settlebtn];
    _settlebtn.sd_layout
    .rightSpaceToView(view,10)
    .topSpaceToView(view,20)
    .widthIs(60)
    .heightIs(30);
    
}

#pragma mark---结算按钮事件
-(void)PayClicked:(UIButton *)btn{

    PayViewController *VC = [[PayViewController alloc]init];
    
    [self.navigationController pushViewController:VC animated:YES];

}


#pragma mark----编辑事件
-(void)Clicked:(UIButton *)btn{

    NSLog(@"编辑");
    
}

-(void)creatTableView{

    _tabview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight-180) style:UITableViewStylePlain];
    _tabview.backgroundColor = TableViewBackColor;
    _tabview.dataSource = self;
    _tabview.delegate = self;
    [self.view addSubview:_tabview];
   
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
        
    cell.totalNumber.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"totalShare"]];
        
    cell.surplusNumber.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"surplusShare"]];

    cell.goodsType.image = [UIImage imageNamed:@"商品种类"];
        
    cell.goodsImg.image = [UIImage imageNamed:@"品牌图片"];
       
    cell.goodsNumLab.text = [NSString stringWithFormat:@"%ld",[[dic objectForKey:@"buyTimes"] integerValue]];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 112;
    
}

//增加事件
-(void)addCountAtIndexPath:(NSIndexPath *)indexPath{

    NSLogZS(@"增加了");
    [CartTools addCountWithIndexPath:indexPath.row];
    _dataArray = [NSMutableArray arrayWithArray:[CartTools getCartList]];
    [_tabview reloadData];
    
}

//减少事件
-(void)reduceCountAtIndexPath:(NSIndexPath *)indexPath{

    NSLogZS(@"减少了");
    [CartTools decreaseCountWithIndexPath:indexPath.row];
    _dataArray = [NSMutableArray arrayWithArray:[CartTools getCartList]];
    [_tabview reloadData];
    
}

#pragma mark - 加载数据
- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    
    _dataArray = [NSMutableArray arrayWithArray:[CartTools getCartList]];
    [_tabview reloadData];
    
    [self requestCartList];
    
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
    
//    NSDictionary *goods = @{@"id":[dic objectForKey:@"id"],
//                            @"name":[dic objectForKey:@"name"],
//                            //                              @"proPictureList":[dic objectForKey:@"proPictureList"],
//                            @"totalShare":[dic objectForKey:@"totalShare"],
//                            @"surplusShare":[dic objectForKey:@"surplusShare"],
//                            @"buyTimes":[NSNumber numberWithInteger:numbers]};
    
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

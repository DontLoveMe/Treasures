//
//  AboutMeController.m
//  掌上云购
//
//  Created by 刘毅 on 16/8/15.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import "AboutMeController.h"
#import "ChangeDataController.h"
#import "AddressViewController.h"
#import "RegisterViewController.h"

@interface AboutMeController ()

@end

@implementation AboutMeController {
    
    NSArray *_data;
    UITableView *_tableView;
//    NSString *_identify;
    
    UIImage *_iconImg;
    UIImageView *_iconImgView;
    
    NSDictionary *_userInfo;
    NSString *_filePath;
}

#pragma mark - 导航栏
- (void)initNavBar{
    
    self.navigationItem.backBarButtonItem = nil;
    UIButton *leftButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 12.f, 18.f)];
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
    
    self.title = @"个人资料";
    
    [self initNavBar];
    
//    [self getUserInfo];
    
    _data = @[@"头像管理",@"ID",@"昵称",@"手机号码管理",@"绑定邮箱",@"地址管理"];
    _iconImg = [UIImage imageNamed:@"无"];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight-64) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    //下拉时动画
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        
        [self getUserInfo];
        
    }];
    //下拉时图片
    NSMutableArray *gifWhenPullDown = [NSMutableArray array];
    for (NSInteger i = 1 ; i <= 30; i++) {
        
        if (i / 100 > 0) {
            [gifWhenPullDown addObject:[UIImage imageNamed:[NSString stringWithFormat:@"dropdown_zsyg_%ld",i]]];
        }else if (i / 10){
            [gifWhenPullDown addObject:[UIImage imageNamed:[NSString stringWithFormat:@"dropdown_zsyg_0%ld",i]]];
        }else{
            [gifWhenPullDown addObject:[UIImage imageNamed:[NSString stringWithFormat:@"dropdown_zsyg_00%ld",i]]];
        }
        
    }
    
    [header setImages:gifWhenPullDown
             duration:1 forState:MJRefreshStatePulling];
    
    //正在刷新时图片
    NSMutableArray *gifWhenRefresh = [NSMutableArray array];
    for (NSInteger i = 31 ; i <= 112; i++) {
        
        if (i / 100 > 0) {
            [gifWhenRefresh addObject:[UIImage imageNamed:[NSString stringWithFormat:@"dropdown_zsyg_%ld",i]]];
        }else if (i / 10){
            [gifWhenRefresh addObject:[UIImage imageNamed:[NSString stringWithFormat:@"dropdown_zsyg_0%ld",i]]];
        }else{
            [gifWhenRefresh addObject:[UIImage imageNamed:[NSString stringWithFormat:@"dropdown_zsyg_00%ld",i]]];
        }
        
    }
    
    [header setImages:gifWhenRefresh
             duration:2 forState:MJRefreshStateRefreshing];
    
    header.lastUpdatedTimeLabel.hidden = YES;
    header.stateLabel.hidden = NO;
    header.stateLabel.textColor = [UIColor colorFromHexRGB:ThemeColor];
    [header setTitle:@"下拉刷新。" forState:MJRefreshStateIdle];
    [header setTitle:@"松手即可刷新" forState:MJRefreshStatePulling];
    [header setTitle:@"正在刷新..." forState:MJRefreshStateRefreshing];
    _tableView.mj_header = header;

    

}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self getUserInfo];
}

- (void)getUserInfo {
    //取出存储的用户信息
    NSDictionary *userDic = [[NSUserDefaults standardUserDefaults] objectForKey:@"userDic"];
    NSNumber *userId = userDic[@"id"];
//    [self showHUD:@"加载中"];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:userId forKey:@"id"];
 
    NSString *url = [NSString stringWithFormat:@"%@%@",BASE_URL,UserInfo_URL];
    [ZSTools specialPost:url
           params:params
          success:^(id json) {
              
              BOOL isSuccess = [[json objectForKey:@"flag"] boolValue];
              [_tableView.mj_header endRefreshing];
//              [self hideSuccessHUD:[json objectForKey:@"msg"]];
              if (isSuccess) {
                  _userInfo = json[@"data"];
                  [_tableView reloadData];
                  
                  //更新存到NSUserDefaults信息
                  NSMutableDictionary *userDic = [[json objectForKey:@"data"] mutableCopy];
                  for (int i = 0; i < userDic.allKeys.count; i ++) {
                      
                      id ss=userDic[userDic.allKeys[i]];
                      if ([ss isEqual:[NSNull null]]) {
                          [userDic removeObjectForKey:userDic.allKeys[i]];
                          i = 0;
                      }
                      if ([[userDic objectForKey:userDic.allKeys[i]] isEqual:[NSNull null]]||[[userDic objectForKey:userDic.allKeys[i]] isKindOfClass:[NSNull class]]) {
                          
                          [userDic removeObjectForKey:userDic.allKeys[i]];
                          i = 0;
                      }
                      if ([userDic.allKeys[i] isEqualToString:@"userLoginDto"]) {
                          NSMutableDictionary *userLoginDic = [userDic[@"userLoginDto"] mutableCopy];
                          for (int j = 0; j< userLoginDic.allKeys.count; j ++) {
                              if ([[userLoginDic objectForKey:userLoginDic.allKeys[j]] isEqual:[NSNull null]]||[[userLoginDic objectForKey:userLoginDic.allKeys[j]] isKindOfClass:[NSNull class]]) {
                                  [userLoginDic removeObjectForKey:userLoginDic.allKeys[j]];
                                  j = 0;
                              }
                              userDic[@"userLoginDto"] = userLoginDic;
                          }
                          
                      }
                  }
                  
                  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                  
                  [defaults setObject:userDic forKey:@"userDic"];
                  
                  [defaults synchronize];
              }
              
              
          } failure:^(NSError *error) {
              
              [self hideFailHUD:@"加载失败"];
              NSLogZS(@"%@",error);
          }];
}
- (void)editUserInfo {
    NSDictionary *userDic = [[NSUserDefaults standardUserDefaults] objectForKey:@"userDic"];
    NSNumber *userId = userDic[@"id"];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:userId forKey:@"id"];
//    [params setObject:_userInfo[@"nickName"] forKey:@"nickName"];
    if (_filePath.length>0) {
        [params setObject:_filePath forKey:@"photo_url"];
    }else{
        return;
    }
    
    NSString *url = [NSString stringWithFormat:@"%@%@",BASE_URL,EditUserInfo_URL];
    [ZSTools specialPost:url
           params:params
          success:^(id json) {
              
              BOOL isSuccess = [[json objectForKey:@"flag"] boolValue];
              [self hideSuccessHUD:[json objectForKey:@"msg"]];
              if (isSuccess) {
                  
                  [self getUserInfo];
              }
              
              
          } failure:^(NSError *error) {
              
              [self hideFailHUD:@"加载失败"];
              NSLogZS(@"%@",error);
          }];
}
- (void)uploadPicwithFile{
    
    NSMutableDictionary *dataDic = [NSMutableDictionary dictionary];
    NSString *nameStr = [NSString stringWithFormat:@"image1.png"];
    NSData *imageData = UIImageJPEGRepresentation(_iconImg, 0.1);
    [dataDic setObject:imageData forKey:nameStr];
    
    
    NSString *url = [NSString stringWithFormat:@"%@%@", PIC_URL,UpdataFile_URL];
    
    
    [ZSTools post:url
           params:nil
             data:dataDic
          success:^(id result) {
              NSLogZS(@"返回数据:%@",result);
              BOOL resultFlag = [[result objectForKey:@"flag"] boolValue];
              if (resultFlag) {
                  _filePath = result[@"data"][@"filePath"];
                  [self editUserInfo];
              }else{
                  [self hideFailHUD:@"上传失败"];
              }
          } failure:^(NSError *error) {
              
              [self hideFailHUD:@"上传失败"];
              
          }];
    
}
#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _data.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:_identify forIndexPath:indexPath];
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.textLabel.text = _data[indexPath.row];
    
    if (_userInfo) {
        
    switch (indexPath.row) {
        case 0:
        {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            _iconImgView = nil;
            _iconImgView = [[UIImageView alloc] initWithFrame:CGRectMake(KScreenWidth-75, 3, 35, 35)];
            _iconImgView.backgroundColor = [UIColor redColor];
            _iconImgView.layer.cornerRadius = 35.f/2;
            _iconImgView.layer.masksToBounds = YES;
            
            _iconImgView.image = [UIImage imageNamed:@"我的-头像"];
            NSString *photoUrl = _userInfo[@"photoUrl"];
            if (![photoUrl isEqual:[NSNull null]]) {
                [_iconImgView setImageWithURL:[NSURL URLWithString:photoUrl] placeholderImage:[UIImage imageNamed:@"我的-头像"]];
                
            }
            
            [cell addSubview:_iconImgView];
            
        }
            break;
        case 1:
        {
            
            NSString *idStr = [NSString stringWithFormat:@"%@",_userInfo[@"id"]];
            cell.detailTextLabel.text = idStr;
        }
            break;
        case 2:
        {
            
            NSString *nickName = _userInfo[@"nickName"];
            if (![nickName isEqual:[NSNull null]]) {
                
                cell.detailTextLabel.text = nickName;
            }
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
            break;
        case 3:
        {
            NSString *mobile = _userInfo[@"mobile"];
            if ([mobile isKindOfClass:[NSNull class]]||mobile == nil) {
                cell.detailTextLabel.text = @"";
            }else {
                NSString *telepHone =[NSString stringWithFormat:@"%@",_userInfo[@"mobile"]];
                cell.detailTextLabel.text = telepHone;
            }
            
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
            break;
        case 4:
        {
            NSString *email = _userInfo[@"email"];
            if ([email isEqual:[NSNull null]]||email ==nil) {
                
                 cell.detailTextLabel.text = @"";
            }else {
                 cell.detailTextLabel.text = email;
            }
            
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
            break;
        case 5:
        {
            NSString *address = _userInfo[@"address"];
            if (![address isEqual:[NSNull null]]) {
                cell.detailTextLabel.text = _userInfo[@"address"];
            }
            
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
            
            break;
            
        default:
            break;
    }
    }
    
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (indexPath.row == 0) {
//        return 70;
//    }
    return 40;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.row) {
        case 0:
        {
            //提示选择拍照还是选择照片
            [self createAlertPhotoView];
        }
            break;
        case 1:
        {
            
        }
            break;
        case 2://修改昵称
        {
            ChangeDataController *cdVC = [[ChangeDataController alloc] init];
            cdVC.type = 1;
            [self.navigationController pushViewController:cdVC animated:YES];
            
        }
            break;
        case 3://修改手机号码
        {
            NSString *mobile = _userInfo[@"mobile"];
            if ([mobile isKindOfClass:[NSNull class]]||mobile == nil) {
                [self isBandPhone];
            }else {
                ChangeDataController *cdVC = [[ChangeDataController alloc] init];
                cdVC.type = 2;
                [self.navigationController pushViewController:cdVC animated:YES];
            }
            
        }
            break;
        case 4://绑定邮箱
        {
            ChangeDataController *cdVC = [[ChangeDataController alloc] init];
            cdVC.type = 3;
            [self.navigationController pushViewController:cdVC animated:YES];
        }
            break;
        case 5:
        {
            AddressViewController *aVC = [[AddressViewController alloc] init];
            [self.navigationController pushViewController:aVC animated:YES];
        }
            break;
            
        default:
            break;
    }

    
    
}

- (void)isBandPhone {
    
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示"
                     
                                                                             message:@"请绑定手机！" preferredStyle:UIAlertControllerStyleAlert];

    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"否"
                                                           style:UIAlertActionStyleDefault
                                                                                                                 handler:^(UIAlertAction * _Nonnull action)
                                   
    {
            [alertController dismissViewControllerAnimated:YES
                                                completion:nil];
                                                         }];
    
    [alertController addAction:cancelAction];
     UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"是"
                                                          style:UIAlertActionStyleDefault
                                                                                                                 handler:^(UIAlertAction * _Nonnull action)
          {
              [alertController dismissViewControllerAnimated:YES
                                                  completion:nil];
              
              RegisterViewController *rVC = [[RegisterViewController alloc] init];
              rVC.isRegistOrmodify = 3;
              rVC.title = @"绑定手机";
                                                                //                  rVC.userParams = params.copy;
            UINavigationController *rnVC = [[UINavigationController alloc] initWithRootViewController:rVC];
            [self presentViewController:rnVC animated:YES completion:nil];                   }];
            [alertController addAction:sureAction];
            [self presentViewController:alertController
                               animated:YES
                             completion:nil];
}

//提示选择拍照还是选择照片
- (void)createAlertPhotoView{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil
                                                                             message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *takePhotoAction = [UIAlertAction actionWithTitle:@"拍照"
                                                          style:UIAlertActionStyleDefault
                                                        handler:^(UIAlertAction * _Nonnull action)
    {
        BOOL isCamera = [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
        if (!isCamera) {
            NSLog(@"没有摄像头");
            return;
        }else {
            UIImagePickerController *imgPickerC = [[UIImagePickerController alloc] init];
            
            imgPickerC.sourceType = UIImagePickerControllerSourceTypeCamera;
            imgPickerC.delegate = self;
            [self presentViewController:imgPickerC animated:YES completion:nil];
        }
   
    }];
    
    [alertController addAction:takePhotoAction];
    
    UIAlertAction *photoAction = [UIAlertAction actionWithTitle:@"从相册中选取"
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction * _Nonnull action)
    {
        UIImagePickerController *imgPickerC = [[UIImagePickerController alloc] init];
        
        
        imgPickerC.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        imgPickerC.delegate = self;
        [self presentViewController:imgPickerC animated:YES completion:nil];
        
        
    }];
    
    [alertController addAction:photoAction];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消"
                                                           style:UIAlertActionStyleCancel
                                                         handler:^(UIAlertAction * _Nonnull action) {
                                                             [alertController dismissViewControllerAnimated:YES
                                                                                                 completion:nil];
                                                         }];
    [alertController addAction:cancelAction];
    
    [self presentViewController:alertController
                       animated:YES
                     completion:nil];
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    NSString *mediaType = info[UIImagePickerControllerMediaType];
    
    if ([mediaType isEqualToString:@"public.image"]) {
        //取得照片
        UIImage *originalImage = info[UIImagePickerControllerOriginalImage];
        _iconImg = originalImage;
        [self uploadPicwithFile];
//        [_tableView reloadData];
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}

@end

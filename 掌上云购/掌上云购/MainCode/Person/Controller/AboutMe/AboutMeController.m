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

@interface AboutMeController ()

@end

@implementation AboutMeController {
    
    NSArray *_data;
    UITableView *_tableView;
//    NSString *_identify;
    
    UIImage *_iconImg;
    UIImageView *_iconImgView;
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
    
    self.title = @"个人资料";
    
    [self initNavBar];
    
    
    _data = @[@"头像管理",@"ID",@"昵称",@"手机号码管理",@"绑定邮箱",@"地址管理"];
    _iconImg = [UIImage imageNamed:@"无"];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight-64) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    

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
    
    switch (indexPath.row) {
        case 0:
        {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            _iconImgView = nil;
            _iconImgView = [[UIImageView alloc] initWithFrame:CGRectMake(KScreenWidth-75, 10, 50, 50)];
            _iconImgView.backgroundColor = [UIColor redColor];
            _iconImgView.layer.cornerRadius = 25;
            _iconImgView.layer.masksToBounds = YES;
            _iconImgView.image = _iconImg;
            [cell addSubview:_iconImgView];
            
            
        }
            break;
        case 1:
            cell.detailTextLabel.text = @"342422545324";
            break;
        case 2:
            cell.detailTextLabel.text = @"某某";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            break;
        case 3:
            cell.detailTextLabel.text = @"1383838388";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            break;
        case 4:
            cell.detailTextLabel.text = @"123456789@qq.com";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            break;
        case 5:
            cell.detailTextLabel.text = @"长沙岳麓区";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            break;
            
        default:
            break;
    }
    
    
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 70;
    }
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
            ChangeDataController *cdVC = [[ChangeDataController alloc] init];
            cdVC.type = 2;
            [self.navigationController pushViewController:cdVC animated:YES];
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
        [_tableView reloadData];
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}

@end

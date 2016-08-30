//
//  SettingsController.m
//  掌上云购
//
//  Created by 刘毅 on 16/8/18.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import "SettingsController.h"
#import "AlertController.h"
#import "RegisterViewController.h"

@interface SettingsController ()

@end

@implementation SettingsController{
    
    NSArray *_data;
    UITableView *_tableView;
    //    NSString *_identify;
  
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
    
    self.title = @"设置";
    
    [self initNavBar];
    
    
    _data = @[@"密码修改",@"通知设置",@"常见问题",@"版本信息",@"清除缓存"];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 40*_data.count) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    
    UIButton *exitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    exitBtn.frame = CGRectMake(30, CGRectGetMaxY(_tableView.frame)+20, KScreenWidth-60, 40);
    [exitBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [exitBtn setTitle:@"退出账户登录" forState:UIControlStateNormal];
    [exitBtn setBackgroundImage:[UIImage imageNamed:@"按钮框"] forState:UIControlStateNormal];
    [exitBtn addTarget:self action:@selector(exitAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:exitBtn];
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
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            break;
        case 1:
            cell.detailTextLabel.text = @"推送未授权";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            break;
        case 2:
            cell.detailTextLabel.text = @"标识";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            break;
        case 3:
            cell.detailTextLabel.text = @"V1.1";
            break;
        case 4:
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%.2fM",[self folderSizeWithPath:[self getPath]]];
            break;
            
        default:
            break;
    }
    
    
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.row) {
        case 0://密码修改
        {
            RegisterViewController *rVC = [[RegisterViewController alloc] init];
            rVC.isRegistOrmodify = 2;
            rVC.title = @"密码修改";
            UINavigationController *rnVC = [[UINavigationController alloc] initWithRootViewController:rVC];
            [self presentViewController:rnVC animated:YES completion:nil];
        }
            break;
        case 1://通知设置
        {
        
        }
            break;
        case 2://常见问题
        {
            
        }
            break;
        case 3://版本信息
        {
            
            
        }
            break;
        case 4://清楚缓存
        {
            [self clearCacheAlertView];
           
        }
            break;
   
        default:
            break;
    }
    
    
    
}
- (void)a {
    [self hideSuccessHUD:@"上传数据成功"];
}
- (void)b {
    [self hideSuccessHUD:@"修改"];
}
#pragma mark - 缓存
- (void)clearCacheAlertView {
    
    AlertController *alert = [[AlertController alloc] initWithTitle:@"温馨提示!" message:[NSString stringWithFormat:@"缓存大小:%.2fM,是否清除？",[self folderSizeWithPath:[self getPath]]]];
    [alert addButtonTitleArray:@[@"否",@"是"]];
    __weak typeof(AlertController*) weakAlert = alert;
    [alert setClickButtonBlock:^(NSInteger tag) {
        if (tag == 0) {
            [weakAlert dismissViewControllerAnimated:YES completion:nil];
        }else {
            [self clearCacheWithPath:[self getPath]];
            [weakAlert dismissViewControllerAnimated:YES completion:nil];
            [_tableView reloadData];
        }
    }];
    [self presentViewController:alert
                       animated:YES
                     completion:nil];
}
//获取缓存文件的路径
-(NSString *)getPath {
    //沙盒目录下library文件夹下的cache文件夹就是缓存文件夹
    NSString * path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    
    return path;
}
//得到缓存大小
-(CGFloat)folderSizeWithPath:(NSString *)path {
    
    //初始化文件管理类
    NSFileManager * fileManager = [NSFileManager defaultManager];
    
    CGFloat folderSize = 0.0;
    if ([fileManager fileExistsAtPath:path])
        
    {
        //如果存在,计算文件的大小
        NSArray * fileArray = [fileManager subpathsAtPath:path];
        
        for (NSString * fileName in fileArray) {
            //获取每个文件的路径
            NSString * filePath = [path stringByAppendingPathComponent:fileName];
            
            //计算每个子文件的大小
            long fileSize = [fileManager attributesOfItemAtPath:filePath error:nil].fileSize;//字节数
            
            folderSize = folderSize + fileSize/1024.0/1024.0;
            
        }
        
        return folderSize;
    }
    
    return 0;
    
}
//清除缓存
-(void)clearCacheWithPath:(NSString *)path {
    
    NSFileManager * fileManager = [NSFileManager defaultManager];
    
    if ([fileManager fileExistsAtPath:path]) {
        
        NSArray * fileArray = [fileManager subpathsAtPath:path];
        
        for (NSString * fileName in fileArray) {
//            //可以过滤掉特殊格式的文件
//            if ([fileName hasSuffix:@".png"]) {
//                NSLog(@"不删除");
//            }else{
                //获取每个子文件的路径
                NSString * filePath = [path stringByAppendingPathComponent:fileName];
                //移除指定路径下的文件
                [fileManager removeItemAtPath:filePath error:nil];
//            }
         }
    }
}
#pragma mark - 退出
- (void)exitAction:(UIButton *)button {
    
    AlertController *alert = [[AlertController alloc] initWithTitle:@"温馨提示！" message:@"是否退出登录！"];
    [alert addButtonTitleArray:@[@"否",@"是"]];
    __weak typeof(AlertController *) weakAlert = alert;
    __weak typeof(self) weakSelf = self;
    [alert setClickButtonBlock:^(NSInteger tag) {
        if (tag == 0) {
            [weakAlert dismissViewControllerAnimated:YES completion:nil];
        }else {
            [weakAlert dismissViewControllerAnimated:YES completion:nil];
            
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"userDic"];
            
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }
        
    }];
    
    [self presentViewController:alert animated:YES completion:nil];
    return;
}
@end

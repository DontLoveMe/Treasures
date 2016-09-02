//
//  AddShareController.h
//  掌上云购
//
//  Created by 刘毅 on 16/9/1.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import "BaseViewController.h"
#import "RecordModel.h"
#import "TZImagePickerController.h"
#import "TZTestCell.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>
#import "LxGridViewFlowLayout.h"
#import "TZImageManager.h"
#import "TZVideoPlayerController.h"

@interface AddShareController : BaseViewController<UITableViewDelegate,UITableViewDataSource,TZImagePickerControllerDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UIAlertViewDelegate,UINavigationControllerDelegate,UITextFieldDelegate>

@property (nonatomic ,strong)RecordModel *lkModel;

@end

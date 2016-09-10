//
//  CountWayController.h
//  掌上云购
//
//  Created by coco船长 on 16/8/18.
//  Copyright © 2016年 nevermore. All rights reserved.
//

#import "BaseViewController.h"

@interface CountWayController : BaseViewController{

    //计算公式
    UILabel     *_formulaLabel;
    
    //a数值
    UIView      *_characterAView;
    //描述
    UILabel     *_characterAdescriptionLabel;
    UILabel     *_characterAdataLabel;
    
    //b数值
    UIView      *_characterBView;
    //描述
    UILabel     *_characterBdescriptionLabel;
    UILabel     *_characterBdataLabel;
    
    //计算结果
    UILabel     *_resultLabel;

}

@property (nonatomic,assign)NSInteger isAnnounced;
@property (nonatomic,copy)NSString *drawID;

@end

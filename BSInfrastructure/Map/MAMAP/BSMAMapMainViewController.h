//
//  BSMAMapMainViewController.h
//  KTAPP
//
//  Created by admin on 15/9/14.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "BSUICommonController.h"
#import "BSIFTTHeader.h"
#import "BaseMapViewController.h"


@interface BSMAMapMainViewController : BaseMapViewController{
    
    //地图控制域
    IBOutlet UIView *mapControllerView;
    
    IBOutlet BSBaseControllerView *baseControllerView;
    
    IBOutlet UILabel* _showMsgLabel;
    
    //控制器段显示
    IBOutlet UISegmentedControl *controllerSegmented;
    
    //卫星与标准显示图像
    IBOutlet UISegmentedControl *mapTypeSegmentedControl;
    
}

//导航栏中显示和隐藏地图控制区域
- (IBAction)hideControllerClick:(id)sender;


@end

//
//  BSUIFramework.h
//  KTAPP
//
//  Created by admin on 15/6/26.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#ifndef KTAPP_BSUIFramework_h


#define KTAPP_BSUIFramework_h

#import "Conf.h"
#import "ErrorMessage.h"
#import "NavigationProcess.h"

/**
 *公共的Controller
 */
#import "BSUICommonController.h"
#import "BSUITableViewCommonController.h"
#import "BSUITabBarCommonController.h"

/**
 *第三方UI相关组件
 */
#import "MBProgressHUD.h"
#import "MJRefresh.h"
#import "UIImageView+AFNetWorking.h"
#import "UIView+Frame.h"

/**
 *自动轮播实现
 */
#import "BSFCRollingADImageUIView.h"



/**
 *跳转功能模型
 */
#import "BSTableSection.h"
#import "BSTableContentObject.h"

#import "BSTableViewCellData.h"
#import "BSTableViewMultCellData.h"
#import "BSContentObjectNavigation.h"
/**
 *根据BSContentObject实现页面跳转
 */
#import "BSContentObjectNavigation.h"
#import "UIViewController+BSTableObject.h"

/**
 *表格视图根据配置模型自动跳转页面的实现
 */
#import "BSUITableViewInitRuntimeController.h"

#import "BSTableViewRefreshController.h"

/**
 *表格视图根据配置模型自动跳转页面的实现
 *表格的每行一列方式，包括图标和标题
 */
#import "BSUIImageTitleTableViewCell.h"

/**
 *表格视图根据配置模型自动跳转页面的实现
 *表格的每行一列方式，只有图标
 */
#import "BSUISingleImageTableViewCell.h"

/**
 *UI的公共小组件，例如弹出窗口
 */
#import "BSUIComponentView.h"



CG_INLINE CGRect BSRectMake(CGFloat x, CGFloat y, CGFloat width, CGFloat height)
{
    CGRect rect;
    rect.origin.x = x * autoSizeScaleX;
    rect.origin.y = y * autoSizeScaleY;
    rect.size.width = width * autoSizeScaleX;
    rect.size.height = height * autoSizeScaleY;
    return rect;
}


CG_INLINE CGSize BSSizeMake(CGFloat width, CGFloat height){
    CGSize size;
    size.height=size.width = width * autoSizeScaleX;
    size.height = height * autoSizeScaleY;
    return size;
    
}

CG_INLINE CGFloat BSMarginX(CGFloat x){
    return  x / autoSizeScaleX;
    
}


CG_INLINE CGFloat BSMarginY(CGFloat y){
    return  y / autoSizeScaleY;
    
}


#endif

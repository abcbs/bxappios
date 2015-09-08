//
//  BSUIFramework.h
//  KTAPP
//
//  Created by admin on 15/6/26.
//  Copyright (c) 2015年 KT. All rights reserved.
//

#ifndef KTAPP_BSUIFramework_h


#define KTAPP_BSUIFramework_h

#import "Conf.h"
#import "ErrorMessage.h"
#import "NavigationProcess.h"

#import "BSValidatePredicate.h"
/**
 *跳转功能模型
 */
#import "BSTableSection.h"
#import "BSTableContentObject.h"

#pragma mark --公共控制器
/**
 *带有返回按钮的控制器
 */
#import "BSUIContentViewController.h"
/**
 *不带返回按钮适合于首页导航，无需返回功能的控制器
 */
#import "BSUICommonController.h"
#import "BSUITabBarCommonController.h"
/**
 *TableViewController，不可编辑单元格
 */
#import "BSUITableViewCommonController.h"

/**
 *
 */
#import "BSUICollectionCollectionViewController.h"
/**
 *TableViewController，默认可编辑单元格
 */
#import "BSUITableViewCanEditedController.h"
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


#import "BSTableViewCellData.h"
#import "BSTableViewMultCellData.h"
#import "BSContentObjectNavigation.h"
#import "BSUIDefaultTableViewCell.h"

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
 *多列以事件方式实现
 */
#import "BSUIFiveColTableViewCell.h"
/**
 *表格视图根据配置模型自动跳转页面的实现
 *表格的每行一列方式，只有图标
 */
#import "BSUISingleImageTableViewCell.h"

/**
 *UI的公共小组件，例如弹出窗口
 */
#import "BSUIComponentView.h"

#import "BSWebViewViewController.h"

CG_INLINE CGRect BSRectMake(CGFloat x, CGFloat y, CGFloat width, CGFloat height)
{
    //autoStyleSize;
    CGRect rect;
    rect.origin.x = x * autoSizeScaleX;
    rect.origin.y = y * autoSizeScaleY;
    rect.size.width = width * autoSizeScaleX;
    rect.size.height = height * autoSizeScaleY;
    return rect;
}


CG_INLINE CGSize BSSizeMake(CGFloat width, CGFloat height){
    autoStyleSize;

    CGSize size;
    size.width = width * autoSizeScaleX;
    size.height = height * autoSizeScaleY;
    return size;
    
}

CG_INLINE CGFloat BSMarginX(CGFloat x){
    autoStyleSize;

    return  x * autoSizeScaleX;
    
}


CG_INLINE CGFloat BSMarginY(CGFloat y){
    autoStyleSize;

    return  y * autoSizeScaleY;
    
}


#endif

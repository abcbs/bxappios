//
//  CTManagerDelegate.h
//  KTAPP
//
//  Created by 刘建强 on 17/7/21.
//  Copyright © 2017年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CTTxtInfo.h"
@protocol CTManagerDelegate <NSObject>

/**
 *装载初始化数据
 */
-(CTTxtInfo*) loadTaxInfo:(CTTxtInfo *)taxInfo;


@end

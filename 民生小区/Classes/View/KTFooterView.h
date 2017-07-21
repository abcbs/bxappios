//
//  KTFooterView.h
//  民生小区
//
//  Created by L on 15/4/14.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KTFooterView;

@protocol KTFooterViewDelegate <NSObject>

@optional

-(void)footerViewDidClickLoadMore:(KTFooterView *)footerView;

@end
@interface KTFooterView : UIView

@property (nonatomic, weak) id<KTFooterViewDelegate>delegate;

+(instancetype)footerView;

@end

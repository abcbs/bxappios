//
//  KTCartFooterView.h
//  民生小区
//
//  Created by 罗芳芳 on 15/5/12.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>
@class KTCartFooterView;
@protocol KTFooterViewDelegate <NSObject>

-(void)ktFooterViewDelegate:(BOOL)select;

@end
@interface KTCartFooterView : UITableViewHeaderFooterView

@property (nonatomic, strong)id<KTFooterViewDelegate>delegate;



@end

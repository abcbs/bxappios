//
//  TopSubView.h
//  BusinessAreaPlat
//
//  Created by FF on 15-4-23.
//
//

#import <UIKit/UIKit.h>
//#import "HelpViewViewController.h"

@class TopSubView;
@protocol BtnClickDelegate<NSObject>
-(void) helpClick:(TopSubView *)sender andTag:(NSInteger)tag;
@end


@interface TopSubView : UIView
{
    UITextField *txtCustomer;
    id<BtnClickDelegate> delegate;
}
@property (nonatomic,strong) id<BtnClickDelegate> delegate;
@end



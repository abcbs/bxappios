//
//  TopView.h
//  BusinessAreaPlat
//
//  Created by FF on 15-4-23.
//
//

#import <UIKit/UIKit.h>
#import "ASScroll.h"
#import "TopSubView.h"

@class TopView;
@protocol BtnHelpClick<NSObject>
-(void) BtnHelpClick:(TopView *)sender andTag:(NSInteger)tag;
@end

@interface TopView : UIView<BtnClickDelegate>
{
    TopSubView *_subView;
    id<BtnHelpClick> helpDelegate;
    ASScroll *asScroll;
}
-(void) loadView:(NSArray*)imgArray;
-(void)helpClick:(id)sender andTag:(NSInteger)tag;
@property (nonatomic) TopSubView *subView;
@property (nonatomic,strong) id<BtnHelpClick> helpDelegate;
@property(nonatomic,strong) NSArray *adList;

@end

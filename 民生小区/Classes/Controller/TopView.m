//
//  TopView.m
//  BusinessAreaPlat
//
//  Created by FF on 15-4-23.
//
//

#import "TopView.h"

@implementation TopView

@synthesize  subView=_subView;
@synthesize helpDelegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        [self loadView];
    }
    return self;
}

//初始化ASScorll和子视图
-(void) loadView:(NSArray*)imgArray
{
    self.clipsToBounds=YES;
    if (asScroll==nil) {
        asScroll = [[ASScroll alloc]initWithFrame:CGRectMake(0.0, 0.0, self.frame.size.width, self.frame.size.height)];
        [asScroll initSubviews];
        [self addSubview:asScroll];
    }
    [asScroll setArrOfImages:imgArray];
  
    _subView = [[TopSubView alloc]initWithFrame:CGRectMake(0.0, self.frame.size.height/7*5-self.bounds.size.height/11*2, self.frame.size.width, self.frame.size.height/7*2)];
    _subView.delegate=self;    
    [self addSubview:_subView];
    
}
-(void)helpClick:(id)sender andTag:(NSInteger)tag
{
    [self.helpDelegate BtnHelpClick:self andTag:tag];
}

@end

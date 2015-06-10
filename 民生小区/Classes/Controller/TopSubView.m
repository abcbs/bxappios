//
//  TopSubView.m
//  BusinessAreaPlat
//
//  Created by FF on 15-4-23
//
//

#import "TopSubView.h"

@implementation TopSubView
@synthesize delegate;

- (id)initWithFrame:(CGRect)frame
{
self = [super initWithFrame:frame];
if (self) {
    [self setBackgroundColor:[UIColor colorWithRed:((float)((0x000000 & 0xFF0000) >> 16))/255.0 green:((float)((0x000000 & 0xFF00) >> 8))/255.0 blue:((float)(0x000000 & 0xFF))/255.0 alpha:0.2]];
    [self loadView];
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc]
                                             initWithTarget:self action:@selector(handleBackgroundTap:)];
    tapRecognizer.cancelsTouchesInView = NO;
    [self addGestureRecognizer:tapRecognizer];

}
return self;
}
-(void)loadView
{
    float cellHeight =30;
    txtCustomer=[[UITextField alloc]initWithFrame:CGRectMake(10.0, (self.bounds.size.height-cellHeight)/2, self.bounds.size.width-5*cellHeight, cellHeight)];
    [txtCustomer setBackground:[UIImage imageNamed:@"bg_search.png"]];
    txtCustomer.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
    UIView* imgParentView=[[UIView alloc] initWithFrame:CGRectMake(0, 0.0, cellHeight*2/3+3, cellHeight*2/3)];
    UIImageView *img =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_search.png"]];
    img.frame=CGRectMake(3, 0.0, cellHeight*2/3, cellHeight*2/3);
    [imgParentView addSubview:img];
  
    txtCustomer.leftView=imgParentView;
    txtCustomer.leftViewMode=UITextFieldViewModeAlways;
    txtCustomer.userInteractionEnabled=NO;
    txtCustomer.placeholder=@"商户、地址";
    txtCustomer.font=[UIFont fontWithName:@"Arial" size:18.0f];
    txtCustomer.keyboardType=UIKeyboardAppearanceDefault;
    txtCustomer.borderStyle=UITextBorderStyleRoundedRect;
    [txtCustomer addTarget:self action:@selector(keyboardClear:) forControlEvents:UIControlEventEditingDidEndOnExit];
    [self addSubview:txtCustomer];
    [txtCustomer addTarget:self action:@selector(textFieldDidEndEditing:) forControlEvents:UIControlEventEditingDidEnd];

    UIButton *btnHelp = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnHelp setFrame:CGRectMake(self.bounds.size.width-3*cellHeight-30, (self.bounds.size.height-cellHeight)/2, cellHeight, cellHeight)];
    [btnHelp setBackgroundImage:[UIImage imageNamed:@"icon_help.png"] forState:UIControlStateNormal];
    [btnHelp addTarget:self action:@selector(BtnHelpClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btnHelp];

    UIButton *btnAddress = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnAddress setFrame:CGRectMake(self.bounds.size.width-2*cellHeight-20, (self.bounds.size.height-cellHeight)/2, cellHeight, cellHeight)];
    [btnAddress setBackgroundImage:[UIImage imageNamed:@"icon_location.png"] forState:UIControlStateNormal];
    [btnAddress addTarget:self action:@selector(BtnCityClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btnAddress];

    UIButton *btnRight = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnRight setFrame:CGRectMake(self.bounds.size.width-cellHeight-10, (self.bounds.size.height-cellHeight)/2, cellHeight, cellHeight)];
    [btnRight setBackgroundImage:[UIImage imageNamed:@"icon_more.png"] forState:UIControlStateNormal];
    [btnRight addTarget:self action:@selector(rightClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btnRight];

}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    [textField resignFirstResponder];
}

-(void) keyboardClear:(id)sender
{
    [txtCustomer resignFirstResponder];
}

//点击help按钮时触发的事件
-(void)BtnHelpClick:(id)sender
{
    [self.delegate helpClick:sender andTag:1];
}
-(void)BtnCityClick:(id)sender
{
    [self.delegate helpClick:sender andTag:2];
}
-(void)rightClick:(id)sender
{
    [self.delegate helpClick:sender andTag:3];
}
- (void) handleBackgroundTap:(UITapGestureRecognizer*)sender
{
    [txtCustomer resignFirstResponder];
}




@end

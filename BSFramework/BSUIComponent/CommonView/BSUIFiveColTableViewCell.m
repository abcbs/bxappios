//
//  BSUIFiveColTableViewCell.m
//  KTAPP
//
//  Created by admin on 15/6/30.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "BSUIFiveColTableViewCell.h"
#import "BSUIFrameworkHeader.h"

@interface BSUIFiveColTableViewCell()

@property (nonatomic,strong) NSArray *bsContentArray;

@end

@implementation BSUIFiveColTableViewCell

@synthesize bsContentArray;

@synthesize imgButton;//Button
@synthesize titleLabel;

@synthesize scButton;
@synthesize scLebel;

@synthesize thirdButton;
@synthesize thirdLabel;

@synthesize fourButton;
@synthesize fourLabel;

@synthesize fiveButton;
@synthesize fiveLabel;

- (void)awakeFromNib {
    // Initialization code
}

/**
 *NIB或者故事板方式调用方法
 */
-(UITableViewCell *)viewCellWithBSContentObject:(NSArray *)bscArray{
    //[self clear];
    bsContentArray=bscArray;
    BSTableContentObject *bs=(BSTableContentObject *)bscArray[0];
    //self.imgButton.text =[bs colTitle];
    [self.imgButton setImage:[UIImage imageNamed:[bs colImageName]] forState:UIControlStateNormal];
    
    [self.imgButton addTarget:self action:@selector(imgButton:)
             forControlEvents:UIControlEventTouchUpInside];
    [self.imgButton setTag:0];
    [self.titleLabel setText:bs.colTitle];
  
    bs=(BSTableContentObject *)bscArray[1];
    [self.scButton setImage:[UIImage imageNamed:[bs colImageName]] forState:UIControlStateNormal];
    
    [self.scButton addTarget:self action:@selector(imgButton:)
             forControlEvents:UIControlEventTouchUpInside];
    [self.scButton setTag:1];
    [self.scLebel setText:bs.colTitle];
    //CGRect rect=self.frame;
    //[self clear];
    
    return self;
}

-(void)clear{
    /*
    [self.imgButton removeFromSuperview];
    [self.titleLabel removeFromSuperview];
    
    [self.scButton removeFromSuperview];
    [self.scLebel removeFromSuperview];
    
    [self.thirdButton removeFromSuperview];
    [self.thirdLabel removeFromSuperview];
    
    [self.fourButton removeFromSuperview];
    [self.fourLabel removeFromSuperview];
    
    [self.fiveButton removeFromSuperview];
    [self.fiveLabel removeFromSuperview];
    */
    //NSArray *array=[NSArray arrayWithObjects:self.scButton,self.scLebel, nil];
    //[self removeConstraints:array];
}
/**
 *手工编码的调用方法
 */
-(UITableViewCell *)viewCellWithHandBSContentObject:(NSArray *)bscArray{
    
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}



- (void )imgButton:(UIButton *)bsButton{
     NSLog(@"点击动作\t%ld",(long)bsButton.tag);
     BSTableContentObject *bs= (BSTableContentObject *) [ bsContentArray objectAtIndex:bsButton.tag];
    if (bs.vcClass ||bs.colClass) {
         [BSContentObjectNavigation navigatingControllWithStorybord:bs.callerViewController       bsContentObject:bs];
    }
   
}
@end

//
//  BSUITableViewCanEditedController.m
//  KTAPP
//
//  Created by admin on 15/7/18.
//  Copyright (c) 2015年 KT. All rights reserved.
//

#import "BSUITableViewCanEditedController.h"
#import "UserManager.h"

@interface BSUITableViewCanEditedController ()

@end

@implementation BSUITableViewCanEditedController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.navigationController) {
        //iOS有默认导航栏，使用固有的导航栏
        [BSUIComponentView initNavigationHeaderWithDefault:self
                                         navigationProcess:self
                                                     title:self.title];

        [BSUIComponentView initNarHeaderWithDefault:self
                                              title:self.title
                            bDisplaySearchButtonNav:self.bDisplaySearchButtonNav
                            bDisplayReturnButtonNav:self.bDisplayReturnButtonNav
         
         ];
        [BSUIComponentView navigationHeader:self.navigationController];
        
    }else{
        
        //没有导航栏，使用Button完成
        [BSUIComponentView initNarHeaderWithDefault:self  title: self.title];
        
    }
    
    [BSUIComponentView changeTabBarWithNotification:self addedInfo:self.inform];
    [self modifiedStyle];
    if (self.tableView==nil) {
        NSLog(@" BSUITableViewCommonController tableView is null");
    }else{
        self.tableView.backgroundColor=[UIColor groupTableViewBackgroundColor];
        self.tableView.frame=BSRectMake(NAVIGATIONBAR_X, NAVIGATIONBAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-NAVIGATION_ADD_STATUS_HEIGHT);
        
        self.tableView.dataSource =self;
        self.tableView.delegate = self;
        self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    }
    
    //设置TextField键盘
    [self delelageForTextField];
    //设置界面元素样式
    [self initSubViews];
    
    [self modifiedStyle];
    
    [self registerForKeyboardNotifications];
}

- (void)viewDidAppear:(BOOL)animated{
    
    BSLog(@"viewDidAppear 对象的视图已经加入到窗口时调用,%@",self.description);
    [BSUIComponentView changeTabBarWithNotification:self addedInfo:self.inform];
    [BSUIComponentView initNavigationWithPermission:self];
    //设置TextField键盘
    [self delelageForTextField];
    //设置界面元素样式
    [self initSubViews];
    
    [self modifiedStyle];
}

-(void)viewWillAppear:(BOOL)animated {
    [self registerForKeyboardNotifications];
    [super viewWillAppear:animated];
    
    
}

-(void) viewDidDisappear:(BOOL)animated{
    BSLog(@"BSUICommonController viewDidDisappear,%@",self.description);
    [BSUIComponentView changeTabBarWithNotification:self addedInfo:nil];
    
    [super viewDidDisappear:animated];
}

- (void)viewWillDisappear:(BOOL)animated{
    BSLog(@"BSUICommonController viewWillDisappear,%@",self.description);
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super viewWillDisappear:animated];
    
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}



#pragma mark --表格样式
/**
 *每个section头部标题高度
 */
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return BSMarginY(30);
}
/**
 *选中之前执行,判断选中的行
 */
-(NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    return indexPath;
}

#pragma mark --表格处理获取TableViewCell默认
/**
 *私有方法获取Cell的标示
 */
-(UITableViewCell *)obtainCellWith:(NSString *)identifer{
    UITableViewCell *cell=nil;
    cell=[self.tableView dequeueReusableCellWithIdentifier:identifer];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifer];
    }
    return cell;
}
#pragma mark --默认处理方法
-(void)modifiedStyle{
    BSLog(@"根据权限修改元素显示，公共权限控制导航栏，右侧按钮，子类需实现");
}
#pragma mark --默认返回方法，仅仅在人工提供的状态栏中使用
- (void)backClick{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark --默认统一处理方法，使用表格查询方式
- (void)doneClick{
    BSLog(@"子类应当继承此方法实现完成功能");
}

#pragma mark --轮播事件响应 有轮播图，需要点击轮播图处理信息
- (void)touchAction:(UIGestureRecognizer *)gester{
    BSLog(@"子类应当继承此方法实现完成轮播功能功能");
}

#pragma mark --控制是否可以根据故事板跳转
-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    if(self.bsContentObject.noNeedLoginCheck){
        return YES;
    }
    BOOL isLogin=[UserManager checkSession];
    if (isLogin==NO) {
        [self navigating:self storybord:@"LOUserManager" identity:@"LOLoginAppViewController" canUseStoryboard:YES];
        
    }
    return isLogin;
}

#pragma mark --登陆工具方法
-(BOOL)checkAndLogin{
    if(self.bsContentObject.noNeedLoginCheck){
        return YES;
    }
    BOOL isLogin=[UserManager checkSession];
    if (isLogin==NO) {
        [self navigating:self storybord:@"LOUserManager" identity:@"LOLoginAppViewController" canUseStoryboard:YES];
        
    }
    return isLogin;
}

#pragma mark --编码或者不在一个故事板中得跳转方法
-(void)navigating:(UIViewController *)callerController storybord:(NSString *)storybordName identity:(NSString *)identity canUseStoryboard:(BOOL)useStoryboard{
    BSTableContentObject * bsContentObject=[BSTableContentObject initWithController:callerController storybord:storybordName identity:identity canUseStoryboard:useStoryboard];
    [self navigating:bsContentObject];
}


#pragma mark --编码或者不在一个故事板中得跳转方法
-(void)navigating:(UIViewController *)callerController storybord:(NSString *)storybordName identity:(NSString *)identity canUseStoryboard:(BOOL)useStoryboard noLoginCheck:(BOOL) check{
    BSTableContentObject * bsContentObject=[BSTableContentObject initWithController:callerController storybord:storybordName identity:identity canUseStoryboard:useStoryboard];
    bsContentObject.noNeedLoginCheck=check;
    [self navigating:bsContentObject];
}

#pragma mark --功能装配控制器的跳转方法
-(void)navigating:(BSTableContentObject*)bsContentObject{
    [BSContentObjectNavigation navigatingControllWithStorybord:self       bsContentObject:bsContentObject];
}

#pragma mark -
#pragma mark 解决虚拟键盘挡住UITextField的方法
- (void)keyboardWillShow:(NSNotification *)noti
{
    //键盘输入的界面调整
    //键盘的高度
    //键盘输入的界面调整
    //键盘的高度
    float height = 216.0;
    CGRect frame = self.view.frame;
    frame.size = CGSizeMake(frame.size.width, frame.size.height - height);
    [UIView beginAnimations:@"Curl" context:nil];//动画开始
    [UIView setAnimationDuration:0.30];
    [UIView setAnimationDelegate:self];
    [self.view setFrame:frame];
    [UIView commitAnimations];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    // When the user presses return, take focus away from the text field so that the keyboard is dismissed.
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    CGRect rect = CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height);
    //CGRect rect = CGRectMake(0.0f, 20.0f, self.view.frame.size.width, self.view.frame.size.height);
    self.view.frame = rect;
    [UIView commitAnimations];
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    CGRect frame = textField.frame;
    int offset = frame.origin.y + 32 - (self.view.frame.size.height - 216.0);//键盘高度216
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyBoard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    float width = self.view.frame.size.width;
    float height = self.view.frame.size.height;
    if(offset > 0)
    {
        CGRect rect = CGRectMake(0.0f, -offset,width,height);
        self.view.frame = rect;
    }
    [UIView commitAnimations];
}

#pragma mark -键盘事件
-(void)keyboardDone:(id)sender{
    BSLog(@"键盘事件-确定查询");
}

//设置代理
-(void)delelageForTextField{
    BSLog(@"设置Text");
    
    
}

- (void)initSubViews{
    BSLog(@"子视图修改");
}

- (void)textViewDidChange:(UITextView *)textView
{
    [textView resignFirstResponder];
}

#pragma mark -

#pragma mark -键盘添加Button
- (void) registerForKeyboardNotifications{
    
    //当键盘出来的时候通过通知来获取键盘的信息
    //注册为键盘的监听着
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(keyNotification:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
}

-(UIToolbar *)keyboardToolBar{
    if (_keyboardToolBar==nil) {
        //TextView的键盘定制回收按钮
        _keyboardToolBar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 30)];
        
        UIBarButtonItem * item1 = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(keyboardDone:)];
        UIBarButtonItem * item2 = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        UIBarButtonItem * item3 = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        _keyboardToolBar.items = @[item2,item3,item1];
    }
    return _keyboardToolBar;
}

-(void) keyNotification : (NSNotification *) notification
{
    NSLog(@"%@", notification.userInfo);
    
    //self.keyBoardDic = notification.userInfo;
    //获取键盘移动后的坐标点的坐标点
    //CGRect rect = [self.keyBoardDic[@"UIKeyboardFrameEndUserInfoKey"] CGRectValue];
    
    //把键盘的坐标系改成当前我们window的坐标系
    //CGRect r1 = [self.view convertRect:rect fromView:self.view.window];
    /*
     [UIView animateWithDuration:[self.keyBoardDic[UIKeyboardAnimationDurationUserInfoKey] floatValue] animations:^{
     CGRect frame = self.toolView.frame;
     
     frame.origin.y = r1.origin.y - frame.size.height;
     
     //根据键盘的高度来改变toolView的高度
     self.toolView.frame = frame;
     }];
     */
}

@end

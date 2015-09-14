//
//  BSTableViewRefresh.m
//  KTAPP
//
//  Created by admin on 15/6/13.
//  Copyright (c) 2015年 KingTeller. All rights reserved.
//

#import "BSTableViewRefreshController.h"

#import "BSUIFrameworkHeader.h"
#import "BSCMFrameworkHeader.h"
#import "UserManager.h"

@interface BSTableViewRefreshController()

@property (nonatomic, retain) NSTimer *timer;

@end


@implementation BSTableViewRefreshController

@synthesize HUD;
@synthesize dataTable;
@synthesize errorInfo;

- (void)viewDidLoad {
    
    if (self.navigationController) {
        //iOS有默认导航栏，使用固有的导航栏
        [BSUIComponentView initNarHeaderWithDefault:self
                                              title:self.title
                            bDisplaySearchButtonNav:self.bDisplaySearchButtonNav
                            bDisplayReturnButtonNav:self.bDisplayReturnButtonNav
         
         ];
        
    }else{
        //没有导航栏，使用Button完成
        [BSUIComponentView initNarHeaderWithDefault:self title: self.title];
        
    }
    [BSUIComponentView navigationHeader:self.navigationController];
   [BSUIComponentView changeTabBarWithNotification:self addedInfo:self.inform];
    [self modifiedStyle];
    
    if(!HUD){
        HUD = [[MBProgressHUD alloc] initWithView:self.view];
 
        //如果设置此属性则当前的view置于后台
        //HUD.dimBackground = YES;
        HUD.mode = MBProgressHUDModeDeterminate;
        //设置对话框文字
        HUD.labelText = @"请稍等";
        HUD.delegate = self;
        [self.view addSubview:HUD];
    }
    [self setupRefresh];
    [self tableFooter];
    
    //设置TextField键盘
    [self registerForKeyboardNotifications];
    [self delelageForTextField];
    //设置界面元素样式
    //[self initSubViews];
    
    [self modifiedStyle];
    
    [self registerForKeyboardNotifications];
    
    [self configUIViewAndHighOffsetWithKeyBoard];
    [self configSuggestTextFiled];

}

-(void)viewWillAppear:(BOOL)animated {
    [self registerForKeyboardNotifications];
    [super viewWillAppear:animated];
    
    
}

- (void)viewDidAppear:(BOOL)animated{
    NSLog(@"对象的视图已经加入到窗口时调用");
    [BSUIComponentView changeTabBarWithNotification:self addedInfo:self.inform];
    _timer= [NSTimer scheduledTimerWithTimeInterval:0.1
                                             target:self selector:@selector(progressTracking) userInfo:self repeats:YES];
    
    if(!HUD){
        HUD = [[MBProgressHUD alloc] initWithView:self.view];
        
        //如果设置此属性则当前的view置于后台
        //HUD.dimBackground = YES;
        HUD.mode = MBProgressHUDModeDeterminate;
        //设置对话框文字
        HUD.labelText = @"请稍等";
        HUD.delegate = self;
        [self.view addSubview:HUD];
    }

    //设置TextField键盘
    [self delelageForTextField];
    //设置界面元素样式
    //[self initSubViews];
    
    [self modifiedStyle];
    
}
-(void) viewDidDisappear:(BOOL)animated{
    BSLog(@"BSUICommonController viewDidDisappear,%@",self.description);
    [BSUIComponentView changeTabBarWithNotification:self addedInfo:nil];
    _timer=nil;
   
    [super viewDidDisappear:animated];
}

- (void)viewWillDisappear:(BOOL)animated{
    BSLog(@"BSUICommonController viewWillDisappear,%@",self.description);
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super viewWillDisappear:animated];
    
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    NSLog(@"TableView dealloc");
    self.tableView=nil;
    self.dataTable=nil;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return WATER_LIST_ROW_HIGH;
}

//1.懒加载
-(NSMutableArray *)dataTable
{
    if (!dataTable)
        dataTable = [NSMutableArray array];
    
    return dataTable;
}




- (void)progressTracking
{
    [HUD showWhileExecuting:@selector(process) onTarget:self withObject:nil animated:YES];
    usleep(500);
}

-(void)process{
     @try {
         while([Conf checkNetWork]==networkRight||[Conf checkNetWork]==networkError){
             if (HUD!=nil ) {
                [HUD hide:YES];
                 //HUD=nil;
             }
             if (_timer!=nil &&_timer.isValid) {
                [_timer invalidate];
                //_timer=nil;
            }
         }
     }
    @catch (NSException *exception) {
        BSLog(@"刷新列表时出现异常%@",exception.description);
    }
    
}
- (void) viewDidUnload{
    NSLog( @"TableView dealloc%@",self.description);
    [self.tableView.header removeFromSuperview ];
    [self.tableView.footer removeFromSuperview];
    [HUD removeFromSuperview];
    [self.dataTable removeAllObjects];
    [super viewDidUnload];
}

/**
 *  集成刷新控件
 */
- (void)setupRefresh
{
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRereshing)];
    // 设置普通状态的动画图片
    // 隐藏时间
    header.lastUpdatedTimeLabel.hidden = YES;
    //设置字体
    header.stateLabel.font = [UIFont systemFontOfSize:15];
    header.lastUpdatedTimeLabel.font = [UIFont systemFontOfSize:14];

    self.tableView.header = header;

    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadMoreData方法）
    MJRefreshAutoGifFooter *footer = [MJRefreshAutoGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRereshing)];
    
    // 隐藏刷新状态的文字
    footer.refreshingTitleHidden = YES;
    // 如果没有上面的方法，就用footer.stateLabel.hidden = YES;
    // 设置尾部
    self.tableView.footer = footer;
   
    
    [self.tableView.header beginRefreshing];
    
}

-(void)tableFooter{
    errorInfo.text=@"";
    errorInfo.frame=BSRectMake(NAVIGATIONBAR_X, NAVIGATIONBAR_Y,
                               NAVIGATIONBAR_WIDTH, NAVIGATIONBAR_HEIGHT);
    [errorInfo setFont:[UIFont fontWithName:@"Helvetica-BoldOblique" size:10]];
    [errorInfo setTextColor:[UIColor redColor]];
    [self.tableView.footer addSubview:errorInfo];
}

#pragma mark ----- tableView的代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataTable.count;
}

#pragma mark 列表下拉下载上拉更新需实现的方法
- (void)loadMoreData:(long) warterId dataCount:(int)cellCount
{
    
}

- (void)headerRereshing
{
    
       
}

- (void)footerRereshing
{
    
    
}

-(int )pageCount{
    return CONTENT_HIGH/WATER_LIST_ROW_HIGH+2;
}

-(long )firstDataId{
    return 0;
}

-(long )lastDataId{
    return 0;
}

- (void)backClick{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)doneClick{
    BSLog(@"默认为同返回一致的动作");
}

-(void)modifiedStyle{
    BSLog(@"根据权限修改元素显示，子类需实现");
}

//控制是否可以根据故事板跳转
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
/**
 *页面跳转公共方法
 */
-(void)navigating:(BSTableContentObject*)bsContentObject{
    [BSContentObjectNavigation navigatingControllWithStorybord:self       bsContentObject:bsContentObject];
}

#pragma mark --编码或者不在一个故事板中得跳转方法
-(void)navigating:(UIViewController *)callerController storybord:(NSString *)storybordName identity:(NSString *)identity canUseStoryboard:(BOOL)useStoryboard noLoginCheck:(BOOL) check{
    BSTableContentObject * bsContentObject=[BSTableContentObject initWithController:callerController storybord:storybordName identity:identity canUseStoryboard:useStoryboard];
    bsContentObject.noNeedLoginCheck=check;
    [self navigating:bsContentObject];
}

-(void)navigating:(UIViewController *)callerController storybord:(NSString *)storybordName identity:(NSString *)identity canUseStoryboard:(BOOL)useStoryboard{
    BSTableContentObject * bsContentObject=[BSTableContentObject initWithController:callerController storybord:storybordName identity:identity canUseStoryboard:useStoryboard];
    [self navigating:bsContentObject];

}


#pragma mark -
#pragma mark 解决虚拟键盘挡住UITextField的方法
#pragma mark 解决虚拟键盘挡住UITextField的方法

-(void) keyNotification : (NSNotification *) notification
{
    NSLog(@"%@", notification.userInfo);
    
    self.keyBoardDic = notification.userInfo;
    //获取键盘移动后的坐标点的坐标点
    CGRect rect = [self.keyBoardDic[@"UIKeyboardFrameEndUserInfoKey"] CGRectValue];
    
    //把键盘的坐标系改成当前我们window的坐标系
    CGRect r1 = [self.view convertRect:rect
                              fromView:self.view.window];
    
    [UIView animateWithDuration:[self.keyBoardDic[UIKeyboardAnimationDurationUserInfoKey] floatValue] animations:^{
        CGRect frame = self.scrollViewWithKeyboard.frame;
        
        if (( self.frameTextFirstResponder.origin.y)<rect.origin.y){
            frame.origin.y = r1.origin.y - frame.size.height+self.highOffsetWithKeyBoard;
            //根据键盘的高度来改变toolView的高度
            if (IS_IPHONE5) {
                frame.origin.y = r1.origin.y - frame.size.height;
            }
            self.scrollViewWithKeyboard.frame = frame;
            
        }
    }];
    
}

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
    [textField resignFirstResponder];
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    CGRect rect = CGRectMake(0,0, self.view.frame.size.width, self.view.frame.size.height);
    
    self.view.frame = rect;
    [UIView commitAnimations];
    [textField resignFirstResponder];
    
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.frameTextFirstResponder=textField.frame;
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

//实现当键盘出现的时候计算键盘的高度大小。用于输入框显示位置
- (void)keyboardWasShown:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    //kbSize即為鍵盤尺寸 (有width, height)
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;//得到鍵盤的高度
    NSLog(@"hight_hitht:%f",kbSize.height);
    int keyboardhight;
    if(kbSize.height == 216)
    {
        keyboardhight = 0;
    }
    else
    {
        keyboardhight = 36;   //252 - 216 系统键盘的两个不同高度
    }
    //输入框位置动画加载
    //[self begainMoveUpAnimation:keyboardhight];
}

//当键盘隐藏的时候
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    self.scrollViewWithKeyboard.frame=self.scrollViewframe;
}

//键盘遮挡问题
-(void)configUIViewAndHighOffsetWithKeyBoard{
    
}

-(void)configSuggestTextFiled{
    
}

//设置代理
-(void)delelageForTextField{
    BSLog(@"设置Text");
    
    
}

- (void)textViewDidChange:(UITextView *)textView
{
    [textView resignFirstResponder];
}

-(void)keyboardDone:(id)sender{
    BSLog(@"键盘事件-确定查询");
}

#pragma mark -

#pragma mark -键盘添加Button
- (void) registerForKeyboardNotifications{
    
    //当键盘出来的时候通过通知来获取键盘的信息
    //注册为键盘的监听着
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(keyNotification:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    //使用NSNotificationCenter 鍵盤出現時
    [center addObserver:self
               selector:@selector(keyboardWasShown:)
                   name:UIKeyboardDidShowNotification object:nil];
    
    //使用NSNotificationCenter 鍵盤隐藏時
    [center addObserver:self
               selector:@selector(keyboardWillBeHidden:)
                   name:UIKeyboardWillHideNotification object:nil];
    
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

@end

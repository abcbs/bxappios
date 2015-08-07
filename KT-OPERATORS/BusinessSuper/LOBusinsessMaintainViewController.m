//
//  LOBusinsessMaintainViewController.m
//  KTAPP
//
//  Created by admin on 15/7/30.
//  Copyright (c) 2015年 itcast. All rights reserved.
//


#import "LOBusinsessMaintainViewController.h"

@interface LOBusinsessMaintainViewController ()<UITextFieldDelegate,UITextViewDelegate>
{
    BOOL isEdit;
    //商家头像
    BOOL isHeaderImage;
    //商家头像图
    __block Resources *rs;
    //商家宣传图资源信息
    NSMutableArray *rsInfoArray;
    //商家宣传图
    NSMutableArray *rsImageArray;
    //联系人信息
    NSMutableArray *ubArray;
    //业务类型信息
    NSMutableArray *catagoryArray;
    //支付工具
    NSMutableArray *usePays;
    NSIndexPath *  selectedIndexPath;
}
@end

@implementation LOBusinsessMaintainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (rs==nil) {
        rs=[[Resources alloc]init];
        
    }
    if (rsImageArray==nil) {
        rsImageArray=[NSMutableArray array];
    }
    
    if (rsInfoArray==nil) {
        rsInfoArray=[NSMutableArray array];
    }
    if (ubArray==nil){
        ubArray=[NSMutableArray array];
    }
    if (catagoryArray==nil) {
        catagoryArray=[NSMutableArray array];
    }
    if(usePays==nil){
        usePays=[NSMutableArray array];
    }
    //图片选择与拍照
    self.takeController = [[BSPhotoTakeController alloc] init];
    self.takeController.delegate = self;
    
    [self modifiedStyle];
    
    [self initSubViews];
    
    [self setupData];

}

- (void)viewDidAppear:(BOOL)animated{
    
    //if (ubArray==nil){
    //    ubArray=[NSMutableArray array];
    //}
}
- (void)dealloc{
    //[self.besinessIntroduce removeFromSuperview];
    //[self.businessResouceImages removeFromSuperview];
    //[self.businessHeaderImage removeFromSuperview];
    //[self clearViewData];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


#pragma mark --键盘关闭处理
#pragma mark -UITextField的代理事件，换行执行的操作，去掉键盘

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    return YES;
}
#pragma mark -UITextView的代理事件，去除软键盘
-(void)modifiedStyle{
    [super modifiedStyle];
    //self.navigationItem.rightBarButtonItem = nil;
    //[self.publishTime setEnabled:YES];
    //[self.publishTime setHidden:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initSubViews
{
    isEdit=NO;
}

/**
 *数据装载
 */
- (void)setupData
{
    if (_editDelegate)
    {
        isEdit = YES;
        BusinessBase *bs=self.business.businessBase;
        //商家名称
        _businessName.text=bs.name;
        //营业执照
        _commerceLicense.text=bs.commerceLicense;
        //办公地点
        _officerAddress.text=bs.address;
        //商家介绍信息
        _besinessIntroduce.text=bs.introduce;
        
        //法人信息
        UserBase *ub=self.business.artificial;
        //法人姓名
        _entityName.text=ub.name;
        _entityPhone.text=ub.phone;
        _entityTel.text=ub.telephone;
        _entityEmail.text=ub.email;
        _entityAddress.text=ub.address;
        //法人证件类型
        _entityIDType.text=ub.entityType;
        _entityIDNumber.text=ub.entityIDNumber;
        
        //头像
        
        //联系人
        ubArray=self.business.contractUsers;
        //经营范围
        catagoryArray= self.business.productCatalogues;
        //支付工具
        usePays=self.business.userPays;
    }
}

-(void)clearViewData{
    //商户名称
     _businessName.text=nil;
    //营业执照
     _commerceLicense.text=nil;
    //办公地址
     _officerAddress.text=nil;
    //地理位置信息
    _geoInfo.text=nil;
    //法人信息-法人姓名
    _entityName.text=nil;
    //法人信息-证件类型
     _entityTel.text=nil;
    //法人信息-证件号
    _entityIDNumber.text=nil;
    //法人信息-签约手机
     _entityPhone.text=nil;
    //法人信息-联系电话
    //法人信息-Email
    _entityEmail.text=nil;
    //法人信息-联系地址
    _entityAddress.text=nil;
    //法人信息-账号类型
    _accoutType.text=nil;
    _entityIDType.text=nil;
    //商家头像
    _businessHeaderImage.image=nil;
    //商家宣传图片
    //[_businessResouceImages removeConstraints:rsImageArray];
    
    //商家介绍信息
    _besinessIntroduce.text=nil;
    //银行支付账号
    _bankAccount.text=nil;
    
    [rsInfoArray removeAllObjects];
    [rsImageArray removeAllObjects];
    
    [ubArray removeAllObjects];
    [catagoryArray removeAllObjects];
    [usePays removeAllObjects];
    
    [self.business.productCatalogues removeAllObjects];
    [self.business.userPays removeAllObjects];;
    [self.business.contractUsers removeAllObjects];
    
    self.business.productCatalogues=nil;
    self.business.userPays=nil;
    self.business.contractUsers=nil;
    
    self.business=nil;

    rs=nil;
    rsImageArray=nil;
    rsInfoArray=nil;
    ubArray=nil;
    catagoryArray=nil;
    usePays=nil;
    [self.tableView reloadData];
}

-(BusinessBaseDomail *)business{
    if (!_business) {
        _business=[[BusinessBaseDomail alloc]init];
    }
    return _business;
}

-(BOOL) checkRightfulData{
    BOOL checkAnonName=[BSValidatePredicate
                        checkNilField:_businessName alert:@"商户名称不能为空"];
    if (!checkAnonName) {
        return NO;
    }
    
    return YES;
}
-(void)saveData{
    if (![self checkRightfulData]){//数据校验没有通过
        return;
    }
    //商家基本信息
    BusinessBase *bs=[BusinessBase new];
    bs.name=_businessName.text;
    //营业执照
    bs.commerceLicense=_commerceLicense.text;
    //办公地点
    bs.address=_officerAddress.text;
    //商家介绍信息
    bs.introduce=_besinessIntroduce.text;
    
    _business.businessBase=bs;
    
    //法人信息
    UserBase *ub=[UserBase new];
    //法人姓名
    ub.name=_entityName.text;
    ub.phone=_entityPhone.text;
    ub.telephone=_entityTel.text;
    ub.email=_entityEmail.text;
    ub.address=_entityAddress.text;
    ub.userType=_entityIDType.text;
    ub.entityType=_entityIDType.text;
    ub.entityIDNumber=_entityIDNumber.text;
    //
    ub.userType=USER_TYPE_CONTACT;
    //法人信息
    self.business.artificial=ub;
    //联系人信息
    if (ubArray.count>0) {
        self.business.contractUsers =[NSMutableArray arrayWithArray:ubArray];

    }else{
        [self.business.contractUsers addObjectsFromArray:ubArray];
    }
    //经营范围
    if (catagoryArray.count>0) {
        self.business.productCatalogues=[NSMutableArray arrayWithArray:catagoryArray];
    }else{
        [self.business.productCatalogues addObjectsFromArray:catagoryArray];
    }
    //支付工具
    if (usePays.count>0) {
        self.business.userPays=[NSMutableArray arrayWithArray:usePays];
    }else{
        [self.business.userPays addObjectsFromArray:usePays];
    }
    if (isEdit) {
        [_editDelegate editedBusiness:_business];
        [self.navigationController popViewControllerAnimated:YES];
    }
    if (!isEdit)
    {
        if ([self.editDelegate respondsToSelector:@selector(addBusiness:)]){
            [_editDelegate addBusiness:_business];
             [self.navigationController popViewControllerAnimated:YES];
        }else{
            //新建商家
            BusinessManager *bm=[BusinessManager businessManager];
            [bm insertBusiness:_business];
            UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"下一个" style:UIBarButtonItemStylePlain target:self action:@selector(nextData)];
            self.navigationItem.rightBarButtonItem = rightButton;
            
            UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithTitle:@"<商家列表" style:UIBarButtonItemStylePlain target:self action:@selector(toPageController)];
            self.navigationItem.leftBarButtonItem = leftButton;


        }
        
    }
 
}

/** Finishes the editing */

-(void)toPageController{
    [self navigating:self storybord:@"LOBusinessrSuper" identity:@"LOBusinessListViewController" canUseStoryboard:YES];
    
}
- (void)nextData
{
    [self.besinessIntroduce resignFirstResponder];
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]
                                    initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(saveData)];
    self.navigationItem.rightBarButtonItem = rightButton;
    _business=nil;
    _business=[BusinessBaseDomail new];
    [self modifiedStyle];
    [self initSubViews];
    [self clearViewData];
}

- (IBAction)saveBusinessData:(id)sender {
    [self saveData];
}


#pragma mark -UITextView焦点操作
/** Adds the 'Done' button to the title bar
 */
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    // We need to add this manually so we have a way to dismiss the keyboard
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(dismissKeyboard)];
    //[self.tintColor]
    self.navigationItem.rightBarButtonItem = rightButton;
}



/** Finishes the editing */
- (void)dismissKeyboard
{
    [self saveData];
    [self.besinessIntroduce resignFirstResponder];
    
}

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    //跳转到类型维护
}
#pragma mark -业务数据处理的事件
//业务类型 tag=10
- (IBAction)catatoryClick:(id)sender {
    BSLog(@"业务类型处理");
    //if (catagoryArray==nil) {
        catagoryArray=[NSMutableArray array];
    //}
    
    ProductCatalogue *pc=[ProductCatalogue new];
    pc.code=@"1001";
    pc.comment=@"送水";
    [catagoryArray addObject:pc];
    
    pc=[ProductCatalogue new];
    pc.code=@"1002";
    pc.comment=@"超市";
    [catagoryArray addObject:pc];
    
    
    if (self.business.productCatalogues==nil) {
        self.business.productCatalogues=[NSMutableArray arrayWithArray:catagoryArray];
    }else{
        [self.business.productCatalogues addObjectsFromArray:catagoryArray];
    }
    //一个section刷新
    NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:IDX_CATAGORY];
    
    [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
    //[self.tableView reloadData];

}

//联系人信息 tag=20
- (IBAction)contractClick:(id)sender {
    BSLog(@"联系人处理开始");
    //if (ubArray==nil) {
        ubArray=[NSMutableArray array];
    //}
   
    UserBase *ub=[UserBase new];
    ub.name=@"张三";
    ub.phone=@"136888888877";
    ub.entityIDNumber=@"11010133334455";
    ub.entityType=@"身份证";
    ub.userType=USER_TYPE_CONTACT;
    [ubArray addObject:ub];
    
    //[self.business.contractUsers addObject:ub];
    ub=[UserBase new];
    
    ub.name=@"李四";
    ub.phone=@"136777777777";
    ub.entityIDNumber=@"66660133334455";
    ub.entityType=@"身份证";
    ub.userType=USER_TYPE_CONTACT;
    [ubArray addObject:ub];
    
    if (self.business.contractUsers==nil) {
        self.business.contractUsers=[NSMutableArray arrayWithArray:ubArray];
    }else{
        [self.business.contractUsers addObjectsFromArray:ubArray];
    }

    //一个section刷新
    NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:IDX_CONTRACT];
    
    [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
    

    BSLog(@"联系人处理结束");
}

//支付方式 tag=30
- (IBAction)bandPayAccount:(id)sender {
    BSLog(@"绑定支付账号开始");
    usePays=[NSMutableArray array];
    
    UserPay *up=[UserPay new];
    up.name=@"张三";
    up.payTool=@"工行存蓄卡";
    up.certificateType=@"身份证";
    up.certificateNumber=@"11010111111164444";
    up.cvv=@"6333000099998888777";
    up.phone=@"1356666666";
    [usePays addObject:up];
    
    up=[UserPay new];
    up.name=@"赵六";
    up.payTool=@"德阳存蓄卡";
    up.certificateType=@"身份证";
    up.certificateNumber=@"3301077777777768888";
    up.cvv=@"6333000099998888777";
    up.phone=@"1356666666";
    [usePays addObject:up];

    if (self.business.userPays==nil) {
        self.business.userPays=[NSMutableArray arrayWithArray:usePays];
    }else{
        [self.business.userPays addObjectsFromArray:usePays];
    }
    
    //一个section刷新
    NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:IDX_USERPAY];
    
    [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];

    
}

- (IBAction)entityImageClick:(id)sender {
    BSLog(@"法人头像处理");
}

- (IBAction)headerImageClick:(id)sender {
     BSLog(@"商家头像处理");
}

- (IBAction)resourceImages:(id)sender {
     BSLog(@"商家轮播图处理");
}

-(void)displayAD:(NSMutableArray *)images{
    BSFCRollingADImageUIView *adView= [BSFCRollingADImageUIView initADWithImages:images  playerDelegate:self target:self width:SCREEN_WIDTH height:(200)];
    //资源轮播
    [adView removeFromSuperview];
    //商家宣传组图
    [self.businessResouceImages addSubview:adView];
}

- (void)takeController:(BSPhotoTakeController *)controller didCancelAfterAttempting:(BOOL)madeAttempt
{
    BSLog(@"取消拍照动作操作");
}

- (UIViewController *)takeController:(BSPhotoTakeController *)controller{
    return self;
}

//商家头像
- (void)takeController:(BSPhotoTakeController *)controller gotPhoto:(UIImage *)photo withInfo:(Resources *)info
{
    rs=info;
    [_businessHeaderImage setImage:photo];
}
- (void)takeController:(BSPhotoTakeController *)controller gotPhotoArray:(NSMutableArray *)photoImages withInfo:(NSMutableArray *)info{
    [rsInfoArray removeAllObjects];
    [rsImageArray removeAllObjects];
    [rsInfoArray addObjectsFromArray:info];
    [rsImageArray addObjectsFromArray:photoImages];
    [self displayAD:photoImages];
    
}

- (void)touchAction:(UIGestureRecognizer *)gester
{
    BSLog(@"轮播事件");
    UIView *egoivPhotoView = [gester view];
    
    NSInteger tPhotoIndex = [egoivPhotoView tag];
    NSLog(@"tPhotoIndex: %ld", tPhotoIndex);
    
}

#pragma mark -TableView动态创建部分

/**
 *选中某条数据
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    selectedIndexPath=indexPath;
}
/*
 *商家基本信息
 *法人信息
 *介绍信息
 *业务类型 LOCatagoryTableViewCell
 *联系人   LOContactTableViewCell
 *支付方式 LOUserPayTableViewCell
 */
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell=nil;
    NSInteger sc=indexPath.section;
    NSString *headerTitle=[super tableView:tableView titleForHeaderInSection:sc];
    //联系人信息
    if([self isContractSelection:headerTitle section:sc]){
        
        if (self.business.contractUsers.count>0) {
            NSInteger idx= indexPath.row;
            UserBase *ub=[self.business.contractUsers objectAtIndex:idx];
            static NSString *ContactCellIdentifier = @"LOContactTableViewCell";
            cell  = [self obtainCellWith:ContactCellIdentifier];
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ContactCellIdentifier];
            cell.textLabel.text = ub.name;
            cell.detailTextLabel.text = ub.phone;
            return cell;
        }
    }else if([self isCatagorySelection:headerTitle section:sc]){
        if (self.business.productCatalogues.count>0) {
            
            NSInteger idx= indexPath.row;
            ProductCatalogue *pc=[self.business.productCatalogues objectAtIndex:idx];
            static NSString *CatagoryCellIdentifier = @"LOCatagoryTableViewCell";
            cell  = [self obtainCellWith:CatagoryCellIdentifier];
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CatagoryCellIdentifier];
            cell.accessoryType=UITableViewCellAccessoryDetailButton;
            cell.textLabel.text = pc.code;
            cell.detailTextLabel.text = pc.comment;
            
            //cell.
            
            return cell;
        }
        
    }else if([self isUserPaySelection:headerTitle section:sc]){
        if (self.business.userPays.count>0) {
            NSInteger idx= indexPath.row;
            UserPay *pc=[self.business.userPays objectAtIndex:idx];
            static NSString *CatagoryCellIdentifier = @"LOUserPayTableViewCell";
            cell  = [self obtainCellWith:CatagoryCellIdentifier];
            
            cell.textLabel.text = [pc.name
                                   stringByAppendingFormat:@" 手机号: %@",pc.phone];
            cell.detailTextLabel.text = [pc.payTool
                                  stringByAppendingFormat:@" 卡号:%@",pc.cvv];
            
            return cell;
        }
    }
    
    return [super tableView:tableView cellForRowAtIndexPath:indexPath];
}

//numberOfRowsInSection,每章节的行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    NSInteger numberOfRows=[super tableView:tableView
                  numberOfRowsInSection:section];
    NSString *headerTitle=[super tableView:tableView titleForHeaderInSection:section];
    if ([self isContractSelection:headerTitle section:section]) {
        if (self.business.contractUsers) {
            return self.business.contractUsers.count;
        }else{
            return 1;
        }
        
    }else if ([self isCatagorySelection:headerTitle section:section]) {
        if (self.business.productCatalogues) {
            return self.business.productCatalogues.count;
        }else{
            return 1;
        }
        
    }else if ([self isUserPaySelection:headerTitle section:section]) {
        if (self.business.userPays) {
            return self.business.userPays.count;
        }else{
            return 1;
        }
        
    }
    
    return numberOfRows;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    NSInteger numRowOfSections= [super numberOfSectionsInTableView:tableView];

    if ([self isContractSelection:SECTION_CONTRACT section:0]) {
        //SECTION_CONTRACT
    }
    return numRowOfSections;

}


- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *titleHeader=[super tableView:tableView
                   titleForHeaderInSection:section];
    BSLog(@"章节头部标题:\t%@",titleHeader);
    if ([self isBusinessBaseSelection:titleHeader section:section]) {
        titleHeader=[titleHeader
                     stringByAppendingFormat:@"\t\t商家标示: %@",
                        @"20150801000001"];
    }else if([self isCatagorySelection:titleHeader section:section]){
        NSInteger cCount=self.business.productCatalogues.count;
        titleHeader=[titleHeader
                     stringByAppendingFormat:@"\t\t\t\t营业范围共计: %ld 类",
                     cCount];
    }else if ([self isContractSelection:titleHeader section:section]){
        NSInteger cCount=self.business.contractUsers.count;
        titleHeader=[titleHeader
                     stringByAppendingFormat:@"\t\t\t\t联系人共计: %ld 员",
                     cCount];

    }else if([self isUserPaySelection:titleHeader section:section]){
        NSInteger cCount=self.business.userPays.count;
        titleHeader=[titleHeader
                     stringByAppendingFormat:@"\t\t\t\t支付方式共计: %ld 种",
                     cCount];
    }
    return titleHeader;
}

//业务类型判断
-(BOOL) isBusinessBaseSelection:(NSString *)titleHeader
                        section:(NSInteger)section{
    return [titleHeader isEqualToString:SECTION_BUSINESS]&&section==IDX_BUSINESS;
}


//业务类型判断
-(BOOL) isCatagorySelection:(NSString *)titleHeader section:(NSInteger)section{
    return [titleHeader isEqualToString:SECTION_CATAGORY]&&section==IDX_CATAGORY;
}

//联系方式判断
-(BOOL) isContractSelection:(NSString *)titleHeader section:(NSInteger)section{
    return [titleHeader isEqualToString:SECTION_CONTRACT]&&section==IDX_CONTRACT;
}

//联系方式判断
-(BOOL) isUserPaySelection:(NSString *)titleHeader section:(NSInteger)section{
    return [titleHeader isEqualToString:SECTION_USERPAY]&&section==IDX_USERPAY;
}

//先执行titleForHeaderInSection
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView* viewHeader=[super tableView:tableView
                 viewForHeaderInSection:section];
    NSString *titleHeader=[super tableView:tableView
                   titleForHeaderInSection:section];
    //业务类型
    //联系人
    if ([self isCatagorySelection:titleHeader section:section]) {
        UIView *catagoryView=[UIView new];
       
        //添加到视图
        [catagoryView addSubview:[self headerLable:@"业务类型"]];

         UIButton * maintain=[self headerButton:@"业务类型管理"
                                               action:@selector(catatoryClick:)];
         [catagoryView addSubview:maintain];
        
        viewHeader=catagoryView;
    }else if([self isContractSelection:titleHeader section:section]){
        UIView *catagoryView=[UIView new];
        //添加到视图
        [catagoryView addSubview:[self headerLable:@"联系人信息"]];
        
        UIButton * maintain=[self headerButton:@"联系人管理"
                                        action:@selector(contractClick:)];
        
        [catagoryView addSubview:maintain];
        
        viewHeader=catagoryView;
    }else if([self isUserPaySelection:titleHeader section:section]){
        UIView *catagoryView=[UIView new];
        //添加到视图
        [catagoryView addSubview:[self headerLable:@"支付信息"]];
        
        UIButton * maintain=[self headerButton:@"支付管理"
                                        action:@selector(bandPayAccount:)];
        
        [catagoryView addSubview:maintain];
        
        viewHeader=catagoryView;
    }
    return viewHeader;
}

-(UIButton *)headerButton:(NSString *)title action:(SEL)action{
    UIButton *maintainButton = [UIButton buttonWithType:UIButtonTypeCustom];
    maintainButton.frame = BSRectMake(SCREEN_WIDTH-100, -6, 90, 36);
    [maintainButton.layer setMasksToBounds:YES];
    [maintainButton.layer setCornerRadius:10.0]; //设置矩形四个圆角半径
    [maintainButton.layer setBorderWidth:1.0]; //边框宽度
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 1, 0, 0, 1 });
    [maintainButton.layer setBorderColor:colorref];//边框颜色
    
    [maintainButton setTitle:title forState:UIControlStateNormal];
    [maintainButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];//title color
    [maintainButton.titleLabel setFont:[UIFont systemFontOfSize:13]];
    [maintainButton addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    
    return maintainButton;
}

-(UILabel *)headerLable:(NSString *)title{
    UILabel *headLable=[[UILabel alloc]init];
    headLable.text=title;
    headLable.font=[UIFont systemFontOfSize:13];
    headLable.textColor=[UIColor grayColor];
    [headLable sizeToFit];
    headLable.frame = BSRectMake(8, -6, 80, 36);
    return headLable;
}
- (NSString*)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    NSString *titleFooter=[super tableView:tableView
                   titleForFooterInSection:section];

    return titleFooter;
}



- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}


- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView* viewFooter=[super tableView:tableView
                 viewForFooterInSection:section];
    return viewFooter;
}


//设置Cell行缩进量
-(NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger sIndexPath=[super tableView:tableView indentationLevelForRowAtIndexPath:indexPath];
    return sIndexPath;
}


@end

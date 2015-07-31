//
//  LOBusinsessAddViewController.m
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
    //图片选择与拍照
    self.takeController = [[BSPhotoTakeController alloc] init];
    self.takeController.delegate = self;
    
    [self modifiedStyle];
    
    [self initSubViews];
    
    [self setupData];

}

- (void)dealloc{
    [self.besinessIntroduce removeFromSuperview];
    [self.businessResouceImages removeFromSuperview];
    [self.businessHeaderImage removeFromSuperview];
    
    [rsImageArray removeAllObjects];
    rsImageArray=nil;
    [rsInfoArray removeAllObjects];
    rsInfoArray=nil;
    
    self.business=nil;
    
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
        _entityIDType.text=ub.userType;
        _entityIDNumber.text=ub.entityIDNumber;
        //头像
        
        
    }
}


-(void)saveData{
    _business=[[BusinessBaseDomail alloc]init];
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
    ub.entityIDNumber=_entityIDNumber.text;
    
    _business.artificial=ub;
    
    if (isEdit) {
        [_editDelegate sendEditedBusiness:_business];
        _business = nil;
    }
    if (!isEdit)
    {
        
        [_editDelegate sendAddBusiness:_business];
    }
    
    [self.navigationController popViewControllerAnimated:YES];

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
    [self.besinessIntroduce resignFirstResponder];
    self.navigationItem.rightBarButtonItem = nil;
    [self saveData];
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

- (IBAction)catatoryClick:(id)sender {
     BSLog(@"业务类型处理");
}

- (IBAction)contractClick:(id)sender {
     BSLog(@"联系人处理");
}

- (IBAction)bandPayAccount:(id)sender {
     BSLog(@"绑定支付账号");
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

@end

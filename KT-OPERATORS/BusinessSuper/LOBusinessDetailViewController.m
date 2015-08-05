//
//  LOBusinessDetailViewController.m
//  KTAPP
//
//  Created by admin on 15/7/30.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "LOBusinessDetailViewController.h"
#import "LBModelsHeader.h"
#import "LOBusinsessMaintainViewController.h"


@interface LOBusinessDetailViewController ()<BSImagePlayerDelegate>

@property(nonatomic,strong)     BSFCRollingADImageUIView *adView;

@end

@implementation LOBusinessDetailViewController
@synthesize adView=_adView;

@dynamic business;

@dynamic businessName;

//营业执照
@dynamic commerceLicense;

//办公地址
@dynamic officerAddress;

//地理位置信息
@dynamic geoInfo;

//法人信息-法人姓名
@dynamic entityName;

//法人信息-证件类型
@dynamic entityIDType;

//法人信息-证件号
@dynamic entityIDNumber;

//法人信息-签约手机
@dynamic entityPhone;

//法人信息-联系电话
@dynamic entityTel;

//法人信息-Email
@dynamic entityEmail;

//法人信息-联系地址
@dynamic entityAddress;


//法人信息-账号类型
@dynamic accoutType;

//商家头像
@dynamic businessHeaderImage;


//商家宣传图片
@dynamic businessResouceImages;

//商家介绍信息
@dynamic besinessIntroduce;

//银行支付账号
@dynamic bankAccount;



- (void)viewDidLoad {
    [super viewDidLoad];
    [self display];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc{
    [self.besinessIntroduce removeFromSuperview];
    [self.businessResouceImages removeFromSuperview];
    [self.businessHeaderImage removeFromSuperview];
    self.business=nil;

    
}
#pragma mark --样式调整

-(void)display{
    
    BusinessBase *bs=self.business.businessBase;
    //商家信息
    //商家名称
    self.businessName.text=bs.name;
    //营业执照
    self.commerceLicense.text=bs.commerceLicense;
    //办公地点
    self.officerAddress.text=bs.address;
    //商家介绍信息
    self.besinessIntroduce.text=bs.introduce;
    
    //法人信息
    UserBase *ub=self.business.artificial;
    //法人姓名
    self.entityName.text=ub.name;
    self.entityPhone.text=ub.phone;
    self.entityTel.text=ub.telephone;
    self.entityEmail.text=ub.email;
    self.entityAddress.text=ub.address;
    self.entityIDType.text=ub.userType;
    self.entityIDNumber.text=ub.entityIDNumber;
    [self.tableView reloadData];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}
-(void)displayAD:(NSMutableArray *)images{
    _adView= [BSFCRollingADImageUIView initADWithImages:images  playerDelegate:self target:self width:SCREEN_WIDTH height:self.businessResouceImages.height];
    //资源轮播
    if (self.adView) {
        [self.adView removeFromSuperview];
    }
    [self.businessResouceImages addSubview:_adView];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    LOBusinsessMaintainViewController *edit = (LOBusinsessMaintainViewController *)segue.destinationViewController;
    edit.editDelegate = self;
    edit.business = self.business;;
}

-(void)editedBusiness:(BusinessBaseDomail *)businessBaseDomail{
    self.business =businessBaseDomail ;
    
    [_browseDelegate editedBusiness:self.business];
    [self display];
    
}

- (void)addBusiness:(BusinessBaseDomail *) businessBaseDomail{
    self.business=businessBaseDomail;
    [_browseDelegate addBusiness:self.business];
    [self display];
}


- (void)touchAction:(UIGestureRecognizer *)gester
{
    BSLog(@"轮播事件");
    UIView *egoivPhotoView = [gester view];
    
    NSInteger tPhotoIndex = [egoivPhotoView tag];
    NSLog(@"tPhotoIndex: %ld", tPhotoIndex);
    
}


#pragma mark --TableView个性化处理

//先执行titleForHeaderInSection
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}

//章节头信息
- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *titleHeader=[super tableView:tableView
                   titleForHeaderInSection:section];
    BSLog(@"章节头部标题:\t%@",titleHeader);
    if ([self isBusinessBaseSelection:titleHeader section:0]) {
        titleHeader=[titleHeader
                     stringByAppendingFormat:@"\t\t商家标示:%@",
                     @"20150801000001"];
    }
    return titleHeader;
}

//章节数量
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSInteger numRowOfSections= [super numberOfSectionsInTableView:tableView];
    if ([self isContractSelection:SECTION_CONTRACT section:0]) {
        //SECTION_CONTRACT
    }
    return numRowOfSections;
    
}
@end

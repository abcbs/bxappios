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
    _adView= [BSFCRollingADImageUIView initADWithImages:images  playerDelegate:self target:self width:SCREEN_WIDTH height:_businessResouceImages.height];
    //资源轮播
    if (_adView) {
        [_adView removeFromSuperview];
    }
    [_businessResouceImages addSubview:_adView];
}
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    LOBusinsessMaintainViewController *edit = (LOBusinsessMaintainViewController *)segue.destinationViewController;
    edit.editDelegate = self;
    edit.business = _business;;
}

-(void)sendEditedBusiness:(BusinessBaseDomail *)business{
    _business =business ;
    
    [_browseDelegate refreshBusiness:business];
    [self display];
    
}

- (void)sendAddBusiness:(BusinessBaseDomail *) business{
    [_browseDelegate sendAddBusiness:business];
    [self display];
}
- (IBAction)previewHeadImage:(id)sender {
}

- (IBAction)previewResourceImages:(id)sender {
}

- (void)touchAction:(UIGestureRecognizer *)gester
{
    BSLog(@"轮播事件");
    UIView *egoivPhotoView = [gester view];
    
    NSInteger tPhotoIndex = [egoivPhotoView tag];
    NSLog(@"tPhotoIndex: %ld", tPhotoIndex);
    
}
@end

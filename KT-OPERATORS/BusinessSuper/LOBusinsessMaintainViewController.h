//
//  LOBusinsessMaintainViewController
//  KTAPP
//
//  Created by admin on 15/7/30.
//  Copyright (c) 2015年 itcast. All rights reserved.
//
#define SECTION_BUSINESS @"商家基本信息"
#define SECTION_CATAGORY @"业务类型"
#define SECTION_CONTRACT @"联系人"
#define SECTION_USERPAY @"支付方式"

#define IDX_BUSINESS 0
#define IDX_CATAGORY 3
#define IDX_CONTRACT 4
#define IDX_USERPAY   5

#import "BSUITableViewCanEditedController.h"
#import "BSUIFrameworkHeader.h"
#import "BSIFTTHeader.h"
#import "LBModelsHeader.h"
#import "LOBusinessManagerDelegate.h"

@interface LOBusinsessMaintainViewController : BSUITableViewCommonController<BSPhotoTakeDelegate,BSImagePlayerDelegate>

@property (strong,nonatomic) BSPhotoTakeController *takeController;

//业务模型和操作代理
@property (weak, nonatomic) id<LOBusinessManagerDelegate> editDelegate;

@property (nonatomic,strong)BusinessBaseDomail *business;

//商户名称
@property (weak, nonatomic) IBOutlet UITextField *businessName;

//营业执照
@property (weak, nonatomic) IBOutlet UITextField *commerceLicense;

//办公地址
@property (weak, nonatomic) IBOutlet UITextField *officerAddress;

//地理位置信息
@property (weak, nonatomic) IBOutlet UITextField *geoInfo;

//法人信息-法人姓名
@property (weak, nonatomic) IBOutlet UITextField *entityName;

//法人信息-证件类型
@property (weak, nonatomic) IBOutlet UITextField *entityIDType;

//法人信息-证件号
@property (weak, nonatomic) IBOutlet UITextField *entityIDNumber;

//法人信息-签约手机
@property (weak, nonatomic) IBOutlet UITextField *entityPhone;

//法人信息-联系电话
@property (weak, nonatomic) IBOutlet UITextField *entityTel;

//法人信息-Email
@property (weak, nonatomic) IBOutlet UITextField *entityEmail;

//法人信息-联系地址
@property (weak, nonatomic) IBOutlet UITextField *entityAddress;


//法人信息-账号类型
@property (weak, nonatomic) IBOutlet UITextField *accoutType;

//商家头像
@property (weak, nonatomic) IBOutlet UIImageView *businessHeaderImage;


//商家宣传图片
@property (weak, nonatomic) IBOutlet UIView *businessResouceImages;

//商家介绍信息
@property (weak, nonatomic) IBOutlet UITextView *besinessIntroduce;

//银行支付账号
@property (weak, nonatomic) IBOutlet UITextField *bankAccount;

//相关事件
//头像选择事件
- (IBAction)entityImageClick:(id)sender;

//商户头像事件
- (IBAction)headerImageClick:(id)sender;

//商家宣传图片事件
- (IBAction)resourceImages:(id)sender;

//商家业务类型管理
- (IBAction)catatoryClick:(id)sender;

//联系人管理
- (IBAction)contractClick:(id)sender;

//绑定支付账号
- (IBAction)bandPayAccount:(id)sender;

@property (weak, nonatomic) IBOutlet UITableViewRowAction *businessCatatorySelection;



- (IBAction)saveBusinessData:(id)sender;


-(BOOL) isBusinessBaseSelection:(NSString *)titleHeader
                        section:(NSInteger)section;
//业务类型判断
-(BOOL) isCatagorySelection:(NSString *)titleHeader
                    section:(NSInteger)section;
//联系方式判断
-(BOOL) isContractSelection:(NSString *)titleHeader
                    section:(NSInteger)section;

//联系方式判断
-(BOOL) isUserPaySelection:(NSString *)titleHeader
                   section:(NSInteger)section;
@end

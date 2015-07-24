//
//  KTHandyViewController.m
//  KTAPP
//
//  Created by admin on 15/6/21.
//  Copyright (c) 2015年 KT. All rights reserved.
//

#import "KTHandyViewController.h"


#import "LBControllerHeader.h"

#import "BSUIFrameworkHeader.h"


@interface KTHandyViewController ()

//@property (retain, nonatomic) BSFCInitRuntimeTableView *bsTableView;

@end

@implementation KTHandyViewController

@synthesize showSwitchValue;


- (void)viewDidLoad {
    [super viewDidLoad];
 
    BSTableSection *bsTable=[BSTableSection initWithHeaderVcClassContent:@"首页"//章节显示标题
        imageName:@"tuhongse"//章节显示图标
        headerViewClass:nil//章节显示视图
        cellIdentifier:@"BSUISingleImageTableViewCell"//采用的TableViewCell
        cellClass:[BSUISingleImageTableViewCell class]//TableViewCell实现
        storyboard:@"LFRecommend" bsContent:nil];
    
    //推荐
    BSTableContentObject *recommend=[BSTableContentObject initWithContentObject:@"推荐"
        methodName:nil imageName:@"tuhongse.png"
        colClass:[LFRecommendViewController class]];
    
    [bsTable addBSTableContent:recommend sectionHeader:@"首页"];
    
    //交流
    BSTableContentObject *commu=[BSTableContentObject
        initWithContentObject:@"交流"
        methodName:nil imageName:@"tukuaihuang.png"
        colClass:[communicate class]];
    
    [bsTable addBSTableContent:commu sectionHeader:@"首页"];

    
    BSTableContentObject *appointment=[BSTableContentObject initWithContentObject:@"预约服务" methodName:nil imageName:@"tulvse.png"
        colClass:[appointmentController class]];
    
    [bsTable addBSTableContent:appointment sectionHeader:@"首页"];
    
     BSTableContentObject *lifeService=[BSTableContentObject initWithContentObject:@"生活服务" methodName:nil imageName:@"tukuailvse.png"
         colClass:[lifeServiceController class]];
    
    [bsTable addBSTableContent:lifeService sectionHeader:@"首页"];
    
    
    BSTableContentObject *bank=[BSTableContentObject
        initWithContentObject:@"银行业务预约"
        methodName:nil
        imageName:@"tukuail.png"
        colClass:[bankController class]];
    
    [bsTable addBSTableContent:bank sectionHeader:@"首页"];
    
    /*
     NSMutableArray *arry= [NSMutableArray arrayWithObject: recommendController];
    
    BSTableSection *bsTable=[BSTableSection initWithHeaderVcClassContent:@"首页"//章节显示标题
        imageName:@"tuhongse"//章节显示图标
        headerViewClass:nil//章节显示视图
        cellIdentifier:@"BSUISingleImageTableViewCell"//采用的TableViewCell
        cellClass:[BSUISingleImageTableViewCell class]//采用的TableViewCell实现
        storyboard:nil bsContent:arry];
    
    //BSTableContentObject *bsCar=[BSTableContentObject initWithContentObject:@"推荐" methodName:nil imageName:@"tuhongse.png" colClass:[recommendController class]];
    
    [bsTable addBSTableContent:bsCar sectionHeader:@"预约服务"];
    
    //[bsTable addBSTableContent:bsCar sectionHeader:@"预约服务"];
    */
    //定义完表格的数据之后，把它赋值为父类
    [super setValue:bsTable forKey:@"bSTableObjects"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -表格样式

/**
 *改变行的高度（实现主个代理方法后 rowHeight 设定的高度无效）
 */
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 130;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    NSLog(@"提交");
}

- (IBAction)availBluetoothDevice:(id)sender {
    NSLog(@"获取蓝牙设备信息");
    UISwitch *switchButton = (UISwitch*)sender;
    BOOL isButtonOn = [switchButton isOn];
    if (isButtonOn) {
        showSwitchValue.text = @"是";
    }else {
        showSwitchValue.text = @"否";
    }
}

@end

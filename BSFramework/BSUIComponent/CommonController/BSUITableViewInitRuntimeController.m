//
//  BSUITableViewInitRuntimeController.m
//  KTAPP
//
//  Created by admin on 15/6/24.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "BSUITableViewInitRuntimeController.h"
#import "BSTableObject.h"
#import "BSTableContentObject.h"
#import "UIViewController+BSTableObject.h"
#import "AppDelegate.h"
#import "Conf.h"

@interface BSUITableViewInitRuntimeController ()



@end

@implementation BSUITableViewInitRuntimeController
@synthesize tableView;


- (void)viewDidLoad {
    [super viewDidLoad];
    [Conf navigationHeader:self.navigationController ];
    
    self.tableView.dataSource =self;
    self.tableView.delegate = self;
    
    //super.tableView.tableHeaderView=nil;
}

-(NSMutableArray *)bSTableObjects{
    if (_bSTableObjects==nil) {
        _bSTableObjects=[[NSMutableArray alloc]init];
    }
    return _bSTableObjects;
}

/*
 本方法在故事板中已经定义，则应当注销，否则子类需要实现
-(UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:BSRectMake(NAVIGATIONBAR_X, NAVIGATIONBAR_Y, SCREEN_WIDTH, SCREEN_HEIGHT-NAVIGATION_ADD_STATUS_HEIGHT) style:UITableViewStyleGrouped];
        self.tableView.dataSource =self;
        self.tableView.delegate = self;

        [self.view addSubview: _tableView];
    }
    return _tableView;
}
*/

/**
 *设置Section的数量
*/
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    BSTableObject *bsTable=self.bSTableObjects[0];
    
    NSArray *titleData=[NSArray arrayWithObject :bsTable.header];
    return titleData;
}

/**
 *表的章节数量,指定有多少个分区(Section)
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.bSTableObjects.count;
}

/**
 *每个章节内条目数量,
 
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    BSTableObject *bsTable = self.bSTableObjects[section];
    return bsTable.content.count;
}

/**
 *章节的标题,自定义表格头信息,设置每个section显示的Title
 */
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    
    BSTableObject *bsTable = self.bSTableObjects[section];
    return bsTable.header;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"BSTableContentObject";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]init];
    }
    BSTableObject *bsTable = self.bSTableObjects[indexPath.section];
    BSTableContentObject *bsContent = bsTable.content[indexPath.row];
    cell.textLabel.text =bsContent.title;
    return cell;
}


/**
 * 选择行内容
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BSTableObject *bsTable = self.bSTableObjects[indexPath.section];
    BSTableContentObject *bsContent=bsTable.content[indexPath.row];
    Class clzz=nil;
    
    if (bsContent.vcClass) {
        clzz=bsContent.vcClass;
    }else if(bsTable.vcClass&&bsContent==nil){
        clzz=bsTable.vcClass;
    }

    UIStoryboard *storyboard = [UIStoryboard
                                storyboardWithName:@"KTWaterDetailsViewController" bundle:nil];
    
    UIViewController *shoppControl = [storyboard instantiateViewControllerWithIdentifier:@"TableViewController"];
    
    UINavigationController* nav = [[UINavigationController alloc]  initWithRootViewController:shoppControl];
    
    [self presentViewController:nav animated:YES completion:nil];    //
}


@end

//
//  BSUITableViewInitRuntimeController.m
//  KTAPP
//
//  Created by admin on 15/6/24.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "BSUITableViewInitRuntimeController.h"
#import "BSTableSection.h"
#import "BSTableContentObject.h"
#import "UIViewController+BSTableObject.h"
#import "AppDelegate.h"
#import "Conf.h"


@interface BSUITableViewInitRuntimeController ()



@end

@implementation BSUITableViewInitRuntimeController
@synthesize tableView;
@synthesize bSTableObjects;

- (void)viewDidLoad {
    [super viewDidLoad];
    [Conf navigationHeader:self.navigationController ];
    self.tableView.dataSource =self;
    self.tableView.delegate = self;
    
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
 *章节的标题,自定义表格头信息,设置每个section显示的Title
 *重写方法，适应标题栏的个性化
 */

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *bsTable =[self titleForHeaderInSection:section];
    NSLog(@"章节标题为%@",bsTable);
    return bsTable;
}

/**
 * 每行需要个性化时，需要重写方法
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    long section=indexPath.section;
    long row=indexPath.row;
    BSTableContentObject *bsContentObject=[self bsContentObject:section row:row];
    NSString *ID = bsContentObject.vcClass;
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:ID];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]init];
    }
    cell.textLabel.text =bsContentObject.title;
    return cell;
}


/**
 *表的章节数量,指定有多少个分区(Section)
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSInteger sc=[self currentSectionNumber];
    NSLog(@"表的章节总数为%ld",(long)sc);
    return sc;
}

/**
 *每个章节内条目数量,
 
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger rows=[self rowSectionNumber:section];
    NSLog(@"每个章节的Row为%ld",(long)rows);
    return rows;
}

/**
 * 选择行内容
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    long section=indexPath.section;
    long row=indexPath.row;
    BSTableSection *bsTable = self.bSTableObjects;
    BSTableContentObject *bsContent= [self bsContentObject:section row:row];
    NSLog(@"转向界面的信息\t%@",bsContent.description);
    UIStoryboard *storyboard = [UIStoryboard
                                storyboardWithName:bsTable.storyboardName bundle:nil];
    
    UIViewController *shoppControl = [storyboard instantiateViewControllerWithIdentifier:bsContent.vcClass];
    
    UINavigationController* nav = [[UINavigationController alloc]  initWithRootViewController:shoppControl];
    
    [self presentViewController:nav animated:YES completion:nil];    //
}

-(NSString *)titleForHeaderInSection:(NSInteger)section{
    return [self.bSTableObjects.content objectAtIndex:section];
}

-(NSInteger)currentSectionNumber{
    return [self.bSTableObjects currentSectionNumber];
}


-(NSInteger) rowSectionNumber:(NSInteger)section{
    return [self.bSTableObjects currentRowNumber:section];
}

-(BSTableContentObject *) bsContentObject:(NSInteger)section row:(NSInteger)row{
    BSTableSection *bsTable = self.bSTableObjects;
    NSString *sectionTitle = bsTable.sectionTitle;
    NSMutableArray *bsArray= [bsTable sectionData:sectionTitle];
    return[bsArray objectAtIndex:row];
}

-(NSMutableArray *)indexes{

    return self.bSTableObjects.content;
}

@end

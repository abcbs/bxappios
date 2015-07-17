//
//  BSUITableViewInitRuntimeController.m
//  KTAPP
//
//  Created by admin on 15/6/24.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "BSUITableViewInitRuntimeController.h"

#import "BSUIFrameworkHeader.h"


@interface BSUITableViewInitRuntimeController ()


@end

@implementation BSUITableViewInitRuntimeController
@synthesize tableView;
@synthesize bSTableObjects;

- (void)viewDidLoad {
    [super viewDidLoad];
    if (tableView==nil) {
        self.tableView = [[UITableView alloc]initWithFrame:BSRectMake(NAVIGATIONBAR_X, NAVIGATIONBAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-NAVIGATION_ADD_STATUS_HEIGHT) style:UITableViewStyleGrouped];
            self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    
        [self.view addSubview: tableView];
    }else{
         self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    }
    
    self.tableView.dataSource =self;
    self.tableView.delegate = self;
    
}

-(void)setSeparatorStyle:(UITableViewCellSeparatorStyle *)separatorStyle{
    if (self.tableView) {
        self.tableView.separatorStyle=*(separatorStyle);
    }
}
- (void)backButtonClick
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)backClick{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)doneClick{
    NSLog(@"子类需要实例");
}

#pragma mark -以下三个方法是控制高度，在实现中需要子类根据具体情况处理
/**
 *改变行的高度（实现主个代理方法后 rowHeight 设定的高度无效）
 */
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger colNumber=[self.bSTableObjects currentCapatibilty:indexPath.section];
    if (colNumber>1){
        return BSMarginY(120);
        
    }
    return BSMarginX(121);
     
}

/**
 *每个section底部标题高度（实现这个代理方法后前面 sectionHeaderHeight 设定的高度无效）
 */
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return BSMarginY(30);
}

//每个section头部标题高度（实现这个代理方法后前面 sectionFooterHeight 设定的高度无效）
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    NSInteger colNumber=[self.bSTableObjects currentCapatibilty:section];
    if (colNumber>1){
        return BSMarginY(1);

    }
    if (IS_IPHONE5) {
        return BSMarginY(2);
    }else if  (IS_IPHONE_6){
        return BSMarginY(1);

    }else if (IS_IPHONE_6PLUS){
        return BSMarginY(1);

    }else{
        return BSMarginY(180);
    }
}

/**
 *行缩进
 */

-(NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSUInteger row = [indexPath row];
    return row;
}
#pragma mark -上面是表格样式的处理
#pragma mark -表格是否编辑、删除控制标记，默认为否
/**
 *划动cell是否出现可以编辑
 */
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

/**
 *行是否可移动标志
 */
-(BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

#pragma mark -章节头信息定义
/**
 *用以定制自定义的section头部视图－Header
 */
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}

/**
 *章节的标题,自定义表格头信息,设置每个section显示的Title
 *不建议重写此方法，如果重写则不显示章节标题
 */
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *bsTable= [self.bSTableObjects currentSectionTitle:section];
    return bsTable;
}
/**
 *TableView 表的章节数量,指定有多少个分区(Section)
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSInteger sc=[self.bSTableObjects currentSectionNumber];
    return sc;
}

#pragma mark -章节尾部
/**
 *每个section底部的标题－Footer
 */
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
    return nil;
}

//用以定制自定义的section底部视图－Footer
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}
#pragma mark -表头与表尾处理结束


#pragma mark -以下方法不建议重载

/**
 *每个章节内条目数量
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger rows=[self.bSTableObjects currentRowNumber:section];
    return rows;
}

/**
 * 选中Cell响应事件
 * 本方法在子类中不建议重写，如果重写在意味着本组件控制的现实逻辑不起作用
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    @try {
        long section=indexPath.section;
        long row=indexPath.row;
         //根据当前表格设置的列数，选择具体的TableViewCell
        NSInteger colNumber=[self.bSTableObjects currentCapatibilty:section];
        if (colNumber>1) {//默认情况
            //[BSTableViewCellData];
            return [[BSTableViewMultCellData initWithTableSelection:self bsTableSection:self.bSTableObjects tableView:self.tableView] processTableViewCell:section row:row];
        }
        return [[BSTableViewCellData initWithTableSelection:self bsTableSection:self.bSTableObjects tableView:self.tableView] processTableViewCell:section row:row];
    }
    @catch (NSException *exception) {
        NSLog(@"画单元格时出现错误\t%@",exception.reason);
    }
 }
#pragma mark 以上是单元格显示方法

#pragma mark 选中单元格事件
/**
 *选中之前执行,判断选中的行
 */
-(NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger colNumber=[self.bSTableObjects currentCapatibilty:indexPath.section];
    if (colNumber>1){
        return nil;
    }
    return indexPath;
}

/**
 *选中单元格响应事件
 *本方法在子类中不建议重写，如果重写在意味着本组件控制的现实逻辑不起作用
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    @try {
        long section=indexPath.section;
        long row=indexPath.row;
        [self prepareNavigationView:section row:row];
    }
    @catch (NSException *exception) {
        NSLog(@"选中单元格响应事件\t%@",exception.reason);
    }
  }

#pragma mark -以下是表格组件的具体实现私有方法

#pragma mark 功能界面跳转方法
/**
 *调用具体的TableViewCell，包括NIB实现方式、手工编码实现方式、故事板实现方式
 *优先默认为故事板实现
 */
-(void)prepareNavigationView:(NSInteger)section row:(NSInteger)row{
    

   BSTableContentObject *bs=[self.bSTableObjects currentContentObject:section row:row];
   bs.canUseStoryboard=[self.bSTableObjects canUseStoryBord:section row:row];
   [BSContentObjectNavigation navigatingControllWithStorybord:self bsContentObject:bs];
}
#pragma mark -上述方法完成了表格展现与选中。
#pragma mark -此类暂时不提供编辑功能，下面是编辑功能使用的方法

#pragma mark -行编辑功能，目前为非详细功能，因此不提供编辑功能
/**
 *行将显示的时候调用，预加载行
 */

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"将要显示的行是\n cell=%@  \n indexpath=%@",cell,indexPath);
}

/**
 *编辑状态，点击删除时调用
 */
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"编辑状态，点击删除时调用\n indexpath=%@",indexPath);
}

/**
 *cell右边按钮格式为
 *  UITableViewCellAccessoryDetailDisclosureButton时，
 *点击按扭时调用的方法
 */
-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"当前点击的详情button \n indexpath=%@",indexPath);
}

/**
 *右侧添加一个索引表
 */
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    return nil;
}

/**
 *设定横向滑动时是否出现删除按扭,（阻止第一行出现）
 */

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        return UITableViewCellEditingStyleNone;
    }
    else{
        return UITableViewCellEditingStyleDelete;
    }
    return UITableViewCellEditingStyleDelete;
}

/**
 *自定义划动时delete按钮内容
 */
- (NSString *)tableView:(UITableView *)tableView
titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除这行";
}

/**
 *开始移动row时执行
 */
-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath*)destinationIndexPath
{
    NSLog(@"sourceIndexPath=%@",sourceIndexPath);
    NSLog(@"sourceIndexPath=%@",destinationIndexPath);
}

/**
 *移动row时执行
 */
-(NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath
{
    NSLog(@"移动行动作");
    //用于限制只在当前section下面才可以移动
    if(sourceIndexPath.section != proposedDestinationIndexPath.section){
        return sourceIndexPath;
    }
    return proposedDestinationIndexPath;
}

/**
 *滑动可以编辑时执行
 */
-(void)tableView:(UITableView *)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"滑动可以编辑时执行:willBeginEditingRowAtIndexPath");
}

/**
 *将取消选中时执行, 也就是上次先中的行
 */
-(NSIndexPath *)tableView:(UITableView *)tableView willDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"上次选中的行是  \n indexpath=%@",indexPath);
    return indexPath;
}
@end

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
    
    //[BSUIComponentView initNarHeaderWithIndexView:self  title:@"首页导航"    ];
    if (tableView==nil) {
        self.tableView = [[UITableView alloc]initWithFrame:BSRectMake(NAVIGATIONBAR_X, NAVIGATIONBAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-NAVIGATION_ADD_STATUS_HEIGHT) style:UITableViewStyleGrouped];
        
        self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;

        [self.view addSubview: tableView];
    }
    self.tableView.dataSource =self;
    self.tableView.delegate = self;
    
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
    return BSMarginY(120);
}

/**
 *每个section底部标题高度（实现这个代理方法后前面 sectionHeaderHeight 设定的高度无效）
 */
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return BSMarginY(20);
}

//每个section头部标题高度（实现这个代理方法后前面 sectionFooterHeight 设定的高度无效）
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return BSMarginY(1);
}

/**
 *行缩进
 */

-(NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSUInteger row = [indexPath row];
    return row;
}

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
 *章节的标题,自定义表格头信息,设置每个section显示的Title
 *不建议重写此方法，如果重写则不显示章节标题
 */
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *bsTable =[self titleForHeaderInSection:section];
    NSLog(@"章节标题为%@",bsTable);
    return bsTable;
}

/**
 *用以定制自定义的section头部视图－Header
 */
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
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

#pragma mark -以下方法不建议重载
/**
 * 选中Cell响应事件
 * 本方法在子类中不建议重写，如果重写在意味着本组件控制的现实逻辑不起作用
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    @try {
        long section=indexPath.section;
        long row=indexPath.row;
        return [self processTableViewCell:section row:row];
    }
    @catch (NSException *exception) {
        NSLog(@"画单元格时出现错误\t%@",exception.reason);
    }
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
/**
 *按照表格中规定的显示表格信息
 */
-(UITableViewCell *)processTableViewCell:(NSInteger)section row:(NSInteger)row
{
    NSString *ID = [self currentCellIdentifierWithSection:section];
    UITableViewCell *cell=[self uiTableViewCellWithIdentifier:ID];
    if (cell==nil) {
        UINib *nib = [UINib nibWithNibName:ID bundle:nil];
        
        [self.tableView registerNib:nib forCellReuseIdentifier:ID];
    }
    Class clzz=[self cellIdentifierWithSection:section];
    BSTableContentObject *bsContentObject=(BSTableContentObject *)[self bsContentObject:section row:row];
    return [self processTableViewCell:clzz bsContentObject:bsContentObject];

}

/**
 *显示单元格
 *公共方法，需要继承或单独实现，来完成单元格绘制
 */
-(UITableViewCell *)processTableViewCell:(Class) cellClass
    bsContentObject:(BSTableContentObject *)bsContentObject{
    NSString *ID = [self.bSTableObjects cellIdentifier];
    NSString *method=@"viewCellWithBSContentObject";
    if (bsContentObject.method==nil) {
        bsContentObject.method=method;
    }
    id cell=[self uiTableViewCellWithIdentifier:ID];
    if (cell==nil) {//没有在NIB或者故事板中定义
        return [self handProcessTableViewCell:cellClass
                     bsContentObject:bsContentObject];
    }
    return [cell viewCellWithBSContentObject:bsContentObject];

}

/**
 *手工处理时，由于没有NIB的绑定，需要手工添加到视图中
 */
-(UITableViewCell *)handProcessTableViewCell:(Class) cellClass
    bsContentObject:(BSTableContentObject *)bsContentObject{
    id cell=[[cellClass alloc]initWithStyle:UITableViewCellStyleDefault
            reuseIdentifier:[self.bSTableObjects cellIdentifier]];
    return [cell viewCellWithHandBSContentObject:bsContentObject];
    
}
/**
 *没有使用故事板和NIB，手工编写TableViewCell
 */

/**
 *根据章节获取每个章节的TellerViewCell
 */
-(NSString *)currentCellIdentifierWithSection:(NSInteger)section{
    return [self.bSTableObjects cellIdentifier];
}

/**
 *私有方法，根据章节获得它的cell标示
 */
-(Class) cellIdentifierWithSection:(NSInteger)section{
    return [self.bSTableObjects cellClass];
}

/**
 *私有方法 根据配置获得UI的实现
 *如果出现异常，则处理异常返回nil
 */
-(id)uiTableViewCellWithIdentifier:(NSString*)identifer
{
    @try {
        return
        [self.tableView dequeueReusableCellWithIdentifier:identifer];
    }
    @catch (NSException *exception) {
        return nil;
    }
    @finally {
        NSLog(@"获取TableViewCell");
    }
    
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
 *每个章节内条目数量
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger rows=[self rowSectionNumber:section];
    NSLog(@"每个章节的Row为%ld",(long)rows);
    return rows;
}

/**
 *选中之前执行,判断选中的行
 */
-(NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"将要处理的行indexpath=%@",indexPath);
    return indexPath;
}

/**
 *调用具体的TableViewCell，包括NIB实现方式、手工编码实现方式、故事板实现方式
 *优先默认为故事板实现
 */
-(void)prepareNavigationView:(NSInteger)section row:(NSInteger)row{
    
    if (([self canUseStoryBord:section row:row])&&
        [self useStoryboard:section row:row]) {
        NSString *vcClassName=[self vcControllerName:section row:row];
        [self prepareControllWithStorybord:vcClassName];
    }else{
        Class clzz=[self vcControlleClass:section row:row];
        [self prepareControllWithNib:clzz];
    }
   
}

/**
 *判断是否配置故事板，如果配置了则返回YES，
 *当前仅仅判断是否在BSTableSection是否有该字段，如果没有则返回NO
 */
-(BOOL)canUseStoryBord:(NSInteger)section row:(NSInteger)row{
    if ([self storyboardName]==nil) {
        return NO;
    }else{
        return YES;
    }
}


/**
 *以手工方式实现的Controller的跳转
 */
-(void)prepareControllWithNib:(Class)clzz{
    
    UIViewController *vc =[[clzz alloc] init];
    
    [self presentViewController:vc animated:NO completion:nil];
}

/**
 *以故事板实现的Controller的跳转
 */
-(void)prepareControllWithStorybord:(NSString *)vcClassName{
    
    UIStoryboard *storyboard = [UIStoryboard
                                storyboardWithName:[self storyboardName] bundle:nil];
    
    UIViewController *goControl = [storyboard instantiateViewControllerWithIdentifier:vcClassName];
    
    UINavigationController* nav = [[UINavigationController alloc]  initWithRootViewController:goControl];
    
    [self presentViewController:nav animated:YES completion:nil];
}

/**
 *是否是使用故事板进行跳转，如果是YES则使用故事板方式跳转，否则使用手工方式
 */
-(BOOL)useStoryboard:(NSInteger)section row:(NSInteger)row{
    
    NSString *vcClassName=[self vcControllerName:section row:row];
    if (vcClassName==nil) {
        return NO;
    }else{
        return YES;
    }
}
/**
 *获取跳转Controller的名称,故事板跳转方式
 */
-(NSString *)vcControllerName:(NSInteger)section row:(NSInteger)row{
    return ((BSTableContentObject *)[self bsContentObject:section row:row]).vcClass;

}

/**
 *获取跳转Controller的类定义,手工编码方式
 */
-(Class)vcControlleClass:(NSInteger)section row:(NSInteger)row{
    return ((BSTableContentObject *)[self bsContentObject:section row:row]).colClass;
}

/**
 *故事板名称,目前方法只是取得BSTableSection中的配置
 */
-(NSString *)storyboardName{
    return self.bSTableObjects.storyboardName;
}

/**
 *章节标题
 */
-(NSString *)titleForHeaderInSection:(NSInteger)section{
    return [self.bSTableObjects.content objectAtIndex:section];
}

/**
 *当前的章节数量
 */
-(NSInteger)currentSectionNumber{
    return [self.bSTableObjects currentSectionNumber];
}

/**
 *每个章节中有多少行
 */
-(NSInteger) rowSectionNumber:(NSInteger)section{
    return [self.bSTableObjects currentRowNumber:section];
}

/**
 *每行现实的数据，它在BSTableSection中定义为现实的数组，此数组按照标题存储，
 *其数据为BSTableContentObject
 */
-(NSObject *) bsContentObject:(NSInteger)section row:(NSInteger)row{
    BSTableSection *bsTable = self.bSTableObjects;
    NSString *sectionTitle = bsTable.sectionTitle;
    NSMutableArray *bsArray= [bsTable sectionData:sectionTitle];
    return[bsArray objectAtIndex:row];
}

-(NSMutableArray *)indexes{
    return self.bSTableObjects.content;
}

@end

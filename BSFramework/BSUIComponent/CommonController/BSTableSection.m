//
//  BSTableObject.m
//  KTAPP
//
//  Created by admin on 15/6/24.
//  Copyright (c) 2015年 KingTeller. All rights reserved.
//

#import "BSTableSection.h"
#import "BSUIFrameworkHeader.h"

@interface BSTableSection()

@property(strong, nonatomic) NSMutableDictionary *sections;

@end

@implementation BSTableSection


@synthesize sectionTitle;
@synthesize headerViewClass;
@synthesize sectionImageName;
@synthesize cellIdentifier;
@synthesize cellClass;

@synthesize colCapatibilty;
@synthesize storyboardName;
@synthesize sections;
@synthesize content;

#pragma mark--故事板实现跳转
+(instancetype) initWithHeaderVcClassContent:(NSString *)header
                                   imageName:(NSString *)imageName
                             headerViewClass:(Class )headerViewClzz//章节View
                                  cellIdentifier:(NSString *)cellIdentifier//表格View
                                   cellClass:(Class)cellClzz//表格实现类
                                  storyboard:(NSString *)storyboard
                                   bsContent:(NSMutableArray *)bsContents{
    return [[super alloc]
            initWithHeaderVcClassContent:header imageName:imageName
            headerViewClass:headerViewClzz cellIdentifier:cellIdentifier
            cellClass:cellClzz  storyboard:storyboard  colCapatibilty:BSTABLE_CONTENT_COLUMN_NUMBER
            bsContentArray:bsContents];
}

+(instancetype) initWithHeaderVcClassContent:(NSString *)header
                                   imageName:(NSString *)imageName
                             headerViewClass:(Class )headerViewClzz//章节View
                                   cellIdentifier:(NSString *)cellIdentifier//表格View
                                   cellClass:(Class)cellClzz//表格实现类
                                  storyboard:(NSString *)storyboard
                              colCapatibilty:(NSInteger)capatbility
                                   bsContent:(NSMutableArray *)bsContents{
    return [[super alloc]
            initWithHeaderVcClassContent:header imageName:imageName
             headerViewClass:headerViewClzz cellIdentifier:cellIdentifier  cellClass:cellClzz
            storyboard:storyboard   colCapatibilty:capatbility
            bsContentArray:bsContents];
}

+(instancetype)initWithHeaderAndContentObject:(NSString *)header
                                    imageName:(NSString *)imageName
                              headerViewClass:(Class )headerViewClzz//章节View
                                    cellIdentifier:(NSString *)cellIdentifier//表格View
                                    cellClass:(Class)cellClzz//表格实现类
                                   storyboard:(NSString *)storyboard
                                        title:(NSString *)title
                                   methodName:(NSString *)methodName
                             contentImageName:(NSString *)contentImageName
                               contentVCClass:(NSString *)contentClzz{
    BSTableContentObject *bs=[BSTableContentObject
                              initWithContentObject:title
                              methodName:methodName
                              imageName:contentImageName
                              vcClass:contentClzz];
    NSMutableArray *bsArray=[NSMutableArray arrayWithObject:bs];
    return [[self alloc] initWithHeaderVcClassContent:header imageName:imageName
                                               headerViewClass:headerViewClzz
                                            cellIdentifier:cellIdentifier
                                            cellClass:cellClzz
                                           storyboard:storyboard
            
                                       colCapatibilty:BSTABLE_CONTENT_COLUMN_NUMBER
                                       bsContentArray:bsArray];
    
}


+(instancetype)initWithHeaderAndContentObject:(NSString *)header
                                    imageName:(NSString *)imageName
                              headerViewClass:(Class )headerViewClzz//章节View
                                  cellIdentifier:(NSString *)cellIdentifier//表格View
                                    cellClass:(Class)cellClzz//表格实现类
                                   storyboard:(NSString *)storyboard
                               colCapatibilty:(NSInteger)capatbility
                                        title:(NSString *)title
                                   methodName:(NSString *)methodName
                                    contentImageName:(NSString *)contentImageName
                                      contentVCClass:(NSString *)contentClzz{
    BSTableContentObject *bs=[BSTableContentObject
                              initWithContentObject:title
                              methodName:methodName
                              imageName:contentImageName
                              vcClass:contentClzz];
    NSMutableArray *bsArray=[NSMutableArray arrayWithObject:bs];
    return [[self alloc] initWithHeaderVcClassContent:header imageName:imageName
                                               headerViewClass:headerViewClzz
                                            cellIdentifier:cellIdentifier
                                            cellClass:cellClzz
                                           storyboard:storyboard
            
                                       colCapatibilty:capatbility
                                       bsContentArray:bsArray];

}

#pragma mark--手工编码
/**
 *初始化一个TableSection，每行的具体内容由bsContent数组提供
 */
+(instancetype) initWithHeaderVcClassContent:(NSString *)header
                                   imageName:(NSString *)imageName
                             headerViewClass:(Class )headerViewClzz//章节View
                                   cellIdentifier:(NSString *)cellIdentifier//表格View
                                   cellClass:(Class)cellClzz//表格实现类
                              colCapatibilty:(NSInteger)capatbility
                                   bsContent:(NSMutableArray *)bsContents{
    return [[super alloc]
            initWithHeaderVcClassContent:header imageName:imageName
            headerViewClass:headerViewClzz
            cellIdentifier:cellIdentifier cellClass:cellClzz  storyboard:nil
            colCapatibilty:BSTABLE_CONTENT_COLUMN_NUMBER
            bsContentArray:bsContents];
}

/**
 *初始化，初始化时每一章节有一行数据，默认每行的列数colCapatibilty为系统提供的默认值，
 *由BSTABLE_CONTENT_COLUMN_NUMBER
 */
+(instancetype) initWithHeaderVcClassContent:(NSString *)header
                                   imageName:(NSString *)imageName
                             headerViewClass:(Class )headerViewClzz//章节View
                                     bsContent:(NSMutableArray *)bsContents{
    return [[super alloc]
            initWithHeaderVcClassContent:header imageName:imageName
            headerViewClass:headerViewClzz cellIdentifier:nil cellClass:nil
            storyboard:nil   colCapatibilty:BSTABLE_CONTENT_COLUMN_NUMBER
            bsContentArray:bsContents];
    
}

+(instancetype) initWithHeaderVcClassContent:(NSString *)header
                                   imageName:(NSString *)imageName
                             headerViewClass:(Class )headerViewClzz//章节View
                             cellIdentifier:(NSString * )cellIdentifier//表格View
                                   cellClass:(Class)cellClzz//表格实现类
                                   bsContent:(NSMutableArray *)bsContents{
    return [[super alloc]
            initWithHeaderVcClassContent:header imageName:imageName
            headerViewClass:headerViewClzz cellIdentifier:cellIdentifier
            cellClass:cellClzz
            storyboard:nil   colCapatibilty:BSTABLE_CONTENT_COLUMN_NUMBER
            bsContentArray:bsContents];
}

/**
 *初始化一个TableSection，每行的具体内容由bsContent数组提供
 */
+(instancetype)initWithHeaderAndContentObject:(NSString *)header
                                    imageName:(NSString *)imageName
                              headerViewClass:(Class )headerViewClzz//章节View
                                   cellIdentifier:(NSString *)cellIdentifier//表格View
                                    cellClass:(Class)cellClzz//表格实现类
                               colCapatibilty:(NSInteger)capatbility
                                        title:(NSString *)title
                                   methodName:(NSString *)methodName
                             contentImageName:(NSString *)contentImageName
                               contentVCClass:(NSString *)contentClzz{
    
    BSTableContentObject *bs=[BSTableContentObject
                              initWithContentObject:title
                              methodName:methodName
                              imageName:contentImageName
                              vcClass:contentClzz];
    NSMutableArray *bsArray=[NSMutableArray arrayWithObject:bs];
    return [[self alloc] initWithHeaderVcClassContent:header imageName:imageName
                                               headerViewClass:headerViewClzz
                                            cellIdentifier:cellIdentifier
                                            cellClass:cellClzz
                                           storyboard:nil
            
                                       colCapatibilty:capatbility
                                       bsContentArray:bsArray];
    
    }

/**
 *初始化，初始化时每一章节有一行数据，默认每行的列数colCapatibilty为系统提供的默认值，
 *由BSTABLE_CONTENT_COLUMN_NUMBER
 *
 */
+(instancetype)initWithHeaderAndContentObject:(NSString *)header
                                    imageName:(NSString *)imageName
                              headerViewClass:(Class )headerViewClzz//章节View
                                    cellIdentifier:(NSString *)cellIdentifier//表格View
                                    cellClass:(Class)cellClzz//表格实现类
                                        title:(NSString *)title
                                   methodName:(NSString *)methodName
                             contentImageName:(NSString *)contentImageName
                               contentVCClass:(NSString *)contentClzz{
    BSTableContentObject *bs=[BSTableContentObject
                              initWithContentObject:title
                              methodName:methodName
                              imageName:contentImageName
                              vcClass:contentClzz];
    NSMutableArray *bsArray=[NSMutableArray arrayWithObject:bs];
    return [[self alloc] initWithHeaderVcClassContent:header imageName:imageName
                                      headerViewClass:headerViewClzz
                                            cellIdentifier:cellIdentifier
                                            cellClass:cellClzz
                                           storyboard:nil
                                       colCapatibilty:BSTABLE_CONTENT_COLUMN_NUMBER
                                       bsContentArray:bsArray];
    
}



-(instancetype)initWithHeaderVcClassContent: (NSString *)tableHeader
                                  imageName:(NSString *)imageName
                            headerViewClass:(Class )headerViewClzz//章节View
                                  cellIdentifier:(NSString *)cIdentifier//表格View
                                  cellClass:(Class)cellClzz//表格实现类
                                 storyboard:(NSString *)storyboard
                             colCapatibilty:(NSInteger)capatbility
                             bsContentArray:(NSMutableArray *)bsContents{
    self = [super init];
    if (!self) {
        return nil;
    }
    self.sectionTitle=tableHeader;

    self.sectionImageName=imageName;
    
    self.storyboardName=storyboard;

    self.headerViewClass=headerViewClzz;
    self.cellIdentifier=cIdentifier;
    self.cellClass=cellClzz;
    //每行的列数最小值应当比一大
    if (capatbility<1) {
        self.colCapatibilty= BSTABLE_CONTENT_COLUMN_NUMBER;
    }else{
        self.colCapatibilty= capatbility;
    }
    if (self.content==nil) {
        self.content=[NSMutableArray array];
    }
    if (self.sections==nil) {
        self.sections=[NSMutableDictionary dictionary];
    }
    [self.content addObject:tableHeader];
    [self sectionArray:tableHeader bsContents:bsContents];
    return self;
}

/**
 *
 */
-(void) sectionArray:(NSString *)tableHeader bsContents:(NSMutableArray *)bsContents{
    NSMutableArray *arrays=[sections objectForKey:tableHeader];
    if (arrays==nil) {
        arrays=[NSMutableArray arrayWithArray:bsContents];
    }else{
        [arrays addObjectsFromArray:bsContents];
    }
    [sections setObject:arrays forKey:tableHeader];
}


-(void)addBSTableContent:(BSTableContentObject *)bsContent sectionHeader:(NSString *)sectionHeader{
    NSMutableArray *bsTableRows=[self.sections objectForKey:sectionHeader];
    if (bsTableRows==nil) {
        bsTableRows=[NSMutableArray arrayWithObject:bsContent];
        [self.content addObject:sectionHeader];
    }else{
        [bsTableRows addObject:bsContent];
    }
    [self.sections setObject:bsTableRows forKey:sectionHeader];
    
}

#pragma mark --获取数据逻辑
/*
 *根据章节标题获取每个章节的数据
 */
-(NSMutableArray *) sectionData:(NSString *)title{
    return [self.sections objectForKey:title];
}

/**
 *当前章节共计几行数据
 */
-(NSInteger) currentRowNumber:(NSInteger)section{
    NSString *title=[self currentSectionTitle:section];
    NSMutableArray *arrays=[self.sections objectForKey:title];
    long realSize=[arrays count];
    if (self.colCapatibilty==1) {//如果一行中列的容量为一，则返回数据数组
        return realSize;
    }
    long cap=realSize/self.colCapatibilty;
    if (cap==0) {
        return 1;//不够满一列，则返回是一列
    }
    long remainder=realSize%self.colCapatibilty;
    //每行至少有一列数据,//当有不是一满列时，应当增加一行
    if (remainder!=0) {
        ++cap;
    }
    return cap;
}

/*
 *当前表格共有章节数量
 */
-(NSInteger) currentSectionNumber{
    return [self.content count];
}

/*
 *根据章节获取当前章节标题
 */
-(NSString *)currentSectionTitle:(NSInteger)section{
    return [self.content objectAtIndex:section];
}

-(NSInteger)currentCapatibilty:(NSInteger)section{
    return self.colCapatibilty;
}

/**
 *每行现实的数据，它在BSTableSection中定义为现实的数组，此数组按照标题存储，
 *其数据为BSTableContentObject
 */
-(BSTableContentObject *) currentContentObject:(NSInteger)section row:(NSInteger)row{
    @try {
       
        NSString *title = [self currentSectionTitle:section];
        NSMutableArray *bsArray= [self sectionData:title];
        return[bsArray objectAtIndex:row];
     }
    @catch (NSException *exception) {
        NSLog(@"BSUITableViewInitRuntimeController bsContentObject每行现实的数据，它在BSTableSection，出现错误，\t\%@",exception.reason);
    }
    
}


/**
 *每行显示多个元素时，根据章节和行数获取实际的数据
 *因为每行的容量不是一，此处传入的row是colCapatibilty的倍数
 */
-(NSMutableArray*) currentContentArray:(NSInteger)section row:(NSInteger)row{
    
    NSString *title=[self currentSectionTitle:section];
    NSMutableArray *arrays=[self.sections objectForKey:title];
    //不满一行
    long realSize=[arrays count];
    //算得需要执行本方法的位置
    long rangeFirst=colCapatibilty*(row);
    long rangeLast=colCapatibilty*(row+1);
    if(rangeLast>realSize){
        rangeLast=realSize;
    }
    NSMutableArray *capArray=[[NSMutableArray alloc]init];
    long capPos=0;
    BSTableContentObject *bo=nil;
    for (capPos=rangeFirst; capPos<rangeLast; capPos++) {
        bo=(BSTableContentObject *)[arrays objectAtIndex:capPos];
        //列容量
        if (bo.colCapatibilty==0) {
            bo.colCapatibilty=self.colCapatibilty;
        }
        if (bo.canUseStoryboard==NO) {
            bo.canUseStoryboard=[self canUseStoryBord:section row:capPos];
        }
        if (bo.storybordName==nil) {
            bo.storybordName=self.storyboardName;
        }
        [capArray addObject:bo];
    }
    return capArray;
}

/**
 *判断是否配置故事板，如果配置了则返回YES，
 *当前仅仅判断是否在BSTableSection是否有该字段，如果没有则返回NO
 */
-(BOOL)canUseStoryBord:(NSInteger)section row:(NSInteger)row{
    return (([self storyboardName])&&([self useStoryboard:section row:row]));
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
    return ((BSTableContentObject *)[self currentContentObject:section row:row]).vcClass;
    
}

/**
 *获取跳转Controller的类定义,手工编码方式
 */
-(Class)vcControlleClass:(NSInteger)section row:(NSInteger)row{
    return ((BSTableContentObject *)[self currentContentObject:section row:row]).colClass;
}


-(NSString *)description{//description
    return [NSString stringWithFormat:@"表格数据章节信息\t header:%@\timageName:%@\t单元格数据%lu",
            self.sectionTitle,self.sectionImageName, (unsigned long)[self.content count]];
}
@end

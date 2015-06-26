//
//  BSTableObject.m
//  KTAPP
//
//  Created by admin on 15/6/24.
//  Copyright (c) 2015年 itcast. All rights reserved.
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

/*
 *根据章节标题获取每个章节的数据
 */
-(NSMutableArray *) sectionData:(NSString *)title{
    return [self.sections objectForKey:title];
}

-(NSInteger) currentRowNumber:(NSInteger)section{
    NSString *title=[self.content objectAtIndex:section];
    NSMutableArray *arrays=[self.sections objectForKey:title];
    long cap=[arrays count]/colCapatibilty;
    //每行至少有一列数据
    if (cap<1) {
        cap=1;
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

/**
 *判断是否是故事板实现
 */
-(BOOL)useStorybord{
    return YES;
}


-(NSString *)description{//description
    return [NSString stringWithFormat:@"表格数据章节信息\t header:%@\timageName:%@\t单元格数据%lu",
            self.sectionTitle,self.sectionImageName, (unsigned long)[self.content count]];
}
@end

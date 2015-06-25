//
//  BSTableObject.m
//  KTAPP
//
//  Created by admin on 15/6/24.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "BSTableSection.h"
#import "BSTableContentObject.h"
#import "Conf.h"

@interface BSTableSection()

@property(strong, nonatomic) NSMutableDictionary *sections;

@end

@implementation BSTableSection


@synthesize sectionTitle;
@synthesize vcClass;
@synthesize headerImageName;
@synthesize colCapatibilty;
@synthesize storyboardName;
@synthesize sections;
@synthesize content;

/*
-(NSMutableArray *)content{
    if (_content==nil) {
        _content=[[NSMutableArray alloc]init];
    }
    return _content;
}
*/

+(instancetype) initWithHeaderVcClassContent:(NSString *)header
                                   imageName:(NSString *)imageName
                                     vcClass:(NSString *)vcClass
                                  storyboard:(NSString *)storyboard
                                   bsContent:(NSMutableArray *)bsContents{
    return [[super alloc]
            initWithHeaderVcClassContent:header imageName:imageName
            vcClass:vcClass storyboard:storyboard colCapatibilty:BSTABLE_CONTENT_COLUMN_NUMBER
            bsContentArray:bsContents];
}

+(instancetype) initWithHeaderVcClassContent:(NSString *)header
                                   imageName:(NSString *)imageName
                                     vcClass:(NSString *)vcClass
                                  storyboard:(NSString *)storyboard
                              colCapatibilty:(NSInteger)capatbility
                                   bsContent:(NSMutableArray *)bsContents{
    return [[super alloc]
            initWithHeaderVcClassContent:header imageName:imageName
            vcClass:vcClass storyboard:storyboard colCapatibilty:capatbility
            bsContentArray:bsContents];
}

+(instancetype)initWithHeaderAndContentObject:(NSString *)header
                                    imageName:(NSString *)imageName
                                      vcClass:(NSString *)vcClass
                                   storyboard:(NSString *)storyboard
                                      bsContent:(NSMutableArray *)bsContents
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
                                              vcClass:vcClass storyboard:storyboard
                                       colCapatibilty:BSTABLE_CONTENT_COLUMN_NUMBER
                                       bsContentArray:bsArray];
    
}


+(instancetype)initWithHeaderAndContentObject:(NSString *)header
                                    imageName:(NSString *)imageName
                                      vcClass:(NSString *)vcClass
                                   storyboard:(NSString *)storyboard
                               colCapatibilty:(NSInteger)capatbility
                                    bsContent:(NSMutableArray *)bsContents
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
                                              vcClass:vcClass storyboard:storyboard
                                       colCapatibilty:capatbility
                                       bsContentArray:bsArray];

}

-(instancetype)initWithHeaderVcClassContent: (NSString *)tableHeader
                                  imageName:(NSString *)imageName
                                    vcClass:(NSString *)contentClass
                                 storyboard:(NSString *)storyboard
                             colCapatibilty:(NSInteger)capatbility
                             bsContentArray:(NSMutableArray *)bsContents{
    self = [super init];
    if (!self) {
        return nil;
    }
    self.sectionTitle=tableHeader;

    self.headerImageName=imageName;
    self.storyboardName=storyboard;
    if (capatbility>BSTABLE_CONTENT_COLUMN_NUMBER) {
        self.colCapatibilty= capatbility;
    }

    self.vcClass=contentClass;
       if (self.content==nil) {
        self.content=[NSMutableArray array];
    }
    if (self.sections==nil) {
        self.sections=[NSMutableDictionary dictionary];
    }
    /*
    BSTableRow *row=[BSTableRow initWithContentArray:bsContents];
    if (row) {
        [self.content addObject:row];
    }
    */
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
    return [arrays count];
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

-(NSString *)description{//description
    return [NSString stringWithFormat:@"表格数据章节信息\t header:%@\timageName:%@\t单元格数据%lu",
            self.sectionTitle,self.headerImageName, (unsigned long)[self.content count]];
}
@end

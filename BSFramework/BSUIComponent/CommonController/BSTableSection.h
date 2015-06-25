//
//  BSTableObject.h
//  KTAPP
//  运行加载表格数据，表示类，它包括一个标题，多个内容
//  Created by admin on 15/6/24.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BSTableContentObject.h"


@interface BSTableSection : NSObject

    @property (copy, nonatomic) NSString *sectionTitle;
    @property (copy, nonatomic) NSString *headerImageName;
    /**
     *每章节数据的大小，实际包括章节，它在表格中，为数组
     */
    @property (strong, nonatomic) NSMutableArray *content;
    @property (assign, nonatomic) NSInteger colCapatibilty;
    @property (assign, nonatomic) NSString *selectionKey;
    @property (assign, nonatomic) NSString *vcClass;
    @property (assign, nonatomic) NSString *storyboardName;

/**
 *初始化，初始化时每一章节有一行数据
 */
+(instancetype) initWithHeaderVcClassContent:(NSString *)header
                                   imageName:(NSString *)imageName
                                     vcClass:(NSString *)vcClass
                                  storyboard:(NSString *)storyboard
                              colCapatibilty:(NSInteger)capatbility
                                   bsContent:(NSMutableArray *)bsContents;

+(instancetype) initWithHeaderVcClassContent:(NSString *)header
                                   imageName:(NSString *)imageName
                                     vcClass:(NSString *)vcClass
                                  storyboard:(NSString *)storyboard
                                   bsContent:(NSMutableArray *)bsContents;

+(instancetype)initWithHeaderAndContentObject:(NSString *)header
                                    imageName:(NSString *)imageName
                                      vcClass:(Class)vcClass
                                   storyboard:(NSString *)storyboard
                               colCapatibilty:(NSInteger)capatbility
                                    bsContent:(NSMutableArray *)bsContents
                                        title:(NSString *)title
                                   methodName:(NSString *)methodName
                             contentImageName:(NSString *)contentImageName
                               contentVCClass:(NSString *)contentClzz;

+(instancetype)initWithHeaderAndContentObject:(NSString *)header
                                    imageName:(NSString *)imageName
                                      vcClass:(Class)vcClass
                                   storyboard:(NSString *)storyboard
                                    bsContent:(NSMutableArray *)bsContents
                                        title:(NSString *)title
                                   methodName:(NSString *)methodName
                             contentImageName:(NSString *)contentImageName
                               contentVCClass:(NSString *)contentClzz;


-(void)addBSTableContent:(BSTableContentObject *)bsContent sectionHeader:(NSString *)sectionHeader;

/*
 *根据章节标题获取每个章节的数据
 */
-(NSMutableArray *) sectionData:(NSString *)title;

/*
 *根据章节标题获取每个章节的总列数
 */
-(NSInteger) currentRowNumber:(NSInteger)section;

/*
 *当前表格共有章节数量
 */
-(NSInteger) currentSectionNumber;

/*
 *根据章节获取当前章节标题
 */
-(NSString *)currentSectionTitle:(NSInteger)section;


@end


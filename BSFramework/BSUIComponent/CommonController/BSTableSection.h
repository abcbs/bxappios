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

    /**
     *章节标题
     */
    @property (copy, nonatomic) NSString *sectionTitle;
    /**
     *章节图标名称
     */
    @property (copy, nonatomic) NSString *sectionImageName;
    /**
     *每章节数据的大小，实际包括章节的名字
     */
    @property (strong, nonatomic) NSMutableArray *content;
    /**
     *每行显示的列数
     */
    @property (assign, nonatomic) NSInteger colCapatibilty;
    /**
     *章节排序的Key，目前没有启用，使用章节标题作为区分
     */
    @property (assign, nonatomic) NSString *selectionKey;
    /**
     *UITableViewCell名称
     */
    @property (assign, nonatomic) Class cellClass;
    /**
     *标题的View
     */
    @property (assign, nonatomic) Class headerViewClass;

    /*
     *使用故事板时，故事板的名称，默认为故事板实现
     */
    @property (assign, nonatomic) NSString *storyboardName;

#pragma mark--以下是使用故事板作为跳转时采用的方法，提供的是故事板和视图名称
/**
 *初始化一个TableSection，每行的具体内容由bsContent数组提供
 */
+(instancetype) initWithHeaderVcClassContent:(NSString *)header//章节标题
                                   imageName:(NSString *)imageName//章节图标
                             headerViewClass:(Class )headerViewClzz//章节View
                                   cellClass:(Class )cellClass//表格View
                                  storyboard:(NSString *)storyboard
                              colCapatibilty:(NSInteger)capatbility
                                   bsContent:(NSMutableArray *)bsContents;

/**
 *初始化，初始化时每一章节有一行数据，默认每行的列数colCapatibilty为系统提供的默认值，
 *由BSTABLE_CONTENT_COLUMN_NUMBER
 */
+(instancetype) initWithHeaderVcClassContent:(NSString *)header
                                   imageName:(NSString *)imageName
                             headerViewClass:(Class )headerViewClzz//章节View
                                   cellClass:(Class )cellClass//表格View
                                  storyboard:(NSString *)storyboard
                                   bsContent:(NSMutableArray *)bsContents;

/**
 *初始化一个TableSection，每行的具体内容由bsContent数组提供
 */
+(instancetype)initWithHeaderAndContentObject:(NSString *)header
                                    imageName:(NSString *)imageName
                              headerViewClass:(Class )headerViewClzz//章节View
                                    cellClass:(Class )cellClass//表格View
                                   storyboard:(NSString *)storyboard
                               colCapatibilty:(NSInteger)capatbility
                                        title:(NSString *)title
                                   methodName:(NSString *)methodName
                             contentImageName:(NSString *)contentImageName
                               contentVCClass:(NSString *)contentClzz;

/**
 *初始化，初始化时每一章节有一行数据，默认每行的列数colCapatibilty为系统提供的默认值，
 *由BSTABLE_CONTENT_COLUMN_NUMBER
 *
 */
+(instancetype)initWithHeaderAndContentObject:(NSString *)header
                                    imageName:(NSString *)imageName
                              headerViewClass:(Class )headerViewClzz//章节View
                                    cellClass:(Class )cellClass//表格View
                                   storyboard:(NSString *)storyboard
                                        title:(NSString *)title
                                   methodName:(NSString *)methodName
                             contentImageName:(NSString *)contentImageName
                               contentVCClass:(NSString *)contentClzz;


#pragma mark--以下是使用手工编码nib作为跳转时采用的方法，提供类名
/**
 *初始化一个TableSection，每行的具体内容由bsContent数组提供
 */
+(instancetype) initWithHeaderVcClassContent:(NSString *)header
                                   imageName:(NSString *)imageName
                             headerViewClass:(Class )headerViewClzz//章节View
                                   cellClass:(Class )cellClass//表格View
                              colCapatibilty:(NSInteger)capatbility
                                   bsContent:(NSMutableArray *)bsContents;

/**
 *初始化，初始化时每一章节有一行数据，默认每行的列数colCapatibilty为系统提供的默认值，
 *由BSTABLE_CONTENT_COLUMN_NUMBER
 */
+(instancetype) initWithHeaderVcClassContent:(NSString *)header
                                   imageName:(NSString *)imageName
                             headerViewClass:(Class )headerViewClzz//章节View
                                   cellClass:(Class )cellClass//表格View
                                    bsContent:(NSMutableArray *)bsContents;

/**
 *初始化一个TableSection，每行的具体内容由bsContent数组提供
 */
+(instancetype)initWithHeaderAndContentObject:(NSString *)header
                                    imageName:(NSString *)imageName
                              headerViewClass:(Class )headerViewClzz//章节View
                                    cellClass:(Class )cellClass//表格View
                               colCapatibilty:(NSInteger)capatbility
                                        title:(NSString *)title
                                   methodName:(NSString *)methodName
                             contentImageName:(NSString *)contentImageName
                               contentVCClass:(NSString *)contentClzz;

/**
 *初始化，初始化时每一章节有一行数据，默认每行的列数colCapatibilty为系统提供的默认值，
 *由BSTABLE_CONTENT_COLUMN_NUMBER
 *
 */
+(instancetype)initWithHeaderAndContentObject:(NSString *)header
                                    imageName:(NSString *)imageName
                              headerViewClass:(Class )headerViewClzz//章节View
                                    cellClass:(Class )cellClass//表格View
                                        title:(NSString *)title
                                   methodName:(NSString *)methodName
                             contentImageName:(NSString *)contentImageName
                               contentVCClass:(NSString *)contentClzz;


#pragma mark--以下是添加表格列数据的实现，手工编码和故事板实现两种方式，区分为提供名称和类名使用了不同的重载
-(void)addBSTableContent:(BSTableContentObject *)bsContent sectionHeader:(NSString *)sectionHeader;

#pragma mark--以下是获取配置信息的一般方法

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

/**
 *判断是故事板实现还是手工编码实现
 */
-(BOOL)useStorybord;

@end


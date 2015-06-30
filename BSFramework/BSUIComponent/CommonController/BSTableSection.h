//
//  BSTableObject.h
//  KTAPP
//  运行加载表格数据，表示类，它包括一个标题，多个内容
//  Created by admin on 15/6/24.
//  Copyright (c) 2015年 KingTeller. All rights reserved.
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
     *UITableViewCell名称，在故事板中为表示，在NIB为实现
     */
    @property (assign, nonatomic) NSString *cellIdentifier;
    /**
    *UITableViewCell名称，在故事板中为表示，在NIB为实现
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
                                   cellIdentifier:(NSString *)cellIdentifier//表格View
                                   cellClass:(Class)cellClzz//表格实现类
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
                                   cellIdentifier:(NSString *)cellIdentifier//表格View
                                   cellClass:(Class)cellClzz//表格实现类
                                  storyboard:(NSString *)storyboard
                                   bsContent:(NSMutableArray *)bsContents;

/**
 *初始化一个TableSection，每行的具体内容由bsContent数组提供
 */
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
                               contentVCClass:(NSString *)contentClzz;

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
                                  cellIdentifier:(NSString *)cellIdentifier//表格View
                                   cellClass:(Class)cellClzz//表格实现类
                              colCapatibilty:(NSInteger)capatbility
                                   bsContent:(NSMutableArray *)bsContents;

/**
 *初始化，初始化时每一章节有一行数据，默认每行的列数colCapatibilty为系统提供的默认值，
 *由BSTABLE_CONTENT_COLUMN_NUMBER
 */
+(instancetype) initWithHeaderVcClassContent:(NSString *)header
                                   imageName:(NSString *)imageName
                             headerViewClass:(Class )headerViewClzz//章节View
                                   cellIdentifier:(NSString * )cellIdentifier//表格View
                                   cellClass:(Class)cellClzz//表格实现类
                                    bsContent:(NSMutableArray *)bsContents;

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
                               contentVCClass:(NSString *)contentClzz;

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
                               contentVCClass:(NSString *)contentClzz;


#pragma mark--以下是添加表格列数据的实现，手工编码和故事板实现两种方式，区分为提供名称和类名使用了不同的重载
-(void)addBSTableContent:(BSTableContentObject *)bsContent sectionHeader:(NSString *)sectionHeader;

#pragma mark--以下是获取配置信息的一般方法

/**
 *获取指定章节索引具体章节中得某行数据
 */
-(BSTableContentObject *) currentContentObject:(NSInteger)section row:(NSInteger)row;
/*
 *根据章节标题获取每个章节的数据
 */
-(NSMutableArray *) sectionData:(NSString *)title;

/*
 *根据章节标题获取每个章节的总行数
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
 *判断是否配置故事板，如果配置了则返回YES，
 *当前仅仅判断是否在BSTableSection是否有该字段，如果没有则返回NO
 */
-(BOOL)canUseStoryBord:(NSInteger)section row:(NSInteger)row;

/**
 *是否是使用故事板进行跳转，如果是YES则使用故事板方式跳转，否则使用手工方式
 */
-(BOOL)useStoryboard:(NSInteger)section row:(NSInteger)row;

/**
 *获取跳转Controller的名称,故事板跳转方式
 */
-(NSString *)vcControllerName:(NSInteger)section row:(NSInteger)row;

/**
 *获取跳转Controller的类定义,手工编码方式
 */
-(Class)vcControlleClass:(NSInteger)section row:(NSInteger)row;

/**
 *判断是故事板实现还是手工编码实现
 */
-(BOOL)useStorybord;

/**
 *根据章节section获取本章节的规定的列数，
 *也就是当前章节的colCapatibilty
 */
-(NSInteger)currentCapatibilty:(NSInteger)section;

@end


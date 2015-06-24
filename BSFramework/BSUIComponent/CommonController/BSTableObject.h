//
//  BSTableObject.h
//  KTAPP
//  运行加载表格数据，表示类，它包括一个标题，多个内容
//  Created by admin on 15/6/24.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BSTableContentObject.h"


@interface BSTableObject : NSObject

    @property (copy, nonatomic) NSString *header;
    @property (copy, nonatomic) NSString *headerImageName;
    @property (strong, nonatomic) NSMutableArray *content;
    @property (assign, nonatomic) Class vcClass;

/**
 *初始化
 */
+(instancetype) initWithHeaderVcClassContent:(NSString *)header
                                   imageName:(NSString *)imageName                                     vcClass:(Class)vcClass
                                   bsContent:(NSMutableArray *)bsContents;


-(void)addBSTableContent:(BSTableContentObject *)bsContent;

@end


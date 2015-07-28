//
//  BSPhotoTakeCollectionController.h
//  KTAPP
//
//  Created by admin on 15/7/27.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "BSUITableViewInitRuntimeController.h"

@interface BSPhotoTakeCollectionController : BSUIContentViewController

@property (nonatomic, assign) BOOL bsAllowsMultipleSelection;
@property (nonatomic, assign) NSUInteger minimumNumberOfSelection;
@property (nonatomic, assign) NSUInteger maximumNumberOfSelection;
@property (nonatomic, strong) NSMutableOrderedSet *selectedAssets;
@end

//
//  MyPOIAnnotation.h
//  KTAPP
//
//  Created by admin on 15/9/18.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "POIAnnotation.h"

@interface MyPOIAnnotation : POIAnnotation

@property (nonatomic, strong) POIAnnotation *poinnotation;

- (id)initWithPOIAnnotation:(POIAnnotation *)poinnotation;

@end

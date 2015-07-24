//
//  YYHModelSerialization.h
//  Ampersand
//
//  Copyright (c) 2015年 KT. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol YYHModelSerialization <NSObject>

- (id)modelsForJSONArray:(NSArray *)jsonArray modelClass:(Class)modelClass error:(NSError **)error;

- (id)modelForJSONDictionary:(NSDictionary *)jsonDictionary modelClass:(Class)modelClass error:(NSError **)error;

- (id)objectArrayWithKeyValuesArray:(NSArray *)jsonArray
                         modelClass:(Class)modelClass;

-(id)objectWithKeyValue:(NSObject *)responseObject
             modelClass:(Class)modelClass;

@end

//
//  ClassForSelectors.m
//  KTAPP
//
//  Created by admin on 15/6/29.
//  Copyright (c) 2015年 KT. All rights reserved.
//

#import "ClassForSelectors.h"



@implementation ClassForSelectors

- (void) fooNoInputs {
    NSLog(@"Does nothing");
}
- (void) fooOneIput:(NSString*) first {
    NSLog(@"Logs %@", first);
}
- (void) fooFirstInput:(NSString*) first secondInput:(NSString*) second {
    NSLog(@"Logs %@ then %@", first, second);
}

- (NSArray *)abcWithAAA: (NSNumber *)number {
    int primaryKey = [number intValue];
    NSLog(@"%i", primaryKey);
    return nil;
}

- (void) performMethodsViaSelectors {
    [self performSelector:@selector(fooNoInputs)];
    [self performSelector:@selector(fooOneIput:) withObject:@"first"];
    [self performSelector:@selector(fooFirstInput:secondInput:) withObject:@"first" withObject:@"second"];
}

@end


//
//  NSArray+DeepCopy.m
//  cigarette
//
//  Created by by.huang on 2019/9/18.
//  Copyright © 2019 by.huang. All rights reserved.
//

#import "NSArray+DeepCopy.h"

@implementation NSArray(DeepCopy)

- (instancetype)deepCopy {
    NSMutableArray *mutableResultArray = [[NSMutableArray alloc] initWithCapacity:[self count]];
    for (id subObject in self) {
        id deepCopySubObject = nil;
        if ([subObject respondsToSelector:@selector(deepCopy)]) {
            deepCopySubObject = [subObject deepCopy];
        } else if ([subObject isKindOfClass:[NSMutableArray class]] || [subObject isKindOfClass:[NSMutableSet class]] || [subObject isKindOfClass:[NSMutableDictionary class]]) {
            deepCopySubObject = [subObject mutableCopy];
        } else if ([subObject conformsToProtocol:@protocol(NSCopying)]) {
            deepCopySubObject = [subObject copy];
        } else {
            deepCopySubObject = subObject;
        }
        
        if (deepCopySubObject) {
            [mutableResultArray addObject:deepCopySubObject];
        } else {
            [mutableResultArray addObject:subObject];
        }
    }
    
    if ([self isKindOfClass:[NSMutableArray class]]) {
        return mutableResultArray;
    } else {
        return [NSArray arrayWithArray:mutableResultArray];
    }
}

@end

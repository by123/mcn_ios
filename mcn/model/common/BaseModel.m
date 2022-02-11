//
//  BaseModel.m
//  cigarette
//
//  Created by xiao ming on 2019/12/1.
//  Copyright © 2019 by.huang. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel

-(instancetype)init{
    if(self == [super init]){
        _requestPage = 1;
        _headerRefresh = true;
    }
    return self;
}

- (id)mj_newValueFromOldValue:(id)oldValue property:(MJProperty *)property{
    if ([property.type.code isEqualToString:@"NSString"] && [self isEmpty:oldValue]) {
        return @"";
    }
    return oldValue;
}

- (BOOL)isEmpty:(NSString*)value {
    if ([value isEqual:[NSNull null]]) {
        return YES;
    }
    else if ([value isKindOfClass:[NSNull class]])
    {
        return YES;
    }
    else if (value == nil){
        return YES;
    }
    return NO;
}

@end

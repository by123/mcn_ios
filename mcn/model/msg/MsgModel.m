//
//  MsgModel.m
//  mcn
//
//  Created by by.huang on 2020/8/21.
//  Copyright © 2020 by.huang. All rights reserved.
//

#import "MsgModel.h"

@implementation MsgModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"msgId": @"id"};
}

@end

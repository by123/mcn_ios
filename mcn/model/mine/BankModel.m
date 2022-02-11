
//
//  BankModel.m
//  mcn
//
//  Created by by.huang on 2020/9/3.
//  Copyright © 2020 by.huang. All rights reserved.
//

#import "BankModel.h"

@implementation BankModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"bid": @"id"};
}

@end

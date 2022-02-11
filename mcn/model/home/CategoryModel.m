//
//  CategoryModel.m
//  mcn
//
//  Created by by.huang on 2020/8/30.
//  Copyright © 2020 by.huang. All rights reserved.
//

#import "CategoryModel.h"

@implementation CategoryModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"categoryId": @"id"};
}

@end

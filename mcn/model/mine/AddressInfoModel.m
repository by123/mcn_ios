//
//  AddressInfoModel.m
//  mcn
//
//  Created by by.huang on 2020/8/30.
//  Copyright © 2020 by.huang. All rights reserved.
//

#import "AddressInfoModel.h"

@implementation AddressInfoModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"addressId": @"id"};
}

@end

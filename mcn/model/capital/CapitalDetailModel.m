//
//  CapitalDetailModel.m
//  mcn
//
//  Created by by.huang on 2020/9/10.
//  Copyright © 2020 by.huang. All rights reserved.
//

#import "CapitalDetailModel.h"

@implementation CapitalDetailModel

+(double)getMoney:(MoneyType)type detailJson:(NSString *)detailJson{
    NSMutableDictionary *dic = [STConvertUtil jsonToDic:detailJson];
    NSString *money = dic[LongStr(type)];
    return [money doubleValue];
}
@end

//
//  PartnerModel.m
//  mcn
//
//  Created by by.huang on 2020/9/6.
//  Copyright © 2020 by.huang. All rights reserved.
//

#import "PartnerModel.h"

@implementation PartnerModel


-(NSMutableArray *)skuModels{
    NSMutableArray *skuModels = [ProductModel mj_objectArrayWithKeyValuesArray:_skus];
    return skuModels;
}

+(NSString *)getStatuStr:(PartnerType)type{
    switch (type) {
        case PartnerType_Cancel:
            return @"已取消";
        case PartnerType_WaitSend:
            return @"待发货";
        case PartnerType_WaitConfirm:
            return @"待确认";
        case PartnerType_Cooperative:
            return @"已合作";
        case PartnerType_Close:
            return @"已关闭";
            break;
        default:
            break;
    }
    return MSG_EMPTY;;
}
@end

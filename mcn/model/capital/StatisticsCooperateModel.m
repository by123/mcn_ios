//
//  StatisticsCooperateModel.m
//  mcn
//
//  Created by by.huang on 2020/9/11.
//  Copyright © 2020 by.huang. All rights reserved.
//

#import "StatisticsCooperateModel.h"

@implementation StatisticsCooperateModel

-(NSMutableArray *)skuDatas{
    return [CooperateSkuModel mj_objectArrayWithKeyValuesArray:_skuStaticRespVoList];
}

@end


@implementation CooperateSkuModel

-(NSMutableArray *)celebrityDatas{
    return [CooperateCelebrityModel mj_objectArrayWithKeyValuesArray:_anchorStaticRespVoList];
}

@end

@implementation CooperateCelebrityModel


@end

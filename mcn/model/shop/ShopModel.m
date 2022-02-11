//
//  ShopModel.m
//  mcn
//
//  Created by by.huang on 2020/8/25.
//  Copyright © 2020 by.huang. All rights reserved.
//

#import "ShopModel.h"

@implementation ShopSkuModel

-(double)firstPrice{
    NSDictionary *dic =  [STConvertUtil jsonToDic:_allocateRatio];
    return [dic[@"firstOrder"] doubleValue];
}

-(double)rePrice{
    NSDictionary *dic =  [STConvertUtil jsonToDic:_allocateRatio];
    return [dic[@"repeat"] doubleValue];
}



@end

@implementation ShopModel

-(id)copyWithZone:(NSZone *)zone{
    ShopModel *model = [[[self class] allocWithZone:zone] init];
    model.mchId = _mchId;
    model.supplierName  = _supplierName;
    model.avatar = _avatar;
    model.skus = _skus;
    model.skuModels = _skuModels;
    model.isAllSelect = _isAllSelect;
    model.isExpand = _isExpand;

    return model;
}

@end

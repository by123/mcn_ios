//
//  PartnerDetailModel.m
//  mcn
//
//  Created by by.huang on 2020/9/7.
//  Copyright © 2020 by.huang. All rights reserved.
//

#import "PartnerDetailModel.h"

@implementation PartnerDetailModel


-(NSMutableArray *)skuModels{
  return [ProductModel mj_objectArrayWithKeyValuesArray:_skus];
}

-(AddressInfoModel *)addressModel{
    return [AddressInfoModel mj_objectWithKeyValues:_address];
}

@end

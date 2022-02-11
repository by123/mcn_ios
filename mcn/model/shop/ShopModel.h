//
//  ShopModel.h
//  mcn
//
//  Created by by.huang on 2020/8/25.
//  Copyright © 2020 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProductModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ShopSkuModel : NSObject

@property(copy, nonatomic)NSString *supplierId;
@property(copy, nonatomic)NSString *skuId;
@property(copy, nonatomic)NSString *spuId;
@property(copy, nonatomic)NSString *spuName;
@property(assign, nonatomic)int amount;
@property(assign, nonatomic)int sellFlag;
@property(assign, nonatomic)double sellPrice;
@property(copy, nonatomic)NSString *picUrl;
@property(copy, nonatomic)NSString *attribute;
@property(copy, nonatomic)NSString *allocateRatio;

@property(assign, nonatomic)double firstPrice;
@property(assign, nonatomic)double rePrice;

//
@property(strong, nonatomic)NSMutableArray *celebrityDatas;
@property(assign, nonatomic)Boolean isSelect;

@end

@interface ShopModel : NSObject<NSCopying>

@property(copy, nonatomic)NSString *mchId;
@property(copy, nonatomic)NSString *supplierName;
@property(copy, nonatomic)NSString *avatar;
@property(strong, nonatomic)id skus;
@property(strong, nonatomic)NSMutableArray *skuModels;
@property(assign, nonatomic)Boolean isAllSelect;
@property(assign, nonatomic)Boolean isExpand;

@end

NS_ASSUME_NONNULL_END

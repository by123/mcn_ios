//
//  ShelvesModel.h
//  mcn
//
//  Created by by.huang on 2020/8/21.
//  Copyright © 2020 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProductModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ShelvesModel : NSObject

@property(copy, nonatomic)NSString *skuId;
@property(copy, nonatomic)NSString *skuPicOssUrl;
@property(copy, nonatomic)NSString *spuId;
@property(copy, nonatomic)NSString *spuName;
@property(copy, nonatomic)NSString *spuRemark;
@property(copy, nonatomic)NSString *attribute;
@property(copy, nonatomic)NSString *allocateRatio;
@property(assign, nonatomic)double sellPrice;
@property(assign, nonatomic)double firstOrderProfit;
@property(assign, nonatomic)double repeatProfit;
@property(assign, nonatomic)double salesProfit;

@end

NS_ASSUME_NONNULL_END

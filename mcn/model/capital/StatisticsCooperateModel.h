//
//  StatisticsCooperateModel.h
//  mcn
//
//  Created by by.huang on 2020/9/11.
//  Copyright © 2020 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface StatisticsCooperateModel : NSObject

@property(copy, nonatomic)NSString *cooperationId;
@property(copy, nonatomic)NSString *cooperationName;
@property(strong, nonatomic)id skuStaticRespVoList;
@property(strong, nonatomic)NSMutableArray *skuDatas;

@end

@interface CooperateSkuModel : NSObject

@property(copy, nonatomic)NSString *spuId;
@property(copy, nonatomic)NSString *spuName;
@property(assign, nonatomic)double total;
@property(strong, nonatomic)id anchorStaticRespVoList;
@property(strong, nonatomic)NSMutableArray *celebrityDatas;

@end

@interface CooperateCelebrityModel : NSObject

@property(copy, nonatomic)NSString *anchorName;
@property(copy, nonatomic)NSString *mchId;
@property(assign, nonatomic)double value;
@property(copy, nonatomic)NSString *picFullUrl;

@end

NS_ASSUME_NONNULL_END

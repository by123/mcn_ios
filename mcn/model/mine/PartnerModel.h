//
//  PartnerModel.h
//  mcn
//
//  Created by by.huang on 2020/9/6.
//  Copyright © 2020 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProductModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PartnerModel : NSObject

@property(copy, nonatomic)NSString *cooperationId;
@property(copy, nonatomic)NSString *mcnId;
@property(copy, nonatomic)NSString *supplierId;
@property(copy, nonatomic)NSString *supplierName;
@property(copy, nonatomic)NSString *avatar;
@property(assign, nonatomic)PartnerType projectState;
@property(strong, nonatomic)id skus;
@property(strong, nonatomic)NSMutableArray *skuModels;


+(NSString *)getStatuStr:(PartnerType)type;

@end

NS_ASSUME_NONNULL_END

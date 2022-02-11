//
//  PartnerDetailModel.h
//  mcn
//
//  Created by by.huang on 2020/9/7.
//  Copyright © 2020 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProductModel.h"
#import "PartnerModel.h"
#import "AddressInfoModel.h"
NS_ASSUME_NONNULL_BEGIN



@interface PartnerDetailModel : NSObject

@property(copy, nonatomic)NSString *cooperationId;
@property(copy, nonatomic)NSString *cooperationName;
@property(copy, nonatomic)NSString *mcnId;
@property(copy, nonatomic)NSString *mchId;
@property(copy, nonatomic)NSString *supplierId;
@property(copy, nonatomic)NSString *supplierName;
@property(copy, nonatomic)NSString *avatar;
@property(assign, nonatomic)PartnerType projectState;
@property(assign, nonatomic)NSString *createTime;
@property(strong, nonatomic)id skus;
@property(strong, nonatomic)NSMutableArray *skuModels;
@property(strong, nonatomic)id address;
@property(strong, nonatomic)AddressInfoModel *addressModel;


@end

NS_ASSUME_NONNULL_END

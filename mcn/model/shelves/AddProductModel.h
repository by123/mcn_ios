//
//  AddProductModel.h
//  mcn
//
//  Created by by.huang on 2020/9/4.
//  Copyright © 2020 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProductConfigModel : NSObject

@property(assign, nonatomic)int plat;
@property(assign, nonatomic)int supplier;
@property(assign, nonatomic)int order;

@end

@interface AddProductModel : NSObject

@property(copy, nonatomic)NSString *spuName;
@property(copy, nonatomic)NSString *spuRemark;
@property(assign, nonatomic)int goodsClassId;
@property(assign, nonatomic)double sellPrice;
@property(assign, nonatomic)int repeatRatio;
@property(strong, nonatomic)NSMutableArray *picUrlList;
@property(strong, nonatomic)NSMutableArray *goodsDetailList;

@end

NS_ASSUME_NONNULL_END

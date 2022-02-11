//
//  StatisticsProductModel.h
//  mcn
//
//  Created by by.huang on 2020/9/11.
//  Copyright © 2020 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface StatisticsProductModel : NSObject

@property(copy, nonatomic)NSString *spuId;
@property(copy, nonatomic)NSString *spuName;
@property(assign, nonatomic)double total;

@end

NS_ASSUME_NONNULL_END

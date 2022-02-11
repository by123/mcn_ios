//
//  BannerModel.h
//  mcn
//
//  Created by by.huang on 2020/9/1.
//  Copyright © 2020 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BannerModel : NSObject

@property(copy, nonatomic)NSString *picUrl;
@property(assign, nonatomic)int type;
@property(copy, nonatomic)NSString *spuId;
@property(copy, nonatomic)NSString *skuId;

@end

NS_ASSUME_NONNULL_END

//
//  StatisticsCelebrityModel.h
//  mcn
//
//  Created by by.huang on 2020/9/11.
//  Copyright © 2020 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface StatisticsCelebrityModel : NSObject

@property(copy, nonatomic)NSString *anchorName;
@property(copy, nonatomic)NSString *mchId;
@property(assign, nonatomic)double value;

@end

NS_ASSUME_NONNULL_END

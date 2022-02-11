//
//  ScheduleModel.h
//  mcn
//
//  Created by by.huang on 2020/9/7.
//  Copyright © 2020 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ScheduleModel : NSObject

@property(copy, nonatomic)NSString *cooperationId;
@property(assign, nonatomic)int optType;
@property(copy, nonatomic)NSString *mchId;
@property(copy, nonatomic)NSString *userId;
@property(copy, nonatomic)NSString *optDesc;
@property(copy, nonatomic)NSString *createTime;

@end

NS_ASSUME_NONNULL_END

//
//  StatisticsItemViewModel.h
//  mcn
//
//  Created by by.huang on 2020/9/11.
//  Copyright © 2020 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StatisticsCooperateModel.h"
#import "StatisticsProductModel.h"
#import "StatisticsCelebrityModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol StatisticsItemViewDelegate<BaseRequestDelegate>


@end

@interface StatisticsItemViewModel : NSObject

@property(weak, nonatomic)id<StatisticsItemViewDelegate> delegate;
@property(assign, nonatomic)double total;
@property(assign, nonatomic)double natureIncome;
@property(strong, nonatomic)NSMutableArray *datas;
@property(assign, nonatomic)StaticticsItemType type;
@property(assign, nonatomic)StaticticsType statisticsType;
@property(copy, nonatomic)NSString *startTime;
@property(copy, nonatomic)NSString *endTime;

-(void)requestCooperateList;
-(void)requestProductList;
-(void)requestCelebrityList;


@end

NS_ASSUME_NONNULL_END

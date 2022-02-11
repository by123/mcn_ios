//
//  StatisticsItemView.h
//  mcn
//
//  Created by by.huang on 2020/9/11.
//  Copyright © 2020 by.huang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StaticticsViewModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface StatisticsItemView : UIView

-(instancetype)initWithType:(StaticticsItemType)type statisticsType:(StaticticsType)statisticsType startTime:(NSString *)startTime endTime:(NSString *)endTime vm:(StaticticsViewModel *)vm;
-(void)refreshData:(StaticticsItemType)type;
-(void)updateTime:(NSString *)startTime endTime:(NSString *)endTime;

@end

NS_ASSUME_NONNULL_END

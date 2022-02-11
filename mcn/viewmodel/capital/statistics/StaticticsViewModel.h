//
//  StaticticsViewModel.h
//  manage
//
//  Created by by.huang on 2019/09/03.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol StaticticsViewDelegate<BaseRequestDelegate>

-(void)onGoPartnerDetailPage:(NSString *)cooperationId;

@end


@interface StaticticsViewModel : NSObject

@property(weak, nonatomic)id<StaticticsViewDelegate> delegate;
@property(strong, nonatomic)NSMutableArray *datas;
@property(assign, nonatomic)StaticticsType type;
@property(copy, nonatomic)NSString *startTime;
@property(copy, nonatomic)NSString *endTime;

-(void)goPartnerDetailPage:(NSString *)cooperationId;


@end




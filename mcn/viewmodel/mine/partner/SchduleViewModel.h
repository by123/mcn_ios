//
//  SchduleViewModel.h
//  manage
//
//  Created by by.huang on 2019/09/03.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ScheduleModel.h"

@protocol SchduleViewDelegate<BaseRequestDelegate>

@end


@interface SchduleViewModel : NSObject

@property(weak, nonatomic)id<SchduleViewDelegate> delegate;
@property(strong, nonatomic)NSMutableArray *datas;
@property(copy, nonatomic)NSString *cooperationId;
@property(copy, nonatomic)NSString *cooperationName;


-(void)requestSchedule;

@end




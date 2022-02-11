//
//  LogisticalViewModel.h
//  manage
//
//  Created by by.huang on 2019/09/03.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DeliveryModel.h"
@protocol LogisticalViewDelegate<BaseRequestDelegate>


@end


@interface LogisticalViewModel : NSObject

@property(weak, nonatomic)id<LogisticalViewDelegate> delegate;
@property(strong, nonatomic)DeliveryModel *model;
@property(copy, nonatomic)NSString *cooperationId;


-(void)requestLogistical;

@end




//
//  CapitalDetailViewModel.h
//  manage
//
//  Created by by.huang on 2019/09/03.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CapitalDetailModel.h"
@protocol CapitalDetailViewDelegate<BaseRequestDelegate>

@end


@interface CapitalDetailViewModel : NSObject

@property(weak, nonatomic)id<CapitalDetailViewDelegate> delegate;
@property(strong, nonatomic)CapitalDetailModel *model;
@property(copy, nonatomic)NSString *orderId;


-(void)requestDetail;

@end




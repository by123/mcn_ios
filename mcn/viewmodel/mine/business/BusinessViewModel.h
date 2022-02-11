//
//  BusinessViewModel.h
//  manage
//
//  Created by by.huang on 2019/09/03.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BusinessModel.h"
@protocol BusinessViewDelegate<BaseRequestDelegate>

-(void)onGoBusinessEditPage;

@end


@interface BusinessViewModel : NSObject

@property(weak, nonatomic)id<BusinessViewDelegate> delegate;
@property(strong, nonatomic)BusinessModel *model;
@property(copy, nonatomic)NSString *mchId;


-(void)requestDetail;
-(void)goBusinessEditPage;

@end




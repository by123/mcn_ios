//
//  PartnerCelebrityViewModel.h
//  manage
//
//  Created by by.huang on 2019/09/03.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AuthUserModel.h"

@protocol PartnerCelebrityViewDelegate<BaseRequestDelegate>

@end


@interface PartnerCelebrityViewModel : NSObject

@property(weak, nonatomic)id<PartnerCelebrityViewDelegate> delegate;
@property(strong, nonatomic)AuthUserModel *model;
@property(copy, nonatomic)NSString *mchId;

-(void)requestDetail;

@end




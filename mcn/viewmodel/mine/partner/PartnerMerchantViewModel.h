//
//  PartnerMerchantViewModel.h
//  manage
//
//  Created by by.huang on 2019/09/03.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AuthUserModel.h"

@protocol PartnerMerchantViewDelegate<BaseRequestDelegate>

@end


@interface PartnerMerchantViewModel : NSObject

@property(weak, nonatomic)id<PartnerMerchantViewDelegate> delegate;
@property(strong, nonatomic)AuthUserModel *model;
@property(copy, nonatomic)NSString *mchId;

-(void)requestDetail;

@end




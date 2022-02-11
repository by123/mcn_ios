//
//  DeliveryViewModel.h
//  manage
//
//  Created by by.huang on 2019/09/03.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DeliveryModel.h"
#import "ExpressModel.h"
#import "AddressInfoModel.h"

@protocol DeliveryViewDelegate<BaseRequestDelegate>

-(void)onGetExpressList;

@end


@interface DeliveryViewModel : NSObject

@property(weak, nonatomic)id<DeliveryViewDelegate> delegate;
@property(strong, nonatomic)DeliveryModel *model;
@property(strong, nonatomic)NSMutableArray *expressDatas;
@property(strong, nonatomic)AddressInfoModel *addressModel;

-(void)getExpressList;
-(void)submitDelivery;

@end




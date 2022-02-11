//
//  AddAddressViewModel.h
//  manage
//
//  Created by by.huang on 2019/09/03.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AddressInfoModel.h"

@protocol AddAddressViewDelegate<BaseRequestDelegate>

@end


@interface AddAddressViewModel : NSObject

@property(weak, nonatomic)id<AddAddressViewDelegate> delegate;
@property(strong, nonatomic)AddressInfoModel *model;
@property(assign, nonatomic)AddAddressType type;

-(void)requestAddAddress;
-(void)requestEditAddress;

@end




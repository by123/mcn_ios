//
//  AddressInfoModel.h
//  mcn
//
//  Created by by.huang on 2020/8/30.
//  Copyright © 2020 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddressInfoModel : BaseModel

@property(copy, nonatomic)NSString *addressId;
@property(copy, nonatomic)NSString *userId;
@property(copy, nonatomic)NSString *contactUser;
@property(copy, nonatomic)NSString *contactPhone;
@property(copy, nonatomic)NSString *province;
@property(copy, nonatomic)NSString *city;
@property(copy, nonatomic)NSString *area;
@property(copy, nonatomic)NSString *detailAddr;
@property(assign, nonatomic)int defaultFlag;
@property(assign, nonatomic)Boolean isSelect;

@property(copy, nonatomic)NSString *cooperationId;

@end

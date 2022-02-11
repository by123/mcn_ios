//
//  CooperationViewModel.h
//  manage
//
//  Created by by.huang on 2019/09/03.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AddressInfoModel.h"
#import "CelebrityParamModel.h"
#import "ShopModel.h"

@protocol CooperationViewDelegate<BaseRequestDelegate>

-(void)onGoAddressPage:(NSString *)addressId;
-(void)onGoSelectCelebrityPage:(CelebrityParamModel *)model;

@end


@interface CooperationViewModel : NSObject

@property(weak, nonatomic)id<CooperationViewDelegate> delegate;
@property(strong, nonatomic)NSMutableArray *datas;
@property(strong, nonatomic)AddressInfoModel *addressModel;

-(void)requestDefaultAddress;
-(void)goAddressPage:(NSString *)addressId;
-(void)goSelectCelebrityPage:(CelebrityParamModel *)model;
-(void)commit;

@end




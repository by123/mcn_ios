//
//  AddressViewModel.h
//  manage
//
//  Created by by.huang on 2019/09/03.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AddressInfoModel.h"

@protocol AddressViewDelegate<BaseRequestDelegate>

-(void)onGoAddAddressPage:(AddressInfoModel *)model;
-(void)onRequestNoDatas:(Boolean)isFirst;
-(void)onGoBackLastPage;

@end


@interface AddressViewModel : NSObject

@property(weak, nonatomic)id<AddressViewDelegate> delegate;
@property(strong, nonatomic)NSMutableArray *datas;
@property(assign, nonatomic)AddressType type;
@property(copy, nonatomic)NSString *addressId;


-(void)goAddAddressPage:(AddressInfoModel *)model;
-(void)requestAddress:(Boolean)isRefreshNew;
-(void)deleteAddress:(NSString *)addressId;
-(void)goBackLastPage;

@end




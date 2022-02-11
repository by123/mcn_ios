
//
//  AddAddressViewModel.m
//  manage
//
//  Created by by.huang on 2019/09/03.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AddAddressViewModel.h"
#import "STNetUtil.h"
#import "AccountManager.h"

@interface AddAddressViewModel()


@end

@implementation AddAddressViewModel : NSObject

-(instancetype)init{
    if(self == [super init]){
        _model = [[AddressInfoModel alloc]init];
    }
    return self;
}

-(void)requestAddAddress{
    if(!_delegate)  return;
    [_delegate onRequestBegin];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    UserModel *model = [[AccountManager sharedAccountManager] getUserModel];
    dic[@"mchId"] = model.mchId;
    dic[@"province"] = _model.province;
    dic[@"city"] = _model.city;
    dic[@"area"] = _model.area;
    dic[@"detailAddr"] = _model.detailAddr;
    dic[@"contactPhone"] = _model.contactPhone;
    dic[@"contactUser"] = _model.contactUser;
    dic[@"defaultFlag"] = @(_model.defaultFlag);
    WS(weakSelf)
    [STNetUtil post:URL_ADDRESS_ADD content:dic.mj_JSONString success:^(RespondModel *respondModel) {
        if([STATU_SUCCESS isEqualToString:respondModel.status]){
            [weakSelf.delegate onRequestSuccess:respondModel data:nil];
        }else{
            [weakSelf.delegate onRequestFail:respondModel.msg];
        }
    } failure:^(int errorCode) {
        [weakSelf.delegate onRequestFail:[NSString stringWithFormat:MSG_ERROR,errorCode]];
    }];
}

-(void)requestEditAddress{
    if(!_delegate)  return;
    [_delegate onRequestBegin];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    UserModel *model = [[AccountManager sharedAccountManager] getUserModel];
    dic[@"mchId"] = model.mchId;
    dic[@"id"] = _model.addressId;
    dic[@"province"] = _model.province;
    dic[@"city"] = _model.city;
    dic[@"area"] = _model.area;
    dic[@"detailAddr"] = _model.detailAddr;
    dic[@"contactPhone"] = _model.contactPhone;
    dic[@"contactUser"] = _model.contactUser;
    dic[@"defaultFlag"] = @(_model.defaultFlag);
    WS(weakSelf)
    [STNetUtil post:URL_ADDRESS_UPDATE content:dic.mj_JSONString success:^(RespondModel *respondModel) {
        if([STATU_SUCCESS isEqualToString:respondModel.status]){
            [weakSelf.delegate onRequestSuccess:respondModel data:nil];
        }else{
            [weakSelf.delegate onRequestFail:respondModel.msg];
        }
    } failure:^(int errorCode) {
        [weakSelf.delegate onRequestFail:[NSString stringWithFormat:MSG_ERROR,errorCode]];
    }];
}




@end







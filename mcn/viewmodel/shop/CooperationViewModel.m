
//
//  CooperationViewModel.m
//  manage
//
//  Created by by.huang on 2019/09/03.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CooperationViewModel.h"
#import "STNetUtil.h"

@interface CooperationViewModel()


@end

@implementation CooperationViewModel : NSObject

-(instancetype)init{
    if(self == [super init]){
        _datas = [[NSMutableArray alloc]init];
        _addressModel = [[AddressInfoModel alloc]init];
    }
    return self;
}


-(void)requestDefaultAddress{
    if(!_delegate)  return;
    [_delegate onRequestBegin];
    WS(weakSelf)
    [STNetUtil get:URL_GET_ADDRESS_DEFAULT parameters:nil success:^(RespondModel *respondModel) {
        if([respondModel.status isEqualToString:STATU_SUCCESS]){
            weakSelf.addressModel = [AddressInfoModel mj_objectWithKeyValues:respondModel.data];
            [weakSelf.delegate onRequestSuccess:respondModel data:respondModel.data];
        }else{
            [weakSelf.delegate onRequestFail:respondModel.msg];
        }
    } failure:^(int errorCode) {
        [weakSelf.delegate onRequestFail:[NSString stringWithFormat:MSG_ERROR,errorCode]];
    }];
}

-(void)goAddressPage:(NSString *)addressId{
    if(_delegate){
        [_delegate onGoAddressPage:addressId];
    }
}

-(void)goSelectCelebrityPage:(CelebrityParamModel *)model{
    if(_delegate){
        [_delegate onGoSelectCelebrityPage:model];
    }
}

-(void)commit{
    if(!_delegate) return;
    [_delegate onRequestBegin];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    dic[@"addressId"] = _addressModel.addressId;
    dic[@"skus"] = [self generateParam];
    WS(weakSelf)
    [STNetUtil post:URL_PROJECT_SUBMIT content:dic.mj_JSONString success:^(RespondModel *respondModel) {
        if([respondModel.status isEqualToString:STATU_SUCCESS]){
            id data = respondModel.data;
            [weakSelf.delegate onRequestSuccess:respondModel data:data];
        }else{
            [weakSelf.delegate onRequestFail:respondModel.msg];
        }
        
    } failure:^(int errorCode) {
        [weakSelf.delegate onRequestFail:[NSString stringWithFormat:MSG_ERROR,errorCode]];
    }];
}


-(NSMutableArray *)generateParam{
    NSMutableArray *skus = [[NSMutableArray alloc]init];
    if(!IS_NS_COLLECTION_EMPTY(_datas)){
        for(ShopModel *shopModel in _datas){
            if(!IS_NS_COLLECTION_EMPTY(shopModel.skuModels)){
                for(ShopSkuModel *skuModel in shopModel.skuModels){
                    NSMutableDictionary *skuDic = [[NSMutableDictionary alloc]init];
                    skuDic[@"skuId"] = @([skuModel.skuId intValue]);
                    NSMutableArray *mchIds = [[NSMutableArray alloc]init];
                    if(!IS_NS_COLLECTION_EMPTY(skuModel.celebrityDatas)){
                        for(CelebrityModel *celebrityModel in skuModel.celebrityDatas){
                            [mchIds addObject:celebrityModel.mchId];
                        }
                        skuDic[@"mchIds"] = mchIds;
                    }
                    [skus addObject:skuDic];
                }
            }
        }
    }
    return skus;
}

@end




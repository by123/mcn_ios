
//
//  AddressViewModel.m
//  manage
//
//  Created by by.huang on 2019/09/03.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AddressViewModel.h"
#import "STNetUtil.h"
#import "AccountManager.h"

@interface AddressViewModel()

@property(assign, nonatomic)int currentPage;

@end

@implementation AddressViewModel : NSObject


-(instancetype)init{
    if(self == [super init]){
        _currentPage = 1;
        _datas = [[NSMutableArray alloc]init];
    }
    return self;
}


-(void)requestAddress:(Boolean)isRefreshNew{
    if(!_delegate) return;
    [_delegate onRequestBegin];
    if(isRefreshNew){
        _currentPage = 1;
    }
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    UserModel *model = [[AccountManager sharedAccountManager] getUserModel];
    dic[@"page"] = @(_currentPage);
    dic[@"size"] = @(XW_PAGESIZE);
    WS(weakSelf)
    [STNetUtil post:URL_ADDRESS_QUERY content:dic.mj_JSONString success:^(RespondModel *respondModel) {
        if([respondModel.status isEqualToString:STATU_SUCCESS]){
            id data = respondModel.data;
            int pages = [[data objectForKey:@"pages"] intValue];
            int current = [[data objectForKey:@"current"] intValue];
            id datas = [data objectForKey:@"records"];
            NSMutableArray *requestDatas = [AddressInfoModel mj_objectArrayWithKeyValuesArray:datas];
            if(IS_NS_COLLECTION_EMPTY(requestDatas)){
                if(isRefreshNew){
                    //无数据
                    [weakSelf.delegate onRequestNoDatas:YES];
                }else{
                    //没有更多数据
                    [weakSelf.delegate onRequestNoDatas:NO];
                }
            }else{
                if(isRefreshNew){
                    if(pages == current){
                        //下拉刷新，无更多数据
                        weakSelf.datas = requestDatas;
                        [weakSelf setSelectAddress];
                        [weakSelf.delegate onRequestNoDatas:NO];
                        return;
                    }else{
                        weakSelf.datas = requestDatas;
                    }
                }else{
                    if(pages == current){
                        //上拉加载，无更多数据
                        [weakSelf.datas addObjectsFromArray:requestDatas];
                        [weakSelf setSelectAddress];
                        [weakSelf.delegate onRequestNoDatas:NO];
                        return;
                    }else{
                        [weakSelf.datas addObjectsFromArray:requestDatas];
                    }
                }
                weakSelf.currentPage ++;
                [weakSelf setSelectAddress];
                [weakSelf.delegate onRequestSuccess:respondModel data:data];
            }
        }else{
            [weakSelf.delegate onRequestFail:respondModel.msg];
        }
        
    } failure:^(int errorCode) {
        [weakSelf.delegate onRequestFail:[NSString stringWithFormat:MSG_ERROR,errorCode]];
    }];
}


-(void)setSelectAddress{
    if(!IS_NS_STRING_EMPTY(_addressId) && !IS_NS_COLLECTION_EMPTY(_datas)){
        for(AddressInfoModel *model in _datas){
            if([model.addressId isEqualToString:_addressId]){
                model.isSelect = YES;
            }
        }
    }
}

-(void)deleteAddress:(NSString *)addressId{
    if(!_delegate)  return;
    [_delegate onRequestBegin];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    dic[@"id"] = addressId;
    WS(weakSelf)
    [STNetUtil get:URL_ADDRESS_DEL parameters:dic success:^(RespondModel *respondModel) {
        if([respondModel.status isEqualToString:STATU_SUCCESS]){
            for(AddressInfoModel *model in weakSelf.datas){
                if([model.addressId isEqualToString:addressId]){
                    [weakSelf.datas removeObject:model];
                    break;
                }
            }
            [weakSelf.delegate onRequestSuccess:respondModel data:respondModel.data];
        }else{
            [weakSelf.delegate onRequestFail:respondModel.msg];
        }
    } failure:^(int errorCode) {
        [weakSelf.delegate onRequestFail:[NSString stringWithFormat:MSG_ERROR,errorCode]];
    }];
}


-(void)goAddAddressPage:(AddressInfoModel *)model{
    if(_delegate){
        [_delegate onGoAddAddressPage:model];
    }
    
}

-(void)goBackLastPage{
    if(_delegate){
        [_delegate onGoBackLastPage];
    }
}



@end




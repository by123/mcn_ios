
//
//  ShopViewModel.m
//  manage
//
//  Created by by.huang on 2019/09/03.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ShopViewModel.h"
#import "STNetUtil.h"

@interface ShopViewModel()

@property(assign, nonatomic)int currentPage;

@end

@implementation ShopViewModel : NSObject

-(instancetype)init{
    if(self == [super init]){
        _datas = [[NSMutableArray alloc]init];
    }
    return self;
}


-(void)reqeustList{
    if(!_delegate)  return;
    [_delegate onRequestBegin];
    WS(weakSelf)
    [STNetUtil get:URL_SHOPCART_LIST parameters:nil success:^(RespondModel *respondModel) {
        if([respondModel.status isEqualToString:STATU_SUCCESS]){
            weakSelf.datas = [ShopModel mj_objectArrayWithKeyValuesArray:respondModel.data];
            if(!IS_NS_COLLECTION_EMPTY(weakSelf.datas)){
                for(ShopModel *shopModel in weakSelf.datas){
                    shopModel.skuModels = [ShopSkuModel mj_objectArrayWithKeyValuesArray:shopModel.skus];
                    [STLog print:@"请求的数量" content:LongStr(shopModel.skuModels.count)];
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


-(void)deleteSKu:(NSString *)skuId{
    if(!_delegate) return;
    [_delegate onRequestBegin];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    WS(weakSelf)
    [STNetUtil post:[NSString stringWithFormat:@"%@?skuId=%@",URL_SHOPCART_REMOVE,skuId] content:dic.mj_JSONString success:^(RespondModel *respondModel) {
        if([respondModel.status isEqualToString:STATU_SUCCESS]){
            [weakSelf.delegate onRequestSuccess:respondModel data:skuId];
        }else{
            [weakSelf.delegate onRequestFail:respondModel.msg];
        }
        
    } failure:^(int errorCode) {
        [weakSelf.delegate onRequestFail:[NSString stringWithFormat:MSG_ERROR,errorCode]];
    }];
}

-(void)deleteMulSku:(NSMutableArray *)skuIds{
    if(!_delegate) return;
    [_delegate onRequestBegin];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    dic[@"skuIds"] = skuIds;
    WS(weakSelf)
    [STNetUtil post:URL_SHOPCART_BATCH_REMOVE content:dic.mj_JSONString success:^(RespondModel *respondModel) {
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


-(void)updateTableView:(NSInteger)position tag:(NSInteger)tag{
    if(_delegate){
        [_delegate onUpdateTableView:position tag:tag];
    }
}



@end




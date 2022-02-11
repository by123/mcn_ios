
//
//  ProductDetailViewModel.m
//  manage
//
//  Created by by.huang on 2019/09/03.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProductDetailViewModel.h"
#import "STNetUtil.h"

@interface ProductDetailViewModel()


@end

@implementation ProductDetailViewModel : NSObject

-(instancetype)init{
    if(self == [super init]){
        _model = [[ProductModel alloc]init];
    }
    return self;
}


-(void)requesDetail{
    if(!_delegate)  return;
    [_delegate onRequestBegin];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    dic[@"skuId"] = _skuId;
    WS(weakSelf)
    [STNetUtil get:URL_GOODS_DETAIL parameters:dic success:^(RespondModel *respondModel) {
        if([respondModel.status isEqualToString:STATU_SUCCESS]){
            weakSelf.model = [ProductModel mj_objectWithKeyValues:respondModel.data];
            [weakSelf.delegate onRequestSuccess:respondModel data:respondModel.data];
        }else{
            [weakSelf.delegate onRequestFail:respondModel.msg];
        }
    } failure:^(int errorCode) {
        [weakSelf.delegate onRequestFail:[NSString stringWithFormat:MSG_ERROR,errorCode]];
    }];
}


-(void)addProductCart{
    if(!_delegate) return;
    [_delegate onRequestBegin];
    WS(weakSelf)
    [STNetUtil post:[NSString stringWithFormat:@"%@?skuId=%@",URL_SHOPCART_ADD,_model.skuId] content:nil success:^(RespondModel *respondModel) {
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


-(void)goBack{
    if(_delegate){
        [_delegate onGoBack];
    }
}

-(void)goCooperationPage{
    if(_delegate){
        [_delegate onGoCooperationPage];
    }
}


-(void)goMessageTab{
    if(_delegate){
        [_delegate onGoMessageTab];
    }
}
@end




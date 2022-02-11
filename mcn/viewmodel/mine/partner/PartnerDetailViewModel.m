
//
//  PartnerDetailViewModel.m
//  manage
//
//  Created by by.huang on 2019/09/03.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PartnerDetailViewModel.h"
#import "STNetUtil.h"

@interface PartnerDetailViewModel()


@end

@implementation PartnerDetailViewModel : NSObject

-(instancetype)init{
    if(self == [super init]){
        _model = [[PartnerDetailModel alloc]init];
    }
    return self;
}


-(void)requestDetail{
    if(!_delegate)  return;
    [_delegate onRequestBegin];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    dic[@"cooperationId"] = _cooperationId;
    WS(weakSelf)
    [STNetUtil get:URL_PROJECT_DETAIL parameters:dic success:^(RespondModel *respondModel) {
        if([respondModel.status isEqualToString:STATU_SUCCESS]){
            weakSelf.model = [PartnerDetailModel mj_objectWithKeyValues:respondModel.data];
            [weakSelf.delegate onRequestSuccess:respondModel data:respondModel.data];
        }else{
            [weakSelf.delegate onRequestFail:respondModel.msg];
        }
    } failure:^(int errorCode) {
        [weakSelf.delegate onRequestFail:[NSString stringWithFormat:MSG_ERROR,errorCode]];
    }];
}

-(void)confirmCooperate{
    if(!_delegate)  return;
    [_delegate onRequestBegin];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    dic[@"cooperationId"] = _cooperationId;
    WS(weakSelf)
    [STNetUtil get:URL_PROJECT_ACT parameters:dic success:^(RespondModel *respondModel) {
        if([respondModel.status isEqualToString:STATU_SUCCESS]){
            [weakSelf.delegate onRequestSuccess:respondModel data:respondModel.data];
        }else{
            [weakSelf.delegate onRequestFail:respondModel.msg];
        }
    } failure:^(int errorCode) {
        [weakSelf.delegate onRequestFail:[NSString stringWithFormat:MSG_ERROR,errorCode]];
    }];
}

-(void)cancelCooperate{
    if(!_delegate)  return;
     [_delegate onRequestBegin];
     NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
     dic[@"cooperationId"] = _cooperationId;
     WS(weakSelf)
     [STNetUtil get:URL_PROJECT_CANCEL parameters:dic success:^(RespondModel *respondModel) {
         if([respondModel.status isEqualToString:STATU_SUCCESS]){
             [weakSelf.delegate onRequestSuccess:respondModel data:respondModel.data];
         }else{
             [weakSelf.delegate onRequestFail:respondModel.msg];
         }
     } failure:^(int errorCode) {
         [weakSelf.delegate onRequestFail:[NSString stringWithFormat:MSG_ERROR,errorCode]];
     }];
}


-(void)goSchdulePage{
    if(_delegate){
        [_delegate onGoSchdulePage];
    }
}

-(void)goLogisticalPage{
    if(_delegate){
        [_delegate onGoLogisticalPage];
    }
}

-(void)goPartnerMcnPage{
    if(_delegate){
        [_delegate onGoPartnerMcnPage];
    }
}

-(void)goPartnerCelebrity{
    if(_delegate){
        [_delegate onGoPartnerCelebrity];
    }
}


-(void)goPartnerMerchantPage{
    if(_delegate){
        [_delegate onGoPartnerMerchantPage];
    }
}

-(void)goDeliveryPage{
    if(_delegate){
        [_delegate onGoDeliveryPage];
    }
}
@end




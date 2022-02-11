
//
//  DeliveryViewModel.m
//  manage
//
//  Created by by.huang on 2019/09/03.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DeliveryViewModel.h"
#import "STNetUtil.h"

@interface DeliveryViewModel()


@end

@implementation DeliveryViewModel : NSObject

-(instancetype)init{
    if(self == [super init]){
        _model = [[DeliveryModel alloc]init];
        _expressDatas = [[NSMutableArray alloc]init];
    }
    return self;
}


-(void)submitDelivery{
    if(!_delegate) return;
    [_delegate onRequestBegin];
    WS(weakSelf)
    [STNetUtil post:URL_DELIVERY_SUBMIT content:_model.mj_JSONString success:^(RespondModel *respondModel) {
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


-(void)getExpressList{
    WS(weakSelf)
    [STNetUtil getConfig:@"all_express_list" success:^(NSString *result) {
        weakSelf.expressDatas = [ExpressModel mj_objectArrayWithKeyValuesArray:result];
        if(weakSelf.delegate){
            [weakSelf.delegate onGetExpressList];
        }
    }];
}

@end




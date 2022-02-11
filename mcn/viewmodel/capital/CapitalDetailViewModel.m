
//
//  CapitalDetailViewModel.m
//  manage
//
//  Created by by.huang on 2019/09/03.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CapitalDetailViewModel.h"
#import "STNetUtil.h"
@interface CapitalDetailViewModel()


@end

@implementation CapitalDetailViewModel : NSObject

-(instancetype)init{
    if(self == [super init]){
        _model = [[CapitalDetailModel alloc]init];
    }
    return self;
}

-(void)requestDetail{
    if(!_delegate)  return;
    [_delegate onRequestBegin];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    dic[@"id"] = _orderId;
    WS(weakSelf)
    [STNetUtil get:URL_CAPITAL_DETAIL parameters:dic success:^(RespondModel *respondModel) {
        if([respondModel.status isEqualToString:STATU_SUCCESS]){
            weakSelf.model = [CapitalDetailModel mj_objectWithKeyValues:respondModel.data];
            [weakSelf.delegate onRequestSuccess:respondModel data:respondModel.data];
        }else{
            [weakSelf.delegate onRequestFail:respondModel.msg];
        }
    } failure:^(int errorCode) {
        [weakSelf.delegate onRequestFail:[NSString stringWithFormat:MSG_ERROR,errorCode]];
    }];
}


@end




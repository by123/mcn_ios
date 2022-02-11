
//
//  LogisticalViewModel.m
//  manage
//
//  Created by by.huang on 2019/09/03.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LogisticalViewModel.h"
#import "STNetUtil.h"
@interface LogisticalViewModel()


@end

@implementation LogisticalViewModel : NSObject

-(instancetype)init{
    if(self == [super init]){
        _model = [[DeliveryModel alloc]init];
    }
    return self;
}


-(void)requestLogistical{
    if(!_delegate)  return;
    [_delegate onRequestBegin];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    dic[@"cooperationId"] = _cooperationId;
    WS(weakSelf)
    [STNetUtil get:URL_PROJECT_DELIVERY parameters:dic success:^(RespondModel *respondModel) {
        if([respondModel.status isEqualToString:STATU_SUCCESS]){
            weakSelf.model = [DeliveryModel mj_objectWithKeyValues:respondModel.data];
            [weakSelf.delegate onRequestSuccess:respondModel data:respondModel.data];
        }else{
            [weakSelf.delegate onRequestFail:respondModel.msg];
        }
    } failure:^(int errorCode) {
        [weakSelf.delegate onRequestFail:[NSString stringWithFormat:MSG_ERROR,errorCode]];
    }];
}




@end




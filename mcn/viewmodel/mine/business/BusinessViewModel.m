
//
//  BusinessViewModel.m
//  manage
//
//  Created by by.huang on 2019/09/03.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BusinessViewModel.h"
#import "STNetUtil.h"
#import "AccountManager.h"

@interface BusinessViewModel()


@end

@implementation BusinessViewModel : NSObject

-(instancetype)init{
    if(self == [super init]){
        _model = [[BusinessModel alloc]init];
    }
    return self;
}

-(void)requestDetail{
    if(!_delegate)  return;
    [_delegate onRequestBegin];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    if(IS_NS_STRING_EMPTY(_mchId)){
        UserModel *userModel = [[AccountManager sharedAccountManager] getUserModel];
        dic[@"mchId"] = userModel.mchId;
    }else{
        dic[@"mchId"] = _mchId;
    }
    WS(weakSelf)
    [STNetUtil get:URL_MCH_MY_CARD parameters:dic success:^(RespondModel *respondModel) {
        if([respondModel.status isEqualToString:STATU_SUCCESS]){
            weakSelf.model = [BusinessModel mj_objectWithKeyValues:respondModel.data];
            [weakSelf.delegate onRequestSuccess:respondModel data:respondModel.data];
        }else{
            [weakSelf.delegate onRequestFail:respondModel.msg];
        }
    } failure:^(int errorCode) {
        [weakSelf.delegate onRequestFail:[NSString stringWithFormat:MSG_ERROR,errorCode]];
    }];
}

-(void)goBusinessEditPage{
    if(_delegate){
        [_delegate onGoBusinessEditPage];
    }
}



@end





//
//  MsgDetailViewModel.m
//  manage
//
//  Created by by.huang on 2019/09/03.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MsgDetailViewModel.h"
#import "STNetUtil.h"

@interface MsgDetailViewModel()


@end

@implementation MsgDetailViewModel : NSObject

-(instancetype)init{
    if(self == [super init]){
        _model = [[MsgModel alloc]init];
    }
    return self;
}

-(void)requestMsgDetail{
    if(!_delegate)  return;
    [_delegate onRequestBegin];
    WS(weakSelf)
    [STNetUtil post:[NSString stringWithFormat:@"%@?id=%@",URL_MESSAGE_DETAIL,_msgId] content:nil success:^(RespondModel *respondModel) {
        if([respondModel.status isEqualToString:STATU_SUCCESS]){
            weakSelf.model = [MsgModel mj_objectWithKeyValues:respondModel.data];
            [weakSelf.delegate onRequestSuccess:respondModel data:respondModel.data];
        }else{
            [weakSelf.delegate onRequestFail:respondModel.msg];
        }
    } failure:^(int errorCode) {
        [weakSelf.delegate onRequestFail:[NSString stringWithFormat:MSG_ERROR,errorCode]];
    }];
}

-(void)requestAgree:(Boolean)isAgree{
    if(!_delegate)  return;
    [_delegate onRequestBegin];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    dic[@"id"] = _model.msgId;
    dic[@"operate"] = isAgree ? @(1) : @(0);
    WS(weakSelf)
    [STNetUtil get:URL_MCHINVITE_CELEBRITY_AGREE parameters:dic success:^(RespondModel *respondModel) {
        if([respondModel.status isEqualToString:STATU_SUCCESS]){
            [weakSelf.delegate onRequestSuccess:respondModel data:respondModel.data];
        }
        else{
            if([respondModel.status isEqualToString:STATU_NOT_EXIST]){
                [weakSelf.delegate onNotExist];
            }
            [weakSelf.delegate onRequestFail:respondModel.msg];
        }
    } failure:^(int errorCode) {
        [weakSelf.delegate onRequestFail:[NSString stringWithFormat:MSG_ERROR,errorCode]];
    }];
}

@end




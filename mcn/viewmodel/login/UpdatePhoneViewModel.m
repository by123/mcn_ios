
//
//  UpdatePhoneViewModel.m
//  manage
//
//  Created by by.huang on 2019/09/03.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UpdatePhoneViewModel.h"
#import "STNetUtil.h"
@interface UpdatePhoneViewModel()


@end

@implementation UpdatePhoneViewModel : NSObject


-(void)updateSendVerifyCode{
    if(!_delegate)  return;
       [_delegate onRequestBegin];
       NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
       dic[@"mobile"] = _phoneNum;
       WS(weakSelf)
       [STNetUtil get:URL_UPDATEPHONE_SENDCODE parameters:dic success:^(RespondModel *respondModel) {
           if([respondModel.status isEqualToString:STATU_SUCCESS]){
               [weakSelf.delegate onRequestSuccess:respondModel data:respondModel.data];
           }else{
               [weakSelf.delegate onRequestFail:respondModel.msg];
           }
       } failure:^(int errorCode) {
           [weakSelf.delegate onRequestFail:[NSString stringWithFormat:MSG_ERROR,errorCode]];
       }];
}

-(void)updatePhone:(NSString *)verifyCode{
    if(!_delegate) return;
    [_delegate onRequestBegin];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    dic[@"mobile"] = _phoneNum;
    dic[@"mobileCode"] = verifyCode;
    WS(weakSelf)
    [STNetUtil post:URL_UPDATE_MOBILE content:dic.mj_JSONString success:^(RespondModel *respondModel) {
        if([respondModel.status isEqualToString:STATU_SUCCESS]){
            [weakSelf.delegate onRequestSuccess:respondModel data:weakSelf.phoneNum];
        }else{
            [weakSelf.delegate onRequestFail:respondModel.msg];
        }
        
    } failure:^(int errorCode) {
        [weakSelf.delegate onRequestFail:[NSString stringWithFormat:MSG_ERROR,errorCode]];
    }];
}


@end




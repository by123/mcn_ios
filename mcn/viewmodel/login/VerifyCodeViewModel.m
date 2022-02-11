
//
//  VerifyCodeViewModel.m
//  manage
//
//  Created by by.huang on 2019/09/03.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VerifyCodeViewModel.h"
#import "STNetUtil.h"
#import "AccountManager.h"

@interface VerifyCodeViewModel()


@end

@implementation VerifyCodeViewModel : NSObject


-(void)sendVerifyCode{
    if(!_delegate)  return;
    [_delegate onRequestBegin];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    dic[@"mobile"] = _phoneNum;
    WS(weakSelf)
    [STNetUtil get:URL_SEND_VERIFYCODE parameters:dic success:^(RespondModel *respondModel) {
        if([respondModel.status isEqualToString:STATU_SUCCESS]){
            [weakSelf.delegate onRequestSuccess:respondModel data:respondModel.data];
        }else{
            [weakSelf.delegate onRequestFail:respondModel.msg];
        }
    } failure:^(int errorCode) {
        [weakSelf.delegate onRequestFail:[NSString stringWithFormat:MSG_ERROR,errorCode]];
    }];
}

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

-(void)updateVerifyCode:(NSString *)verifyCode{
    if(!_delegate) return;
    [_delegate onRequestBegin];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    dic[@"mobile"] = _phoneNum;
    dic[@"inputCode"] = verifyCode;
    WS(weakSelf)
    [STNetUtil post:URL_UPDATEPHONE_VERIFYCODE content:dic.mj_JSONString success:^(RespondModel *respondModel) {
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

-(void)verifyCode:(NSString *)verifyCode{
    if(!_delegate) return;
    [_delegate onRequestBegin];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    dic[@"mobile"] = _phoneNum;
    dic[@"inputCode"] = verifyCode;
    WS(weakSelf)
    [STNetUtil post:URL_VERIFYCODE_LOGIN content:dic.mj_JSONString success:^(RespondModel *respondModel) {
        if([respondModel.status isEqualToString:STATU_SUCCESS]){
            id data = respondModel.data;
            id user = [data objectForKey:@"businessUser"];
            id mch = [data objectForKey:@"mch"];
            UserModel *model = [UserModel mj_objectWithKeyValues:user];
            model.authToken = [data objectForKey:@"authToken"];
            model.roleIdSet = [data objectForKey:@"roleIdSet"];
            model.mchId = [mch objectForKey:@"mchId"];
            model.mchType = [[mch objectForKey:@"mchType"] intValue];
            model.authenticateState = [[mch objectForKey:@"authenticateState"] intValue];
            model.parentMchId = [mch objectForKey:@"parentMchId"];
            model.parentMchName = [mch objectForKey:@"parentMchName"];
            model.avatar = [mch objectForKey:@"avatar"];
            if(!IS_NS_COLLECTION_EMPTY(model.roleIdSet)){
                model.roleType = [model.roleIdSet[0] intValue];
            }
            [[AccountManager sharedAccountManager]saveUserModel:model];
            [weakSelf bindUmengMessage];
            [weakSelf.delegate onRequestSuccess:respondModel data:respondModel.data];

        }else{
            [weakSelf.delegate onRequestFail:respondModel.msg];
        }
        
    } failure:^(int errorCode) {
        [weakSelf.delegate onRequestFail:[NSString stringWithFormat:MSG_ERROR,errorCode]];
    }];
}



-(void)bindUmengMessage{
    NSString *deviceToken = [STUserDefaults getKeyValue:UD_DEVICE_TOKEN];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *token = [userDefaults objectForKey:@"kUMessageUserDefaultKeyForDeviceToken"];
    [STLog print:@"友盟token->" content:token];
    if(IS_NS_STRING_EMPTY(deviceToken)) return;
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    dic[@"deviceToken"] = deviceToken;
    [STNetUtil post:URL_MESSAGE_BIND content:dic.mj_JSONString success:^(RespondModel *respondModel) {
        if([respondModel.status isEqualToString:STATU_SUCCESS]){
            [STLog print:@"友盟推送注册成功"];
        }
    } failure:^(int errorCode) {
        
    }];
}

@end





//
//  LoginViewModel.m
//  manage
//
//  Created by by.huang on 2019/09/03.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import "LoginViewModel.h"
#import "STNetUtil.h"
#import "AccountManager.h"
#import "STUserDefaults.h"

@implementation LoginViewModel


-(void)doLogin:(NSString *)userName psw:(NSString *)password isMessgeLogin:(Boolean)isMessgeLogin{
    if(isMessgeLogin){
        if(_delegate){
            [_delegate onGoVerifyCodePage:userName];
        }
        return;
    }
    if(!_delegate) return;
    [_delegate onRequestBegin];
    
    [STUserDefaults saveKeyValue:UD_USERNAME value:userName];
    
    if([[STConvertUtil base64Decode:MSG_TEST_ID] isEqualToString:userName]){
        [STUserDefaults saveKeyValue:UD_SETTING value:LIMIT_CLOSE];
    }else{
        [STUserDefaults saveKeyValue:UD_SETTING value:LIMIT_OPEN];
    }
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    dic[@"username"] = userName;
    dic[@"password"] = password;
    WS(weakSelf)
    [STNetUtil post:URL_LOGIN content:dic.mj_JSONString success:^(RespondModel *respondModel) {
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
            [weakSelf.delegate onRequestSuccess:respondModel data:data];
        }else{
            [weakSelf.delegate onRequestFail:respondModel.msg];
        }
        
    } failure:^(int errorCode) {
        [weakSelf.delegate onRequestFail:[NSString stringWithFormat:MSG_ERROR,errorCode]];
    }];
}





//类型，0：超级管理员（admin），1:普通管理员 2：代理商业务员，3：商户业务员

-(void)goForgetPswPage{
    if(_delegate){
        [_delegate goNextPage];
    }
}


-(void)goAgreementPage{
    if(_delegate){
        [_delegate onGoAgreementPage];
    }
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

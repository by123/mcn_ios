
//
//  ChangeAccountViewModel.m
//  manage
//
//  Created by by.huang on 2019/09/03.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ChangeAccountViewModel.h"
#import "AccountManager.h"
#import "STNetUtil.h"

@interface ChangeAccountViewModel()


@end

@implementation ChangeAccountViewModel : NSObject

-(instancetype)init{
    if(self == [super init]){
        _datas = [[AccountManager sharedAccountManager]getAllAccount];
    }
    return self;
}


-(void)clearUser:(NSInteger)tag{
    [[AccountManager sharedAccountManager] removeAccount:[_datas objectAtIndex:tag]];
    _datas = [[AccountManager sharedAccountManager]getAllAccount];
    if(_delegate){
        [_delegate onClearUser];
    }
}

-(void)changeAccount:(NSInteger)tag{
    UserModel *userModel =  [_datas objectAtIndex:tag];
    [[AccountManager sharedAccountManager] clearUserModel];
    if(!_delegate) return;
    [_delegate onRequestBegin];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    dic[@"authToken"] = userModel.authToken;
    WS(weakSelf)
    [STNetUtil post:URL_LOGIN_BY_TOKEN content:dic.mj_JSONString success:^(RespondModel *respondModel) {
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
            [self bindUmengMessage];
            [weakSelf.delegate onRequestSuccess:respondModel data:data];
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

-(void)addNewAccount{
    if(_delegate){
        [[AccountManager sharedAccountManager] clearUserModel];
        [_delegate onAddNewAccount];
    }
}
@end

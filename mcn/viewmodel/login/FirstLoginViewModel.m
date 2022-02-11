
//
//  FirstLoginViewModel.m
//  manage
//
//  Created by by.huang on 2019/09/03.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FirstLoginViewModel.h"
#import "STNetUtil.h"
#import "AccountManager.h"

@interface FirstLoginViewModel()


@end

@implementation FirstLoginViewModel : NSObject


- (void)requestChange:(NSString *)newPwd{
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    dic[@"newPassword"] = newPwd;
    WS(weakSelf)
    [STNetUtil post:URL_CHANGEPWD content:dic.mj_JSONString success:^(RespondModel *respondModel) {
        if([respondModel.status isEqualToString:STATU_SUCCESS]){
            UserModel *model = [[AccountManager sharedAccountManager] getUserModel];
            model.isFirst = 0;
            [[AccountManager sharedAccountManager]saveUserModel:model];
            [weakSelf.delegate onRequestSuccess:respondModel data:respondModel.data];
        }else{
            [weakSelf.delegate onRequestFail:respondModel.msg];
        }
    } failure:^(int errorCode) {
        [weakSelf.delegate onRequestFail:[NSString stringWithFormat:MSG_ERROR,errorCode]];
    }];
}

@end




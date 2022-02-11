//
//  ChangePwdViewModel.m
//  cigarette
//
//  Created by xiao ming on 2019/12/16.
//  Copyright © 2019 by.huang. All rights reserved.
//

#import "ChangePwdViewModel.h"
#import "STNetUtil.h"

@implementation ChangePwdViewModel

- (void)requestChange:(NSString *)oldPwd newPwd:(NSString *)newPwd {
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    dic[@"newPassword"] = newPwd;
    dic[@"oriPassword"] = oldPwd;
    
    WS(weakSelf)
    [STNetUtil post:URL_CHANGEPWD content:dic.mj_JSONString success:^(RespondModel *respondModel) {
        if([respondModel.status isEqualToString:STATU_SUCCESS]){
            weakSelf.isSuccess = true;
        }else{
            weakSelf.isSuccess = false;
        }
    } failure:^(int errorCode) {
        weakSelf.isSuccess = false;
    }];
}

@end

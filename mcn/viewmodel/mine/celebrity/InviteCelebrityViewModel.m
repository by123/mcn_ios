
//
//  InviteCelebrityViewModel.m
//  manage
//
//  Created by by.huang on 2019/09/03.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "InviteCelebrityViewModel.h"
#import "STNetUtil.h"
#import "AccountManager.h"

@interface InviteCelebrityViewModel()


@end

@implementation InviteCelebrityViewModel : NSObject

-(instancetype)init{
    if(self == [super init]){
        _model = [[CelebrityModel alloc]init];
    }
    return self;
}

-(void)inviteCelebrity{
    if(!_delegate) return;
    [_delegate onRequestBegin];
    UserModel *userModel = [[AccountManager sharedAccountManager] getUserModel];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    dic[@"fromMchId"] = userModel.mchId;
    dic[@"anchorMobile"] = _model.anchorMobile;
    dic[@"anchorName"] = _model.anchorName;
    dic[@"allocateRatio"] = @(_model.allocateRatio);
    dic[@"inviteType"] = @(1);
    WS(weakSelf)
    [STNetUtil post:URL_MCHINVITE_ADD content:dic.mj_JSONString success:^(RespondModel *respondModel) {
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



@end




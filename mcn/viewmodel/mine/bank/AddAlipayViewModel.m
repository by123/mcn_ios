
//
//  AddAlipayViewModel.m
//  manage
//
//  Created by by.huang on 2019/09/03.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AddAlipayViewModel.h"
#import "STNetUtil.h"
#import "AccountManager.h"

@interface AddAlipayViewModel()


@end

@implementation AddAlipayViewModel : NSObject

-(instancetype)init{
    if(self == [super init]){
        _datas = [[NSMutableArray alloc]init];
    }
    return self;
}


-(void)addAlipay:(NSString *)account name:(NSString *)name{
    if(!_delegate) return;
    [_delegate onRequestBegin];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    dic[@"bankId"] = account;
    dic[@"accountName"] = name;
    UserModel *userModel = [[AccountManager sharedAccountManager]getUserModel];
    if(userModel.roleType == RoleType_Celebrity){
        dic[@"isPublic"] = @(BankType_Alipay_Personal);
    }else{
        dic[@"isPublic"] = @(BankType_Alipay_Public);
    }
    WS(weakSelf)
    [STNetUtil post:URL_BANK_ADD content:dic.mj_JSONString success:^(RespondModel *respondModel) {
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





//
//  AddPublickBankViewModel.m
//  manage
//
//  Created by by.huang on 2019/09/03.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AddPublickBankViewModel.h"
#import "STNetUtil.h"

@interface AddPublickBankViewModel()


@end

@implementation AddPublickBankViewModel : NSObject

-(instancetype)init{
    if(self == [super init]){
        _model = [[BankModel alloc]init];
    }
    return self;
}

-(void)addBank{
    if(!_delegate) return;
    [_delegate onRequestBegin];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    dic[@"bankId"] = _model.bankId;
    dic[@"bankCode"] = _model.bankCode;
    dic[@"bankName"] = _model.bankName;
    dic[@"accountName"] = _model.accountName;
    dic[@"bankBranch"] = _model.bankBranch;
    dic[@"isPublic"] = @(BankType_Bank_Public);
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




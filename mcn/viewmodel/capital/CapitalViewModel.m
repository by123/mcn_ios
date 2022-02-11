
//
//  CapitalViewModel.m
//  manage
//
//  Created by by.huang on 2019/09/03.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CapitalViewModel.h"
#import "STNetUtil.h"

@interface CapitalViewModel()

@property(assign, nonatomic)int currentPage;

@end

@implementation CapitalViewModel : NSObject

-(instancetype)init{
    if(self == [super init]){
        _currentPage = 1;
        _model = [[CapitalModel alloc]init];
    }
    return self;
}


//基本数据
-(void)requestCapital{
    if(!_delegate) return;
    [_delegate onRequestBegin];
    WS(weakSelf)
    [STNetUtil get:URL_BALANCE parameters:nil success:^(RespondModel *respondModel) {
        if([respondModel.status isEqualToString:STATU_SUCCESS]){
            CapitalRespondModel *tempModel = [CapitalRespondModel mj_objectWithKeyValues:respondModel.data];
            weakSelf.model = [CapitalModel mj_objectWithKeyValues:tempModel.disDetailMchRespVo];
            CapitalModel *mchModel = [CapitalModel mj_objectWithKeyValues:tempModel.mchBalanceRespVo];
            weakSelf.model.actualCanWithdrawNum = mchModel.actualCanWithdrawNum;
            weakSelf.model.canWithdrawNum =  mchModel.canWithdrawNum;
            weakSelf.model.freezeMoney = mchModel.freezeMoney;
            [weakSelf.delegate onRequestSuccess:respondModel data:respondModel.data];
        }else{
            [weakSelf.delegate onRequestFail:respondModel.msg];
        }
        
    } failure:^(int errorCode) {
        [weakSelf.delegate onRequestFail:[NSString stringWithFormat:MSG_ERROR,errorCode]];
    }];
}




@end




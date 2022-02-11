
//
//  WithdrawViewModel.m
//  manage
//
//  Created by by.huang on 2019/09/03.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WithdrawViewModel.h"
#import "STNetUtil.h"

@interface WithdrawViewModel()


@end

@implementation WithdrawViewModel : NSObject

-(instancetype)init{
    if(self == [super init]){
        _datas = [[NSMutableArray alloc]init];
        _bankModel = [[BankModel alloc]init];
        _capitalModel = [[CapitalModel alloc]init];
        _tipsModel = [[WithdrawTipsModel alloc]init];
    }
    return self;
}


-(void)requestBankList{
    if(!_delegate)  return;
      [_delegate onRequestBegin];
      WS(weakSelf)
      [STNetUtil get:URL_BANK_LIST parameters:nil success:^(RespondModel *respondModel) {
          if([respondModel.status isEqualToString:STATU_SUCCESS]){
              NSMutableArray *datas = [BankModel mj_objectArrayWithKeyValuesArray:respondModel.data];
              if(!IS_NS_COLLECTION_EMPTY(datas)){
                  weakSelf.bankModel = datas[0];
                  [weakSelf requestWithdrawConfig];
              }
              [weakSelf.delegate onRequestSuccess:respondModel data:respondModel.data];
          }else{
              [weakSelf.delegate onRequestFail:respondModel.msg];
          }
      } failure:^(int errorCode) {
          [weakSelf.delegate onRequestFail:[NSString stringWithFormat:MSG_ERROR,errorCode]];
      }];
}


-(void)goBankPage:(Boolean)isSelect{
    if(_delegate){
        [_delegate onGoBankPage:isSelect];
    }
}

-(void)requestWithdraw{
    if(!_delegate) return;
    [_delegate onRequestBegin];
    WS(weakSelf)
    [STNetUtil get:URL_BALANCE parameters:nil success:^(RespondModel *respondModel) {
        if([respondModel.status isEqualToString:STATU_SUCCESS]){
            CapitalRespondModel *tempModel = [CapitalRespondModel mj_objectWithKeyValues:respondModel.data];
            weakSelf.capitalModel = [CapitalModel mj_objectWithKeyValues:tempModel.mchBalanceRespVo];
            [weakSelf.delegate onRequestSuccess:respondModel data:respondModel.data];
        }else{
            [weakSelf.delegate onRequestFail:respondModel.msg];
        }
        
    } failure:^(int errorCode) {
        [weakSelf.delegate onRequestFail:[NSString stringWithFormat:MSG_ERROR,errorCode]];
    }];
}

-(void)requestWithdrawConfig{
    if(!_delegate)  return;
    [_delegate onRequestBegin];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    dic[@"bankId"] = _bankModel.bid;
    WS(weakSelf)
    [STNetUtil get:URL_WITHDRAW_CONFIG_TIPS parameters:dic success:^(RespondModel *respondModel) {
        if([respondModel.status isEqualToString:STATU_SUCCESS]){
            weakSelf.tipsModel = [WithdrawTipsModel mj_objectWithKeyValues:respondModel.data];
            [weakSelf.delegate onRequestSuccess:respondModel data:respondModel.data];
        }else{
            [weakSelf.delegate onRequestFail:respondModel.msg];
        }
    } failure:^(int errorCode) {
        [weakSelf.delegate onRequestFail:[NSString stringWithFormat:MSG_ERROR,errorCode]];
    }];
}

-(void)doWithdraw:(double)money{
    
    if(!_delegate) return;
    [_delegate onRequestBegin];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    dic[@"bankId"] = _bankModel.bid;
    dic[@"money"] = @(money * 100);
    WS(weakSelf)
    [STNetUtil post:URL_WITHDRAW_BALANCE content:dic.mj_JSONString success:^(RespondModel *respondModel) {
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




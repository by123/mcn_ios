
//
//  PartnerMcnViewModel.m
//  manage
//
//  Created by by.huang on 2019/09/03.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PartnerMcnViewModel.h"
#import "STNetUtil.h"

@interface PartnerMcnViewModel()


@end

@implementation PartnerMcnViewModel : NSObject

-(instancetype)init{
    if(self == [super init]){
        _model = [[AuthUserModel alloc]init];
        _datas = [[NSMutableArray alloc]init];
    }
    return self;
}

-(void)requestDetail{
    if(!_delegate)  return;
    [_delegate onRequestBegin];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    dic[@"mchId"] = _mchId;
    WS(weakSelf)
    [STNetUtil get:URL_MCH_AUTHENTICATE_INFO parameters:dic success:^(RespondModel *respondModel) {
        if([respondModel.status isEqualToString:STATU_SUCCESS]){
            weakSelf.model = [AuthUserModel mj_objectWithKeyValues:respondModel.data];
            [weakSelf requestCelebrityList];
        }else{
            [weakSelf.delegate onRequestFail:respondModel.msg];
        }
    } failure:^(int errorCode) {
        [weakSelf.delegate onRequestFail:[NSString stringWithFormat:MSG_ERROR,errorCode]];
    }];
}

-(void)requestCelebrityList{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    dic[@"mchId"] = _mchId;
    WS(weakSelf)
    [STNetUtil get:URL_MCN_CELEBRITY_LIST parameters:dic success:^(RespondModel *respondModel) {
        if([respondModel.status isEqualToString:STATU_SUCCESS]){
            weakSelf.datas = [AuthUserModel mj_objectArrayWithKeyValuesArray:respondModel.data];
            [weakSelf.delegate onRequestSuccess:respondModel data:respondModel.data];
        }else{
            [weakSelf.delegate onRequestFail:respondModel.msg];
        }
    } failure:^(int errorCode) {
        [weakSelf.delegate onRequestFail:[NSString stringWithFormat:MSG_ERROR,errorCode]];
    }];

}


@end




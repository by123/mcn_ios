
//
//  SelectCelebrityViewModel.m
//  manage
//
//  Created by by.huang on 2019/09/03.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SelectCelebrityViewModel.h"
#import "STNetUtil.h"
#import "AccountManager.h"

@interface SelectCelebrityViewModel()


@end

@implementation SelectCelebrityViewModel : NSObject

-(instancetype)init{
    if(self == [super init]){
        _datas = [[NSMutableArray alloc]init];
    }
    return self;
}

-(void)requestList{
    if(!_delegate) return;
    [_delegate onRequestBegin];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    UserModel *userModel = [[AccountManager sharedAccountManager] getUserModel];
    dic[@"parentMchId"] = userModel.mchId;
    WS(weakSelf)
    [STNetUtil post:URL_CELEBRITY_LIST content:dic.mj_JSONString success:^(RespondModel *respondModel) {
        if([respondModel.status isEqualToString:STATU_SUCCESS]){
            id data = respondModel.data;
            id datas = [data objectForKey:@"records"];
            weakSelf.datas = [CelebrityModel mj_objectArrayWithKeyValuesArray:datas];
            if(!IS_NS_COLLECTION_EMPTY(weakSelf.datas)){
                for(CelebrityModel *model in weakSelf.datas){
                    if(!IS_NS_COLLECTION_EMPTY(weakSelf.celebrityModel.datas)){
                        for(CelebrityModel *tempModel in weakSelf.celebrityModel.datas){
                            if([tempModel.mchId isEqualToString:model.mchId]){
                                model.isSelect = tempModel.isSelect;
                            }
                        }
                    }
                }
            }
            [weakSelf.delegate onRequestSuccess:respondModel data:data];
        }else{
            [weakSelf.delegate onRequestFail:respondModel.msg];
        }
        
    } failure:^(int errorCode) {
        [weakSelf.delegate onRequestFail:[NSString stringWithFormat:MSG_ERROR,errorCode]];
    }];
}

-(void)backCooperationPage:(NSMutableArray *)celebrityDatas{
    if(_delegate){
        [_delegate onBackCooperationPage:celebrityDatas];
    }
}


@end




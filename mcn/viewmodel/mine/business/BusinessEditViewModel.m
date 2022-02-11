
//
//  BusinessEditViewModel.m
//  manage
//
//  Created by by.huang on 2019/09/03.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BusinessEditViewModel.h"
#import "STNetUtil.h"
#import "AccountManager.h"

@interface BusinessEditViewModel()


@end

@implementation BusinessEditViewModel : NSObject

-(instancetype)init{
    if(self == [super init]){
        _model = [[BusinessModel alloc]init];
    }
    return self;
}


-(void)requestDetail{
    if(!_delegate)  return;
    [_delegate onRequestBegin];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    if(IS_NS_STRING_EMPTY(_mchId)){
        UserModel *userModel = [[AccountManager sharedAccountManager] getUserModel];
        dic[@"mchId"] = userModel.mchId;
    }else{
        dic[@"mchId"] = _mchId;
    }
    WS(weakSelf)
    [STNetUtil get:URL_MCH_MY_CARD parameters:dic success:^(RespondModel *respondModel) {
        if([respondModel.status isEqualToString:STATU_SUCCESS]){
            weakSelf.model = [BusinessModel mj_objectWithKeyValues:respondModel.data];
            [weakSelf.delegate onRequestSuccess:respondModel data:respondModel.data];
        }else{
            [weakSelf.delegate onRequestFail:respondModel.msg];
        }
    } failure:^(int errorCode) {
        [weakSelf.delegate onRequestFail:[NSString stringWithFormat:MSG_ERROR,errorCode]];
    }];
}


-(void)requestEdit{
    if(!_delegate) return;
    [_delegate onRequestBegin];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    dic[@"mchId"] = _mchId;
//    dic[@"mobile"] = _model.contactPhone;
    dic[@"name"] = _model.mchName;
    dic[@"douyinAccount"] = _model.douyinAccount;
    dic[@"kuaishouAccount"] = _model.kuaishouAccount;
    dic[@"picUrl"] = _model.picUrl;
    WS(weakSelf)
    [STNetUtil post:URL_MCH_CARD_MOD content:dic.mj_JSONString success:^(RespondModel *respondModel) {
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

-(void)selectImage{
    if(_delegate){
        [_delegate onSelectImage];
    }
}

-(void)goUpdatePhonePage{
    if(_delegate){
        [_delegate onGoUpdatePhonePage];
    }
}

-(void)updateLoadFile:(UIImage *)image{
    WS(weakSelf)
    [STNetUtil upload:image url:URL_UPLOAD_FILE_PUBLIC success:^(RespondModel *respondModel) {
        if([respondModel.status isEqualToString:STATU_SUCCESS]){
            id data = respondModel.data;
            [weakSelf.delegate onRequestSuccess:respondModel data:data];
            weakSelf.model.picUrl = data;
            [weakSelf getFileUrl:data];
        }else{
            [weakSelf.delegate onRequestFail:respondModel.msg];
        }
    } failure:^(int errorCode) {
        [weakSelf.delegate onRequestFail:[NSString stringWithFormat:MSG_ERROR,errorCode]];
    }];
}

-(void)getFileUrl:(NSString *)fileName{
    if(!_delegate)  return;
    [_delegate onRequestBegin];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    dic[@"fileName"] = fileName;
    WS(weakSelf)
    [STNetUtil get:URL_GET_FILE_PUBLIC parameters:dic success:^(RespondModel *respondModel) {
        if([respondModel.status isEqualToString:STATU_SUCCESS]){
            [weakSelf.delegate onRequestSuccess:respondModel data:respondModel.data];
        }else{
            [weakSelf.delegate onRequestFail:respondModel.msg];
        }
    } failure:^(int errorCode) {
        [weakSelf.delegate onRequestFail:[NSString stringWithFormat:MSG_ERROR,errorCode]];
    }];
}

@end




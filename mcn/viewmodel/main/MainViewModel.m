
//
//  MainViewModel.m
//  manage
//
//  Created by by.huang on 2019/09/03.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MainViewModel.h"
#import "STNetUtil.h"
#import "AccountManager.h"

@interface MainViewModel()


@end

@implementation MainViewModel : NSObject

-(instancetype)init{
    if(self == [super init]){
        _datas = [[NSMutableArray alloc]init];
    }
    return self;
}


-(void)loginByToken{
    if(!_delegate) return;
    [_delegate onRequestBegin];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    UserModel *userModel = [[AccountManager sharedAccountManager] getUserModel];
    dic[@"authToken"] = userModel.authToken;
    WS(weakSelf)
    [STNetUtil post:URL_LOGIN_BY_TOKEN content:dic.mj_JSONString success:^(RespondModel *respondModel) {
        if([respondModel.status isEqualToString:STATU_SUCCESS]){
            id data = respondModel.data;
            id user = [data objectForKey:@"businessUser"];
            id mch = [data objectForKey:@"mch"];
            UserModel *model = [UserModel mj_objectWithKeyValues:user];
            model.authToken = [data objectForKey:@"authToken"];
            model.roleIdSet = [data objectForKey:@"roleIdSet"];
            model.mchId = [mch objectForKey:@"mchId"];
            model.mchType = [[mch objectForKey:@"mchType"] intValue];
            model.authenticateState = [[mch objectForKey:@"authenticateState"] intValue];
            model.parentMchId = [mch objectForKey:@"parentMchId"];
            model.parentMchName = [mch objectForKey:@"parentMchName"];
            model.avatar = [mch objectForKey:@"avatar"];
            if(!IS_NS_COLLECTION_EMPTY(model.roleIdSet)){
                model.roleType = [model.roleIdSet[0] intValue];
            }
            [[AccountManager sharedAccountManager]saveUserModel:model];
            [weakSelf.delegate onRequestSuccess:respondModel data:data];
        }else{
            [weakSelf.delegate onRequestFail:respondModel.msg];
        }
        
    } failure:^(int errorCode) {
        [weakSelf.delegate onRequestFail:[NSString stringWithFormat:MSG_ERROR,errorCode]];
    }];
}

-(void)goSettingPage{
    if(_delegate){
        [_delegate onGoSettingPage];
    }
}

-(void)goPartnerPage:(PartnerType)type{
    if(_delegate){
        [_delegate onGoPartnerPage:type];
    }
}

-(void)goBusinessPage:(NSString *)mchId isEdit:(Boolean)isEdit{
    if(_delegate){
        [_delegate onGoBusinessPage:mchId isEdit:isEdit];
    }
}

-(void)goPartnerMerchantPage:(NSString *)mchId{
    if(_delegate){
        [_delegate onGoPartnerMerchantPage:mchId];
    }
}


-(void)goCelebrityPage{
    if(_delegate){
        [_delegate onGoCelebrityPage];
    }
}

-(void)goQualificationsPage{
    if(!_delegate) return;
    [_delegate onRequestBegin];
    WS(weakSelf)
    [STNetUtil post:URL_MCH_MY_AUTHENTICATE content:nil success:^(RespondModel *respondModel) {
        if([respondModel.status isEqualToString:STATU_SUCCESS]){
            QulificationsModel *model = [QulificationsModel mj_objectWithKeyValues:respondModel.data];
            if(IS_NS_STRING_EMPTY(model.idcardBackFullUrl) || IS_NS_STRING_EMPTY(model.idcardHeadFullUrl)){
                [weakSelf.delegate onGoQualificationsPage];
            }else{
                [weakSelf.delegate onGoQualificationsEditPage:model];
            }
            [weakSelf.delegate onRequestSuccess:respondModel data:respondModel.data];
        }else{
            [weakSelf.delegate onRequestFail:respondModel.msg];
        }
        
    } failure:^(int errorCode) {
        [weakSelf.delegate onRequestFail:[NSString stringWithFormat:MSG_ERROR,errorCode]];
    }];
}

-(void)goBankPage{
    if(_delegate){
        [_delegate onGoBankPage];
    }
}

-(void)goAddressPage{
    if(_delegate){
        [_delegate onGoAddressPage];
    }
}

- (void)goWithdrawPage{
    if(_delegate){
        [_delegate onGoWithdrawPage];
    }
}

-(void)goMsgDetailPage:(NSString *)msgId{
    if(_delegate){
        [_delegate onGoMsgDetailPage:msgId];
    }
}

-(void)goProductPage:(NSString *)skuId{
    if(_delegate){
        [_delegate onGoProductPage:skuId];
    }
}

-(void)goCooperationPage:(NSMutableArray *)datas{
    if(_delegate){
        [_delegate onGoCooperationPage:datas];
    }
}


-(void)hiddenBottomView:(Boolean)hidden{
    if(_delegate){
        [_delegate onHiddenBottomView:hidden];
    }
}

-(void)goHomeSearchPage{
    if(_delegate){
        [_delegate onGoHomeSearchPage];
    }
}


-(void)goAddProductPage{
    if(_delegate){
        [_delegate onGoAddProductPage];
    }
}


-(void)goCapitalDetailPage:(NSString *)listId{
    if(_delegate){
        [_delegate onGoCapitalDetailPage:listId];
    }
}

-(void)goWithdrawListPage{
    if(_delegate){
        [_delegate onGoWithdrawListPage];
    }
}

-(void)goStaticticsPage:(StaticticsType)type{
    if(_delegate){
        [_delegate onGoStaticticsPage:type];
    }
}

@end




//
//  CollapsibleViewModel.m
//  TreasureChest
//
//  Created by xiao ming on 2019/12/19.
//  Copyright © 2019 xiao ming. All rights reserved.
//

#import "CollapsibleViewModel.h"
#import "MJExtension.h"
#import "STNetUtil.h"
#import "AccountManager.h"

@interface CollapsibleViewModel()
@property(strong, nonatomic)CollapsibleModel *targetModel;
@end

@implementation CollapsibleViewModel{
    bool bool_true;
    bool bool_false;
}

- (instancetype)init {
    if(self == [super init]){
        bool_true = true;
        bool_false = false;
        self.subMchType = @3;
    }
    return self;
}

//请求root层数据
- (void)requestRootItemsData {
    
    NSMutableDictionary *dic = [self paraAssembly:nil];
    
    NSString *url = URL_ORDER_ALL_SUBLIST;
    
    WS(weakSelf)
    [STNetUtil get:url parameters:dic success:^(RespondModel *respondModel) {
        if([respondModel.status isEqualToString:STATU_SUCCESS]){
            weakSelf.rootItems = [CollapsibleModel mj_objectArrayWithKeyValuesArray:respondModel.data];
        }else{
            weakSelf.failMsg = respondModel.msg;
        }
        
    } failure:^(int errorCode) {
        weakSelf.failMsg = [NSString stringWithFormat:MSG_ERROR,errorCode];
    }];
}

//请求sub层数据
- (void)requestSubDataForTargetModel:(CollapsibleModel *)targetModel {
    //保持这个model;数据来了后，往sub里面插入。
    NSMutableDictionary *dic = [self paraAssembly:targetModel];
    self.targetModel = targetModel;
    if(_isOrder){
        dic[@"isSkipLevel"] = @(bool_true);
    }else{
        dic[@"isSkipLevel"] = @(bool_false);
    }
    
    WS(weakSelf)
    [STNetUtil get:URL_ORDER_ALL_SUBLIST parameters:dic success:^(RespondModel *respondModel) {
        if([respondModel.status isEqualToString:STATU_SUCCESS]){
            weakSelf.targetModel.subs = [CollapsibleModel mj_objectArrayWithKeyValuesArray:respondModel.data];
            weakSelf.rootItems = weakSelf.rootItems;//触发RAC
        }else{
            weakSelf.failMsg = respondModel.msg;
        }
        
    } failure:^(int errorCode) {
        weakSelf.failMsg = [NSString stringWithFormat:MSG_ERROR,errorCode];
    }];
}

- (NSMutableDictionary *)paraAssembly:(CollapsibleModel *)model {
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    if(_isOrder){
        dic[@"isSkipLevel"] = @(bool_true);
    }else{
        dic[@"isSkipLevel"] = @(bool_false);
    }
    
    if (model.mchId == nil || model.mchId.length == 0) {
        UserModel *userModel =[[AccountManager sharedAccountManager]getUserModel];
        //第一级：subMchId传自己的mchId
        dic[@"subMchId"] = userModel.mchId;
        if (_subMchType == 4) {
            dic[@"subMchType"] = @(self.subMchType);
        }
        return dic;
    }
    
    if (_subMchType == 4) {
        dic[@"subMchId"] = model.mchId;
        dic[@"subMchType"] = @(self.subMchType);
    }else {
        if (model.mchType == -1) {
            dic[@"subMchId"] = model.mchId;
            dic[@"subMchType"] = @(self.subMchType);
        }else {
            dic[@"subMchId"] = model.mchId;
        }
    }
    
    return dic;
}

@end

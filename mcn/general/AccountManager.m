//
//  AccountManager.m
//  framework
//
//  Created by 黄成实 on 2018/4/24.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "AccountManager.h"
#import "STUserDefaults.h"

@implementation AccountManager
SINGLETON_IMPLEMENTION(AccountManager)


///
-(void)saveUserModel:(UserModel *)model{
    [STUserDefaults saveModel:UD_USERMODEL model:model];
    NSMutableArray *models = [self getAllAccount];
    if(!IS_NS_COLLECTION_EMPTY(models)){
        for(UserModel *userModel in models){
            if([userModel.userId isEqualToString:model.userId]){
                [self removeAccount:userModel];
            }
        }
    }
    [self addAccount:model];
}

-(UserModel *)getUserModel{
    if([STUserDefaults getModel:UD_USERMODEL]){
        return [STUserDefaults getModel:UD_USERMODEL];
    }
    return [UserModel new];
}

-(void)clearUserModel{
    [STUserDefaults removeModel:UD_USERMODEL];
}


-(Boolean)isLogin{
    UserModel *model = [self getUserModel];
    if(model && !IS_NS_STRING_EMPTY(model.authToken) && !IS_NS_STRING_EMPTY(model.userId)){
        return YES;
    }
    return NO;
}

-(void)refreshToken{
    //todo
}


//添加一个账户
-(void)addAccount:(UserModel *)model{
    NSMutableArray *datas = [self getAllAccount];
    [datas insertObject:model atIndex:0];
    [STUserDefaults saveModel:UD_ALL_ACCOUNT model:datas];
}

//移除一个账户
-(void)removeAccount:(UserModel *)model{
    NSMutableArray *models = [self getAllAccount];
       if(!IS_NS_COLLECTION_EMPTY(models)){
        for(UserModel *userModel in models){
            if([userModel.userId isEqualToString:model.userId]){
                [models removeObject:userModel];
                break;
            }
        }
    }
    [STUserDefaults saveModel:UD_ALL_ACCOUNT model:models];
}

//获取所有账户
-(NSMutableArray *)getAllAccount{
    if([STUserDefaults getModel:UD_ALL_ACCOUNT]){
        return [STUserDefaults getModel:UD_ALL_ACCOUNT];
    }
    return [NSMutableArray new];
}

@end

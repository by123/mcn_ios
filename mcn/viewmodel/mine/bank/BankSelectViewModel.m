
//
//  BankSelectViewModel.m
//  manage
//
//  Created by by.huang on 2019/09/03.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BankSelectViewModel.h"
#import "AccountManager.h"
#import "TitleContentModel.h"

@interface BankSelectViewModel()


@end

@implementation BankSelectViewModel : NSObject

-(instancetype)init{
    if(self == [super init]){
        _datas = [[NSMutableArray alloc]init];
        [self initDatas];
    }
    return self;
}

-(void)initDatas{
    UserModel *userModel = [[AccountManager sharedAccountManager]getUserModel];
    if(userModel.roleType == RoleType_Celebrity){
        [_datas addObject:[TitleContentModel buildModel:IMAGE_WITHDRAW_ALIPAY content:@"个人支付宝" isSelect:YES]];
        [_datas addObject:[TitleContentModel buildModel:IMAGE_WITHDRAW_BANK content:@"个人银行账户" isSelect:NO]];
    }else{
        [_datas addObject:[TitleContentModel buildModel:IMAGE_WITHDRAW_ALIPAY content:@"企业支付宝" isSelect:YES]];
        [_datas addObject:[TitleContentModel buildModel:IMAGE_WITHDRAW_BANK content:@"对公银行账户" isSelect:NO]];
    }
}


-(void)goAddPage:(int)current{
    if(_delegate){
        [_delegate onGoAddPage:current];
    }
}


@end




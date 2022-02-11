
//
//  HomeViewModel.m
//  manage
//
//  Created by by.huang on 2019/09/03.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HomeViewModel.h"
#import "STNetUtil.h"

@interface HomeViewModel()


@end

@implementation HomeViewModel : NSObject

-(instancetype)init{
    if(self == [super init]){
        _categoryDatas = [[NSMutableArray alloc]init];
    }
    return self;
}


-(void)requestGoodsCategory{
    if(!_delegate)  return;
    [_delegate onRequestBegin];
    WS(weakSelf)
    [STNetUtil get:URL_GOODS_CATEGORY parameters:nil success:^(RespondModel *respondModel) {
        if([respondModel.status isEqualToString:STATU_SUCCESS]){
            weakSelf.categoryDatas = [CategoryModel mj_objectArrayWithKeyValuesArray:respondModel.data];
            [weakSelf.delegate onRequestSuccess:respondModel data:respondModel.data];
        }else{
            [weakSelf.delegate onRequestFail:respondModel.msg];
        }
    } failure:^(int errorCode) {
        [weakSelf.delegate onRequestFail:[NSString stringWithFormat:MSG_ERROR,errorCode]];
    }];
}

-(void)requestBanner{
    WS(weakSelf)
    [STNetUtil getConfig:@"mall_banner" success:^(NSString *result) {
        weakSelf.bannerDatas = [BannerModel mj_objectArrayWithKeyValuesArray:result];
        [weakSelf.delegate onUpdateBanner];
    }];
}


@end




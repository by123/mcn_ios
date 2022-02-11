
//
//  HomeSearchViewModel.m
//  manage
//
//  Created by by.huang on 2019/09/03.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HomeSearchViewModel.h"
#import "STNetUtil.h"

@interface HomeSearchViewModel()

@property(assign, nonatomic)int currentPage;

@end

@implementation HomeSearchViewModel : NSObject

-(instancetype)init{
    if(self == [super init]){
        _datas = [[NSMutableArray alloc]init];
        _currentPage = 1;
    }
    return self;
}

-(void)requestGoodsList:(Boolean)isRefreshNew{
    if(!_delegate) return;
    [_delegate onRequestBegin];
    
    if(isRefreshNew){
        _currentPage = 1;
    }
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    dic[@"page"] = @(_currentPage);
    dic[@"size"] = @(XW_PAGESIZE);
    if(!IS_NS_STRING_EMPTY(_key)){
        dic[@"name"] = _key;
    }
    WS(weakSelf)
    [STNetUtil post:URL_GOODS_HOME_LIST content:dic.mj_JSONString success:^(RespondModel *respondModel) {
        if([respondModel.status isEqualToString:STATU_SUCCESS]){
            id data = respondModel.data;
            int pages = [[data objectForKey:@"pages"] intValue];
            int current = [[data objectForKey:@"current"] intValue];
            id datas = [data objectForKey:@"records"];
            NSMutableArray *requestDatas = [ProductModel mj_objectArrayWithKeyValuesArray:datas];
            if(IS_NS_COLLECTION_EMPTY(requestDatas)){
                if(isRefreshNew){
                    //无数据
                    [weakSelf.delegate onRequestNoDatas:YES];
                }else{
                    //没有更多数据
                    [weakSelf.delegate onRequestNoDatas:NO];
                }
            }else{
                if(isRefreshNew){
                    if(pages == current){
                        //下拉刷新，无更多数据
                        weakSelf.datas = requestDatas;
                        [weakSelf.delegate onRequestNoDatas:NO];
                        return;
                    }else{
                        weakSelf.datas = requestDatas;
                    }
                }else{
                    if(pages == current){
                        //上拉加载，无更多数据
                        [weakSelf.datas addObjectsFromArray:requestDatas];
                        [weakSelf.delegate onRequestNoDatas:NO];
                        return;
                    }else{
                        [weakSelf.datas addObjectsFromArray:requestDatas];
                    }
                }
                weakSelf.currentPage ++;
                [weakSelf.delegate onRequestSuccess:respondModel data:data];
            }
        }else{
            [weakSelf.delegate onRequestFail:respondModel.msg];
        }
        
    } failure:^(int errorCode) {
        [weakSelf.delegate onRequestFail:[NSString stringWithFormat:MSG_ERROR,errorCode]];
    }];
}


-(void)goProductDetailPage:(NSString *)skuId{
    if(_delegate){
        [_delegate onGoProductDetailPage:skuId];
    }
}

-(void)goCooperationPage:(NSMutableArray *)datas{
    if(_delegate){
        [_delegate onGoCooperationPage:datas];
    }
}


@end






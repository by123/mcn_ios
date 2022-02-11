//
//  StatisticsItemViewModel.m
//  mcn
//
//  Created by by.huang on 2020/9/11.
//  Copyright © 2020 by.huang. All rights reserved.
//

#import "StatisticsItemViewModel.h"
#import "STNetUtil.h"
@interface StatisticsItemViewModel()

@property(assign, nonatomic)int currentPage;

@end

@implementation StatisticsItemViewModel


-(instancetype)init{
    if(self == [super init]){
        _datas = [[NSMutableArray alloc]init];
    }
    return self;;
}

//合作(渠道)统计
-(void)requestCooperateList{
    if(!_delegate) return;
    [_delegate onRequestBegin];
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    dic[@"startTime"] = [NSString stringWithFormat:@"%@ 00:00:00",_startTime];
    dic[@"endTime"] =  [NSString stringWithFormat:@"%@ 23:59:59",_endTime];
    dic[@"type"] = @(_statisticsType);
    WS(weakSelf)
    [STNetUtil post:URL_STATISTICS_COOPRETA content:dic.mj_JSONString success:^(RespondModel *respondModel) {
        if([respondModel.status isEqualToString:STATU_SUCCESS]){
            id data = respondModel.data;
//            NSString *temp =  @"{\"total\":700,\"natureIncome\":0,\"cooperStaticRespVoList\":[{\"cooperationId\":\"H202009070004577\",\"skuStaticRespVoList\":[{\"spuId\":9,\"spuName\":\"肥龙元气水\",\"total\":700,\"anchorStaticRespVoList\":[{\"anchorName\":\"主播666\",\"mchId\":\"m202009010001919\",\"value\":700}]}],\"total\":700,\"natureIncome\":0}]}";
//            data = [STConvertUtil jsonToDic:temp];
            
            weakSelf.total = [[data objectForKey:@"total"] doubleValue];
            weakSelf.natureIncome = [[data objectForKey:@"natureIncome"] doubleValue];
            id datas = [data objectForKey:@"cooperStaticRespVoList"];
            weakSelf.datas = [StatisticsCooperateModel mj_objectArrayWithKeyValuesArray:datas];
            [weakSelf.delegate onRequestSuccess:respondModel data:data];
        }else{
            [weakSelf.delegate onRequestFail:respondModel.msg];
        }
        
    } failure:^(int errorCode) {
        [weakSelf.delegate onRequestFail:[NSString stringWithFormat:MSG_ERROR,errorCode]];
    }];
}


//产品统计
-(void)requestProductList{
    if(!_delegate) return;
    [_delegate onRequestBegin];
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    dic[@"startTime"] = [NSString stringWithFormat:@"%@ 00:00:00",_startTime];
    dic[@"endTime"] =  [NSString stringWithFormat:@"%@ 23:59:59",_endTime];
    dic[@"type"] = @(_statisticsType);
    WS(weakSelf)
    [STNetUtil post:URL_STATISTICS_PRODUCT content:dic.mj_JSONString success:^(RespondModel *respondModel) {
        if([respondModel.status isEqualToString:STATU_SUCCESS]){
            id data = respondModel.data;
            weakSelf.total = [[data objectForKey:@"total"] doubleValue];
            id datas = [data objectForKey:@"skuStaticRespVos"];
            weakSelf.datas = [StatisticsProductModel mj_objectArrayWithKeyValuesArray:datas];
            [weakSelf.delegate onRequestSuccess:respondModel data:data];
            
        }else{
            [weakSelf.delegate onRequestFail:respondModel.msg];
        }
        
    } failure:^(int errorCode) {
        [weakSelf.delegate onRequestFail:[NSString stringWithFormat:MSG_ERROR,errorCode]];
    }];
}


//主播统计
-(void)requestCelebrityList{
    if(!_delegate) return;
    [_delegate onRequestBegin];
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    dic[@"startTime"] = [NSString stringWithFormat:@"%@ 00:00:00",_startTime];
    dic[@"endTime"] =  [NSString stringWithFormat:@"%@ 23:59:59",_endTime];
    dic[@"type"] = @(_statisticsType);
    WS(weakSelf)
    [STNetUtil post:URL_STATISTICS_CELEBRITY content:dic.mj_JSONString success:^(RespondModel *respondModel) {
        if([respondModel.status isEqualToString:STATU_SUCCESS]){
            id data = respondModel.data;
            weakSelf.total = [[data objectForKey:@"total"] doubleValue];
            id datas = [data objectForKey:@"anchorStaticRespVoList"];
            weakSelf.datas = [StatisticsCelebrityModel mj_objectArrayWithKeyValuesArray:datas];
            [weakSelf.delegate onRequestSuccess:respondModel data:data];
            
        }else{
            [weakSelf.delegate onRequestFail:respondModel.msg];
        }
        
    } failure:^(int errorCode) {
        [weakSelf.delegate onRequestFail:[NSString stringWithFormat:MSG_ERROR,errorCode]];
    }];
}

@end


//
//  PartnerViewModel.m
//  manage
//
//  Created by by.huang on 2019/09/03.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PartnerViewModel.h"

@interface PartnerViewModel()


@end

@implementation PartnerViewModel : NSObject

-(instancetype)init{
    if(self == [super init]){
        _datas = [[NSMutableArray alloc]init];
    }
    return self;
}


-(void)goPartnerDetailPage:(NSString *)cooperationId{
    if(_delegate){
        [_delegate onGoPartnerDetailPage:cooperationId];
    }
}

-(void)goProductDetailPage:(NSString *)skuId{
    if(_delegate){
        [_delegate onGoProductDetailPage:skuId];
    }
}

-(void)goPartnerMerchantPage:(NSString *)supplierId{
    if(_delegate){
        [_delegate onGoPartnerMerchantPage:supplierId];
    }
}


@end




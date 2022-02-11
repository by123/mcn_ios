
//
//  CelebrityViewModel.m
//  manage
//
//  Created by by.huang on 2019/09/03.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CelebrityViewModel.h"

@interface CelebrityViewModel()


@end

@implementation CelebrityViewModel : NSObject

-(instancetype)init{
    if(self == [super init]){
        _datas = [[NSMutableArray alloc]init];
    }
    return self;
}

-(void)goCelebrityDetailPage:(NSString *)mchId type:(int)type operateState:(int)operateState celebrityId:(NSString *)celebrityId{
    if(_delegate){
        [_delegate onGoCelebrityDetailPage:mchId type:type operateState:operateState celebrityId:celebrityId];
    }
}

@end




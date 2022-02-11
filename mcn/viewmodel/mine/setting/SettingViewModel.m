
//
//  SettingViewModel.m
//  manage
//
//  Created by by.huang on 2019/09/03.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SettingViewModel.h"

@interface SettingViewModel()


@end

@implementation SettingViewModel : NSObject

-(instancetype)init{
    if(self == [super init]){
        _datas = [[NSMutableArray alloc]init];
        [_datas addObject:MSG_ABOUT_CHANGEPWD];
        [_datas addObject:MSG_ABOUT_TITLE];
    }
    return self;
}


-(void)logout{
    if(_delegate){
        [_delegate onLogout];
    }
}

-(void)goChangeAccountPage{
    if(_delegate){
        [_delegate onGoChangeAccountPage];
    }
}

-(void)goNextPage:(NSInteger)position{
    if(_delegate){
        [_delegate onGoNextPage:position];
    }
}

@end




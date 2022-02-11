
//
//  QulificationsViewModel.m
//  manage
//
//  Created by by.huang on 2019/09/03.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QulificationsViewModel.h"

@interface QulificationsViewModel()


@end

@implementation QulificationsViewModel : NSObject


-(void)goQulificationsEditPage:(RoleType)roleType{
    if(_delegate){
        [_delegate onGoQulificationsEditPage:roleType];
    }
}


@end




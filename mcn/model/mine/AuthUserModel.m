//
//  AuthUserModel.m
//  mcn
//
//  Created by by.huang on 2020/9/7.
//  Copyright © 2020 by.huang. All rights reserved.
//

#import "AuthUserModel.h"

@implementation AuthUserBaseModel



@end

@implementation AuthUserModel


-(AuthUserBaseModel *)baseModel{
    return [AuthUserBaseModel mj_objectWithKeyValues:_authenticateDataRespVo];
}
@end

//
//  UserModel.m
//  manage
//
//  Created by by.huang on 2018/10/26.
//  Copyright © 2018年 by.huang. All rights reserved.
//

#import "UserModel.h"
#import "AccountManager.h"

@implementation UserModel


-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if(self == [super init]){
        self.authToken = [aDecoder decodeObjectForKey:@"authToken"];
        self.userId = [aDecoder decodeObjectForKey:@"userId"];
        self.mchId = [aDecoder decodeObjectForKey:@"mchId"];
        self.password = [aDecoder decodeObjectForKey:@"password"];
        self.isFirst = (int)[aDecoder decodeIntegerForKey:@"isFirst"];
        self.authenticateState = (int)[aDecoder decodeIntegerForKey:@"authenticateState"];
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.mobile = [aDecoder decodeObjectForKey:@"mobile"];
        self.createTime = [aDecoder decodeObjectForKey:@"createTime"];
        self.modifyTime = [aDecoder decodeObjectForKey:@"modifyTime"];
        self.roleIdSet = [aDecoder decodeObjectForKey:@"roleIdSet"];
        self.roleType = (int)[aDecoder decodeIntegerForKey:@"roleType"];
        self.mchType = (int)[aDecoder decodeIntegerForKey:@"mchType"];
        self.parentMchId = [aDecoder decodeObjectForKey:@"parentMchId"];
        self.parentMchName = [aDecoder decodeObjectForKey:@"parentMchName"];
        self.certType = (int)[aDecoder decodeIntegerForKey:@"certType"];
        self.certNo = [aDecoder decodeObjectForKey:@"certNo"];
        self.lockState = (int)[aDecoder decodeIntegerForKey:@"lockState"];
        self.avatar = [aDecoder decodeObjectForKey:@"avatar"];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder{
    
    [aCoder encodeObject:self.authToken forKey:@"authToken"];
    [aCoder encodeObject:self.userId  forKey:@"userId"];
    [aCoder encodeObject:self.mchId  forKey:@"mchId"];
    [aCoder encodeObject:self.password  forKey:@"password"];
    [aCoder encodeInteger:self.isFirst forKey:@"isFirst"];
    [aCoder encodeInteger:self.authenticateState forKey:@"authenticateState"];
    [aCoder encodeObject:self.name  forKey:@"name"];
    [aCoder encodeObject:self.mobile  forKey:@"mobile"];
    [aCoder encodeObject:self.createTime forKey:@"createTime"];
    [aCoder encodeObject:self.modifyTime forKey:@"modifyTime"];
    [aCoder encodeObject:self.roleIdSet forKey:@"roleIdSet"];
    [aCoder encodeInteger:self.roleType forKey:@"roleType"];
    [aCoder encodeInteger:self.mchType forKey:@"mchType"];
    [aCoder encodeObject:self.parentMchId forKey:@"parentMchId"];
    [aCoder encodeObject:self.parentMchName forKey:@"parentMchName"];
    [aCoder encodeInteger:self.certType forKey:@"certType"];
    [aCoder encodeObject:self.certNo forKey:@"certNo"];
    [aCoder encodeInteger:self.lockState forKey:@"lockState"];
    [aCoder encodeObject:self.avatar forKey:@"avatar"];
}

+(NSString *)getRoleTypeStr:(int)roleType{
    if(roleType == 1) return @"平台管理员";
    else if(roleType == 2) return @"平台业务员";
    else if(roleType == 3) return @"代理商管理员";
    return MSG_EMPTY;
    
}

- (NSString *)token{
    [STLog print:[NSString stringWithFormat:@"token = %@",_authToken]];
    return _authToken;
}

+(Boolean)isFirstAgent:(NSString *)parentMchId{
    if (IS_NS_STRING_EMPTY(parentMchId)) {
        return false;
    }
    return [parentMchId isEqualToString:@"mplat"];
}

+(Boolean)isAllPlat{
    UserModel *model = [[AccountManager sharedAccountManager]getUserModel];
    return [model.mchId isEqualToString:@"mplat"];
}

+ (Boolean)isPlat{
    UserModel *model = [[AccountManager sharedAccountManager]getUserModel];
    return [model.mchId isEqualToString:@"mplat"] && model.mchType == 0;
}


@end

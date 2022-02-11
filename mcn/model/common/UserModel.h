//
//  UserModel.h
//  manage
//
//  Created by by.huang on 2018/10/26.
//  Copyright © 2018年 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface UserModel : NSObject<NSCoding>

@property(copy, nonatomic)NSString *authToken;
@property(strong, nonatomic)NSMutableArray *roleIdSet;
@property(assign, nonatomic)int roleType;

//user
@property(copy, nonatomic)NSString *mchId;
@property(copy, nonatomic)NSString *userId;
@property(copy, nonatomic)NSString *password;
@property(assign, nonatomic)int isFirst;
@property(copy, nonatomic)NSString *name;
@property(assign, nonatomic)int certType;
@property(copy, nonatomic)NSString *certNo;
@property(copy, nonatomic)NSString *mobile;
@property(assign, nonatomic)int lockState;
@property(copy, nonatomic)NSString *createTime;
@property(copy, nonatomic)NSString *modifyTime;

//mch
@property(assign, nonatomic)int mchType;
@property(copy, nonatomic)NSString *avatar;
//是否已认证，0未认证，1已认证，2等待审核，3审核不通过
@property(assign, nonatomic)int authenticateState;
@property(copy, nonatomic)NSString *parentMchId;
@property(copy, nonatomic)NSString *parentMchName;

@end


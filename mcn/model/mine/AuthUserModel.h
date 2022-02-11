//
//  AuthUserModel.h
//  mcn
//
//  Created by by.huang on 2020/9/7.
//  Copyright © 2020 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AuthUserBaseModel : NSObject

@property(copy, nonatomic)NSString *remark;
@property(assign, nonatomic)int authenticateState;

@end

@interface AuthUserModel : NSObject

@property(copy, nonatomic)NSString *mchId;
@property(copy, nonatomic)NSString *mchName;
@property(copy, nonatomic)NSString *picFullUrl;
@property(strong, nonatomic)id authenticateDataRespVo;
@property(strong, nonatomic)AuthUserBaseModel *baseModel;
@property(assign, nonatomic)int sex;

@end

NS_ASSUME_NONNULL_END

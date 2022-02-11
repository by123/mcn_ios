//
//  CelebrityModel.h
//  mcn
//
//  Created by by.huang on 2020/8/31.
//  Copyright © 2020 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CelebrityAuthModel : NSObject

@property(assign, nonatomic)int allocateRatio;
@property(assign, nonatomic)int authenticateState;


@end

@interface CelebrityModel : NSObject

@property(copy, nonatomic)NSString *celebrityId;
@property(assign, nonatomic)int allocateRatio;
@property(copy, nonatomic)NSString *anchorMobile;
@property(copy, nonatomic)NSString *anchorName;
@property(copy, nonatomic)NSString *picFullUrl;
@property(assign, nonatomic)int operateState;
//sex (integer, optional): 性别 0男 1女 ,
@property(assign, nonatomic)int sex;
@property(copy, nonatomic)NSString *fromMchId;
@property(copy, nonatomic)NSString *destMchId;

@property(copy, nonatomic)NSString *mchId;
@property(copy, nonatomic)NSString *mchName;
@property(copy, nonatomic)NSString *contactPhone;
@property(strong, nonatomic)CelebrityAuthModel *authenticateDataRespVo;


//
@property(assign, nonatomic)Boolean isSelect;

@end


NS_ASSUME_NONNULL_END

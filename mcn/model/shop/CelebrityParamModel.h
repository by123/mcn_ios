//
//  CelebrityParamModel.h
//  mcn
//
//  Created by by.huang on 2020/9/5.
//  Copyright © 2020 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CelebrityModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CelebrityParamModel : NSObject

@property(assign, nonatomic)NSInteger position1;
@property(assign, nonatomic)NSInteger position2;
@property(strong, nonatomic)NSMutableArray *datas;
@property(strong, nonatomic)NSMutableArray *allDatas;

@end

NS_ASSUME_NONNULL_END

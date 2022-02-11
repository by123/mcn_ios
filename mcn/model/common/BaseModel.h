//
//  BaseModel.h
//  cigarette
//
//  Created by xiao ming on 2019/12/1.
//  Copyright © 2019 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseModel : NSObject

@property(strong, nonatomic)NSString *failMsg;
@property(assign, nonatomic)BOOL success;
@property(assign, nonatomic)BOOL noMoreData;
@property(assign, nonatomic)BOOL headerRefresh;
@property(assign, nonatomic)int requestPage;

@end

NS_ASSUME_NONNULL_END

//
//  NSArray+DeepCopy.h
//  cigarette
//
//  Created by by.huang on 2019/9/18.
//  Copyright © 2019 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSArray(DeepCopy)

- (instancetype)deepCopy;

@end

NS_ASSUME_NONNULL_END

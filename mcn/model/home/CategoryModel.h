//
//  CategoryModel.h
//  mcn
//
//  Created by by.huang on 2020/8/30.
//  Copyright © 2020 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CategoryModel : NSObject

@property(assign, nonatomic)int categoryId;
@property(copy, nonatomic)NSString *name;
@property(copy, nonatomic)NSString *goodsClass;

@end

NS_ASSUME_NONNULL_END

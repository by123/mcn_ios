//
//  PreviewModel.h
//  mcn
//
//  Created by by.huang on 2020/8/21.
//  Copyright © 2020 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PreviewModel : NSObject

@property(copy, nonatomic)NSString *imgSrc;
@property(copy, nonatomic)NSString *imgUrl;
@property(assign, nonatomic)Boolean isSelect;
@property(assign, nonatomic)NSInteger position;


+(PreviewModel *)build:(NSString *)imgUrl imgSrc:(NSString *)imgSrc isSelect:(Boolean)isSelect;
+(PreviewModel *)build:(NSString *)imgUrl imgSrc:(NSString *)imgSrc isSelect:(Boolean)isSelect position:(NSInteger)position;

@end

NS_ASSUME_NONNULL_END

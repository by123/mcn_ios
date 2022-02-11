//
//  ResourceModel.h
//  cigarette
//
//  Created by xiao ming on 2020/3/26.
//  Copyright © 2020 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ResourceModel : NSObject

- (instancetype)initWithPath:(NSString *)urlPath;
- (instancetype)initWithPath:(NSString *)urlPath fileName:(NSString *)fileName;
- (NSString *)getLocalPath;
- (NSString *)getUrlPath;



///保存新的数据
+ (void)saveResource:(ResourceModel *)resource;



///返回urlPath对应的localPath，如果本地曾经有保存这个urlPath。如果没有，直接返回urlPath。
+ (NSString *)localPathFromUrl:(NSString *)urlPath;



///
+ (ResourceModel *)isResourceExist:(NSString *)urlPath;


@end

NS_ASSUME_NONNULL_END

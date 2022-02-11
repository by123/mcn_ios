//
//  ResourceModel.m
//  cigarette
//
//  Created by xiao ming on 2020/3/26.
//  Copyright © 2020 by.huang. All rights reserved.
//

#import "ResourceModel.h"
#define URLDownloadManagerKey @"URLDownloadManagerKey"
@interface ResourceModel ()

@property(nonatomic, strong)NSString *urlPath;
@property(nonatomic, strong)NSString *fileName;

@end

@implementation ResourceModel

- (instancetype)initWithPath:(NSString *)urlPath {
    return [self initWithPath:urlPath fileName:[self getFileName:urlPath]];
}

- (instancetype)initWithPath:(NSString *)urlPath fileName:(NSString *)fileName {
    if(self == [super init]){
        self.urlPath = urlPath;
        self.fileName = fileName;
    }
    return self;
}

#pragma mark - < 判断是否存在 >
+ (ResourceModel *)isResourceExist:(NSString *)urlPath {
    NSMutableArray *existsResources = [ResourceModel getResources];
    NSMutableArray <ResourceModel *>*resourceModels = [ResourceModel mj_objectArrayWithKeyValuesArray:existsResources];
    for (ResourceModel *model in resourceModels) {
        if ([urlPath containsString:model.fileName] && [self isFileExist:[model getLocalPath]]) {
            return model;
        }
    }
    return nil;
}

+ (BOOL)isFileExist:(NSString *)localPath {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    return [fileManager fileExistsAtPath:localPath];
}

#pragma mark - < get >
+ (NSString *)localPathFromUrl:(NSString *)urlPath {
    NSMutableArray *existResources = [self getResources];
    NSMutableArray <ResourceModel *>*resourceModels = [ResourceModel mj_objectArrayWithKeyValuesArray:existResources];
    for (ResourceModel *model in resourceModels) {
        if ([model.urlPath isEqualToString:urlPath]) {
            return [model getLocalPath];
        }
    }
    return urlPath;
}

- (NSString *)getLocalPath {
    return [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:self.fileName];
}

- (NSString *)getUrlPath {
    return self.urlPath;
}

- (NSString *)getFileName:(NSString *)path {
    NSArray *tmp = [path componentsSeparatedByString:@"/"];
    return [tmp.lastObject stringByRemovingPercentEncoding];//去掉utf8编码并返回
}

#pragma mark - < 存沙盒 >
+ (void)saveResource:(ResourceModel *)resource {
    NSMutableArray *existResources = [self getResources];
    if (![self isResourceExist:resource.urlPath]) {
        [existResources addObject:[resource mj_keyValues]];
        [self saveData:existResources];
    }
}

+ (NSMutableArray *)getResources {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSArray *arr = [userDefaults objectForKey:URLDownloadManagerKey];
    return [NSMutableArray arrayWithArray:arr];
}

+ (void)saveData:(id)data {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:data forKey:URLDownloadManagerKey];
    [userDefaults synchronize];
}

@end

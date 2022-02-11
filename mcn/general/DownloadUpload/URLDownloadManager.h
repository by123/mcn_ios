//
//  URLDownloadManager.h
//  cigarette
//
//  Created by xiao ming on 2020/3/26.
//  Copyright © 2020 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ResourceModel.h"

typedef void (^IsFinishBlock)(ResourceModel *resourceModel);
typedef void (^IsDownloadingBlock)(ResourceModel *resourceModel);

@interface URLDownloadManager : NSObject

@property(nonatomic, strong)UILabel *progressLabel;

+ (instancetype)shareInstance;
- (void)startDownloadResourceWithURLPath:(NSString *)urlPath isDownloadingBlock:(IsDownloadingBlock)downloadingBlock finishBlock:(IsFinishBlock)finishBlock;
- (void)saveToAlbum:(NSString *)localPath;

@end


//
//  URLDownloadManager.m
//  cigarette
//
//  Created by xiao ming on 2020/3/26.
//  Copyright © 2020 by.huang. All rights reserved.
//

#import "URLDownloadManager.h"
#import "URLDownloadTask.h"
#import <Photos/Photos.h>

static URLDownloadManager *manager = nil;

@interface URLDownloadManager () <URLDownloadTaskDelegate>

@property(nonatomic, strong)NSMutableArray <URLDownloadTask *> *tasks;
@property(nonatomic, strong)URLDownloadTask *activityTask;
@property (nonatomic, copy)IsFinishBlock finishBlock;

@end

@implementation URLDownloadManager

+ (instancetype)shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[URLDownloadManager alloc]init];
        manager.tasks = [NSMutableArray arrayWithCapacity:0];
    });
    return manager;
}

- (void)startDownloadResourceWithURLPath:(NSString *)urlPath isDownloadingBlock:(IsDownloadingBlock)downloadingBlock finishBlock:(IsFinishBlock)finishBlock {
    
    self.finishBlock = finishBlock;

    ResourceModel *isTaskExist = [self isTaskExist:urlPath];
    if (isTaskExist) {//提示：这个任务已经存在了
        downloadingBlock(isTaskExist);
    }else {
        ResourceModel *isDownloaded = [ResourceModel isResourceExist:urlPath];
        
        if (isDownloaded) {
            finishBlock(isDownloaded);
        }else {
            [self startDownload:urlPath];
        }
    }
    
    //[[NSUserDefaults standardUserDefaults]removeObjectForKey:@"URLDownloadManagerKey"];//调试
}

- (void)startDownload:(NSString *)urlPath {
    ResourceModel *model = [[ResourceModel alloc]initWithPath:urlPath];

    URLDownloadTask *downloadTask = [[URLDownloadTask alloc]init];
    downloadTask.delegate = self;
    [downloadTask setupTask:model];
    [self.tasks addObject:downloadTask];
    self.activityTask = downloadTask;
}

#pragma mark - < delegate >
- (void)downloadTaskFinish:(URLDownloadTask *)task {
    self.finishBlock(task.resourceModel);
    [ResourceModel saveResource:task.resourceModel];
    [self.progressLabel removeFromSuperview];
    [self.tasks removeObject:task];
    if (self.activityTask == task) {
        self.activityTask = nil;
    }
}

- (void)downloadTaskFail:(URLDownloadTask *)task {
    self.finishBlock(nil);
    [self.tasks removeObject:task];
    if (self.activityTask == task) {
        self.activityTask = nil;
    }
}

- (void)downloadTaskProgress:(URLDownloadTask *)task progress:(CGFloat)progress {
    if (self.activityTask != task) {
        return;
    }
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [[[UIApplication sharedApplication] keyWindow] addSubview:self.progressLabel];
            self.progressLabel.frame = CGRectMake((ScreenWidth - 120)/2.0, (ScreenHeight - 30)/2.0, 120, 30);
            self.progressLabel.text = [NSString stringWithFormat:@"%.1f%%",progress*100];
            self.progressLabel.hidden = (progress >= 1.0);
        });
    });
}

#pragma mark - < private >
- (ResourceModel *)isTaskExist:(NSString *)urlPath {
    for (URLDownloadTask *task in self.tasks) {
        if ([[task.resourceModel getUrlPath] isEqualToString:urlPath]) {
            return task.resourceModel;
        }
    }
    return nil;
}

- (UILabel *)progressLabel {
    if (_progressLabel == nil) {
        _progressLabel = [[UILabel alloc]init];
        _progressLabel.textAlignment = NSTextAlignmentCenter;
        _progressLabel.font = [UIFont fontWithName:FONT_REGULAR size:STFont(13)];
        _progressLabel.textColor = c10;
        _progressLabel.backgroundColor = c11;
    }
    return _progressLabel;
}

#pragma mark - < save to album >
- (void)saveToAlbum:(NSString *)localPath {
    PHPhotoLibrary *photoLibrary = [PHPhotoLibrary sharedPhotoLibrary];
    [photoLibrary performChanges:^{
        [self createRequest:localPath];
    } completionHandler:^(BOOL success, NSError * _Nullable error) {
        NSString *msg = success ? @"已经保存到相册" : @"未能保存视频到相册";
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                [LCProgressHUD showMessage:msg];
            });
        });
    }];
}

- (void)createRequest:(NSString *)path {
//    NSURL *url = [NSURL fileURLWithPath:path];
//    ResourceType type = [AdvertiseModel resourceTypeFromSuffix:path];
//    if (type == ResourceType_video) {
//        [PHAssetChangeRequest creationRequestForAssetFromVideoAtFileURL:url];
//    }else if (type == ResourceType_pic) {
//        [PHAssetChangeRequest creationRequestForAssetFromImageAtFileURL:url];
//    }else {
//
//    }
}
@end



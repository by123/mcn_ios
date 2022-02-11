//
//  URLDownloadTask.h
//  TreasureChest
//
//  Created by xiao ming on 2020/2/25.
//  Copyright © 2020 xiao ming. All rights reserved.
//  断点下载

/**
参考：https://blog.csdn.net/samuelandkevin/article/details/88787798
 
1. 关于Range:
  bytes=0-499 ,从0到499的头500个字节
  bytes=500-999,从500到999的第二个500字节
  bytes=500- ,从500字节以后的所有字节
  bytes=-500, 最后500个字节
  bytes=500-599,800-899 同时指定几个范围

2. NSURLSession有三种任务类型:
  NSURLSessionDataTask : 普通的GET\POST请求
  NSURLSessionDownloadTask : 文件下载
  NSURLSessionUploadTask : 文件上传
 
*/



#import <Foundation/Foundation.h>
#import "ResourceModel.h"
@class URLDownloadTask;

NS_ASSUME_NONNULL_BEGIN
@protocol URLDownloadTaskDelegate <NSObject>

- (void)downloadTaskFinish:(URLDownloadTask *)task;
- (void)downloadTaskFail:(URLDownloadTask *)task;

@optional
- (void)downloadTaskProgress:(URLDownloadTask *)task progress:(CGFloat)progress;

@end

typedef void(^DownloadProgress)(CGFloat progress);
typedef void(^DownloadFail)(void);
typedef void (^EasyDownloadFinishBlock)(NSString *localPath);

@interface URLDownloadTask : NSObject

@property(nonatomic, weak)id<URLDownloadTaskDelegate> delegate;
@property(nonatomic, strong)ResourceModel *resourceModel;

@property (nonatomic, copy)DownloadFail failBlock;
@property (nonatomic, copy)DownloadProgress progressBlock;
@property(nonatomic, strong)NSURLSessionDownloadTask *downloadTask;


- (void)setupTask:(ResourceModel *)resourceModel;
- (void)pauseDownload;
- (void)continueDownload;
- (void)stopDownload;



- (void)easyDownload:(NSString *)urlPath localPath:(NSString *)localPath finishBlock:(EasyDownloadFinishBlock)finishBlock;

@end

NS_ASSUME_NONNULL_END

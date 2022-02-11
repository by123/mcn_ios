//
//  URLDownloadTask.m
//  TreasureChest
//
//  Created by xiao ming on 2020/2/25.
//  Copyright © 2020 xiao ming. All rights reserved.
//

#import "URLDownloadTask.h"

@interface URLDownloadTask()<NSURLSessionDownloadDelegate>

@property(nonatomic, strong)NSURLSession *session;
@property(nonatomic, strong)NSData *resumeData;

@end

@implementation URLDownloadTask

- (instancetype)init {
    if(self == [super init]){
        
    }
    return self;
}

#pragma mark - < public >
- (void)setupTask:(ResourceModel *)resourceModel {
    self.resourceModel = resourceModel;
    NSString *suitablePath = [[resourceModel getUrlPath] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];//将含有中文、特殊字符用UTF8编码
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:suitablePath]];
    self.session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    self.downloadTask = [self.session downloadTaskWithRequest:request];
    [self.downloadTask resume];//开始
}

- (void)pauseDownload {
//    [self.downloadTask suspend];
    [self.downloadTask cancelByProducingResumeData:^(NSData * _Nullable resumeData) {
        self.resumeData = resumeData;
    }];
}

- (void)continueDownload {
    if (self.downloadTask.state == NSURLSessionTaskStateCompleted) {
        if (self.resumeData) {
            //使用resumeData创建一个下载任务。如果无法成功恢复下载，将调用URLSession:task:didCompleteWithError:。
            self.downloadTask = [self.session downloadTaskWithResumeData:self.resumeData];
        }
    }
    [self.downloadTask resume];
}

- (void)stopDownload {
    //不可恢复
    [self.downloadTask cancel];
}

#pragma mark - < delegate >

/**
 * 写数据
 * @param bytesWritten 本次写入数据大小
 * @param totalBytesWritten 下载数据总大小
 * @param totalBytesExpectedToWrite 文件总大小
 */
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite {
    CGFloat progress = 1.0 *totalBytesWritten/totalBytesExpectedToWrite;
    if (self.progressBlock) {
        self.progressBlock(progress);
    }
    if ([self.delegate respondsToSelector:@selector(downloadTaskProgress:progress:)]) {
        [self.delegate downloadTaskProgress:self progress:progress];
    }
    NSLog(@"%.2f%%",100.0 *totalBytesWritten/totalBytesExpectedToWrite);
}

/**
* 恢复下载
* @param fileOffset 恢复从哪里位置下载
* @param expectedTotalBytes 文件总大小
*/
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didResumeAtOffset:(int64_t)fileOffset expectedTotalBytes:(int64_t)expectedTotalBytes {
    
}

/**
 * 下载完成
 * @param location 文件临时存储路径
 */
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location{
    NSURL *destinationUrl = [NSURL fileURLWithPath:[self.resourceModel getLocalPath]];
    BOOL flag = [[NSFileManager defaultManager] moveItemAtURL:location toURL:destinationUrl error:nil];
    if ([self.delegate respondsToSelector:@selector(downloadTaskFinish:)]) {
        [self.delegate downloadTaskFinish:self];
    }
    if (flag) {
        NSLog(@"下载完成，移动成功：移动到目标目录：%@",[self.resourceModel getLocalPath]);
    }else {
        NSLog(@"下载完成，移动失败：源目录%@",location);
    }
}

/**
 * 请求结束
 */
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error{
    if (error == nil) {
        printf("请求成功：结束");
    }else {
        printf("下载失败");
        if ([self.delegate respondsToSelector:@selector(downloadTaskFail:)]) {
            [self.delegate downloadTaskFail:self];
        }
    }
}

#pragma mark - < 便捷下载方式 >
- (void)easyDownload:(NSString *)urlPath localPath:(NSString *)localPath finishBlock:(EasyDownloadFinishBlock)finishBlock {
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlPath]];
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDownloadTask *dataTask = [session downloadTaskWithRequest:request completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error == nil) {
            BOOL flag = [[NSFileManager defaultManager] moveItemAtURL:location toURL:[NSURL fileURLWithPath:localPath] error:nil];
            if (!flag) {
                printf("下载成功，移动文件到目标目录失败");
            }
        }
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                if (error == nil) {
                    finishBlock(localPath);
                }else {
                    finishBlock(@"");
                }
            });
        });
        
    }];
    [dataTask resume];
}

@end

//
//  STNetUtil.m
//  framework
//
//  Created by 黄成实 on 2018/4/18.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "STNetUtil.h"
#import <AFNetworking/AFNetworking.h>
#import "RespondModel.h"
#import <MJExtension/MJExtension.h>
#import "AccountManager.h"
#import "STConvertUtil.h"
#import "STObserverManager.h"
#import "STUserDefaults.h"
#import "LoginPage.h"
#import "STWindowUtil.h"
#import "STShowToast.h"

@implementation STNetUtil

#pragma mark get传参
+(void)get:(NSString *)url parameters:(NSDictionary *)parameters success:(void (^)(RespondModel *))success failure:(void (^)(int))failure{
    AFHTTPSessionManager *manager = [self requestSetting];
    [manager GET:url parameters:parameters headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self handleSuccess:responseObject success:success url:url params:parameters.mj_JSONString];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self handleFail:task.response failure:failure url:url params:parameters.mj_JSONString];
    }];
}


#pragma mark post传参
+ (void)post:(NSString *)url parameters:(NSDictionary *)parameters success:(void (^)(RespondModel *))success failure:(void (^)(int))failure{
    AFHTTPSessionManager *manager = [self requestSetting];
    [manager POST:url parameters:parameters headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self handleSuccess:responseObject success:success url:url params:parameters.mj_JSONString];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self handleFail:task.response failure:failure url:url params:parameters.mj_JSONString];
    }];
}



#pragma mark post传递body
+(void)post:(NSString *)url content:(NSString *)content success:(void (^)(RespondModel *))success failure:(void (^)(int))failure{
    AFHTTPSessionManager *manager = [self requestSetting];
    NSMutableURLRequest *request = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:url parameters:nil error:nil];
    [request addValue:[[AccountManager sharedAccountManager] getUserModel].authToken forHTTPHeaderField:@"authorization"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request addValue:@"ios" forHTTPHeaderField:@"platform"];
    NSData *body  =[content dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:body];
    [[manager dataTaskWithRequest:request uploadProgress:nil downloadProgress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error){
        if(error){
            [self handleFail:response failure:failure url:url params:content];
        }else{
            [self handleSuccess:responseObject success:success url:url params:content];
        }
    }] resume];
}


#pragma mark 上传
+(void)upload:(UIImage *)image url:(NSString *)url success:(void (^)(RespondModel *))success failure:(void (^)(int))errorCode{
    AFHTTPSessionManager *manager = [self requestSetting];
    [manager.requestSerializer setValue:@"multipart/form-data" forHTTPHeaderField:@"Content-Type"];
    NSData *data = UIImageJPEGRepresentation(image,1.0);
    [manager POST:url parameters:nil  headers:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:data name:@"file" fileName:@"upload.png" mimeType:@"image/png"];
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self handleSuccess:responseObject success:success url:url params:nil];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self handleFail:task.response failure:errorCode url:url params:nil];
    }];
}


#pragma mark 下载
+(void)download : (NSString *)url callback : (ByDownloadCallback) callback{
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    NSURL *URL = [NSURL URLWithString:url];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:nil destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        return [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        NSLog(@"File downloaded to: %@", filePath);
    }];
    [downloadTask resume];
}


#pragma mark 成功处理
+(void)handleSuccess:(id)responseObject success:(void (^)(RespondModel *))success url:(NSString *)url params:(NSString *)paramsStr{
    RespondModel *model = [RespondModel mj_objectWithKeyValues:responseObject];
    model.requestUrl = url;
    [STLog print:[NSString stringWithFormat:@"\n------------------------------------------------------------------------\n请求成功\n%@\n%@\n%@ \n------------------------------------------------------------------------",url,paramsStr,[STConvertUtil dataToString:responseObject]]];
    //登录已过期
    if([model.status isEqualToString:STATU_INVALID]){
        LoginPage *page = [[LoginPage alloc]init];
        [[AccountManager sharedAccountManager] clearUserModel];
        [STWindowUtil clearAllAndOpenNewPage:page];//这里可以改成直接用[LoginPage show:]
        return;
    }
    success(model);
    if(!IS_NS_STRING_EMPTY(model.msg) && ![model.msg isEqualToString:@"操作成功"]){
//        [LCProgressHUD showMessage:model.msg];
        [STShowToast show:model.msg];
        [LCProgressHUD hide];
    }else{
        [LCProgressHUD hide];
    }
    [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
}

#pragma mark 请求配置
+(AFHTTPSessionManager *)requestSetting{
    //loading开始
    [LCProgressHUD showLoading:nil];
    //配置请求延迟时间
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 60.f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    UserModel *model = [[AccountManager sharedAccountManager] getUserModel];
    //header
    [manager.requestSerializer setValue:@"ios" forHTTPHeaderField:@"platform"];
    [manager.requestSerializer setValue:model.authToken forHTTPHeaderField:@"authorization"];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [STLog print:[NSString stringWithFormat:@"token = %@",model.authToken]];
    
    //content-type
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/xml",@"text/html", nil ];
    return manager;
}


#pragma mark 失败处理
+(void)handleFail : (NSURLResponse *)response failure:(void (^)(int))failure url:(NSString *)url params:(NSString *)paramsStr{
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)response;
    NSInteger errorCode = httpResponse.statusCode;
    if(errorCode == 502){
        dispatch_main_async_safe(^{
            [LCProgressHUD showMessage:MSG_SERVER_ERROR];
        });
    }else if(errorCode == 0){
        dispatch_main_async_safe(^{
            [LCProgressHUD showMessage:MSG_NET_ERROR];
        });
    }
    [STLog print:[NSString stringWithFormat:@"\n------------------------------------------------------------------------\n请求失败\n%@\n%@\n错误码:%ld\n------------------------------------------------------------------------",url,paramsStr,errorCode]];
    dispatch_main_async_safe(^{
        failure((int)errorCode);
    });
    [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [LCProgressHUD hide];
    });
}



+(Boolean)getNetStatu{
    int netStatu = [[ STUserDefaults getKeyValue:UD_NET_STATU] intValue];
    return (netStatu == 1) ? YES : NO;
}


#pragma mark 监听网络状态
+(void)startListenNetWork{
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if (status == AFNetworkReachabilityStatusUnknown) {
            NSLog(@"当前网络：未知网络");
            [STUserDefaults saveKeyValue:UD_NET_STATU value:@(0)];
            [LCProgressHUD showMessage:MSG_NET_ERROR];
        } else if (status == AFNetworkReachabilityStatusNotReachable) {
            NSLog(@"当前网络：没有网络");
            [STUserDefaults saveKeyValue:UD_NET_STATU value:@(0)];
            [LCProgressHUD showMessage:MSG_NET_ERROR];
        } else if (status == AFNetworkReachabilityStatusReachableViaWWAN) {
            NSLog(@"当前网络：手机流量");
            [STUserDefaults saveKeyValue:UD_NET_STATU value:@(1)];
        } else if (status == AFNetworkReachabilityStatusReachableViaWiFi) {
            NSLog(@"当前网络：WiFi");
            [STUserDefaults saveKeyValue:UD_NET_STATU value:@(1)];
        }
    }];
    [manager startMonitoring];
}





+(void)getConfig:(NSString *)key success:(void (^)(NSString *))result{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    dic[@"cfgKey0"]= key;
    [STNetUtil post:URL_SPECIAL_SETTING content:dic.mj_JSONString success:^(RespondModel *respondModel) {
        if([respondModel.status isEqualToString:STATU_SUCCESS]){
            id data = respondModel.data;
//            [STLog print:[data mj_JSONString]];
            id content;
            if([data isKindOfClass:[NSArray class]]){
                NSArray *datas = data;
                content = [datas[0] objectForKey:@"cfgValue"];
            }else if([data isKindOfClass:[NSDictionary class]]){
                content = [data objectForKey:@"cfgValue"];
            }else{
                content = data;
            }
            result(content);
        }
    } failure:^(int errorCode) {
        
    }];
}

@end

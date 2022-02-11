//
//  WeChatUtil.m
//  manage
//
//  Created by by.huang on 2019/4/28.
//  Copyright © 2019 by.huang. All rights reserved.
//

#import "WeChatUtil.h"
#import "STColorUtil.h"
//#import "WXApi.h"

@implementation WeChatUtil


+(void)getWeChatCode:(UIViewController *)controller delegate:(id)delegate{
    //构造SendAuthReq结构体
    SendAuthReq* req =[[SendAuthReq alloc]init];
    req.scope = @"snsapi_userinfo";
    req.state = @"xhd";
    //第三方向微信终端发送一个SendAuthReq消息结构
    //    [WXApi sendAuthReq:req viewController:controller delegate:delegate];
}

// 调起微信支付
+(void)doWechatPay:(id)data result:(void (^)(Boolean))result{
    PayReq *req = [[PayReq alloc] init];
    req.partnerId = [data objectForKey:@"partnerid"];
    req.prepayId = [data objectForKey:@"prepayid"];
    req.nonceStr = [data objectForKey:@"noncestr"];
    req.timeStamp = [[data objectForKey:@"timestamp"] intValue];
    req.package = [data objectForKey:@"package"];
    req.sign = [data objectForKey:@"paySign"];
    [WXApi sendReq:req completion:^(BOOL success) {
        
    }];
}

+(NSString *)isWechatSupport{
    if(!WXApi.isWXAppInstalled){
        return @"未安装微信";
    }
    if(!WXApi.isWXAppSupportApi){
        return @"当前微信版本不支持";
    }
    return MSG_EMPTY;
}

+(void)shareWechatImage:(UIImage *)image{
    NSData *imageData = UIImagePNGRepresentation(image);
    WXImageObject *imageObject = [WXImageObject object];
    imageObject.imageData = imageData;

    WXMediaMessage *message = [WXMediaMessage message];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"share"
                                                         ofType:@"jpg"];
    message.thumbData = [NSData dataWithContentsOfFile:filePath];
    message.mediaObject = imageObject;

    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    req.scene = WXSceneTimeline;
    [WXApi sendReq:req completion:^(BOOL success) {

    }];

}


+(NSData *)compressBySizeWithMaxLength:(NSUInteger)maxLength image:(UIImage *)image{
    NSData *data = UIImageJPEGRepresentation(image, 1);
    NSUInteger lastDataLength = 0;
    while (data.length > maxLength && data.length != lastDataLength) {
        lastDataLength = data.length;
        CGFloat ratio = (CGFloat)maxLength / data.length;
        CGSize size = CGSizeMake((NSUInteger)(image.size.width * sqrtf(ratio)),
                                 (NSUInteger)(image.size.height * sqrtf(ratio))); // Use NSUInteger to prevent white blank
        UIGraphicsBeginImageContext(size);
        // Use image to draw (drawInRect:), image is larger but more compression time
        // Use result image to draw, image is smaller but less compression time
        [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
        image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        data = UIImageJPEGRepresentation(image, 1);
    }
    return data;
}

+(void)shareWechatMiniApp:(NSString *)url image:(UIImage *)image title:(NSString *)title{
    WXMiniProgramObject *object = [WXMiniProgramObject object];
    object.webpageUrl = url;
    object.userName = MINIAPP_ID;
    object.path =  url;
    NSData *datas = UIImageJPEGRepresentation(image, 0.1f);
    object.hdImageData = datas;

    object.withShareTicket = YES;
    object.miniProgramType = MINIAPP_ENV;
    
    WXMediaMessage *message = [WXMediaMessage message];
    message.title = title;
    message.mediaObject = object;
    
    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    req.scene = WXSceneSession;
    [WXApi sendReq:req completion:^(BOOL success) {
    }];
}

+(void)openWechatMiniApp:(NSString *)url{
    WXLaunchMiniProgramReq *launchMiniProgramReq = [WXLaunchMiniProgramReq object];
    launchMiniProgramReq.userName = MINIAPP_ID;
    launchMiniProgramReq.path = url;
    launchMiniProgramReq.miniProgramType = MINIAPP_ENV;
    return  [WXApi sendReq:launchMiniProgramReq completion:^(BOOL success) {
        
    }];
}

+ (void)shareWechatWithImage:(UIImage *)image title:(NSString *)title type:(int)scene {
    WXMediaMessage *message = [WXMediaMessage message];
    WXImageObject *imageObject = [WXImageObject object];
    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
    req.bText = title.length > 0;
    
    if (title.length > 0) {
        req.text = title;
    }else {
        NSData *imageData= [WeChatUtil compressBySizeWithMaxLength:1024 * 1024 image:image];
        imageObject.imageData = imageData;
        message.mediaObject = imageObject;
    }

    req.message = message;
    req.scene = scene;
    [WXApi sendReq:req completion:^(BOOL success) {
        
    }];
}

+ (void)openWechat {
    NSURL * url = [NSURL URLWithString:@"weixin://"];
    BOOL canOpen = [[UIApplication sharedApplication] canOpenURL:url];
    //先判断是否能打开该url
    if (canOpen)
    {   //打开微信
        [[UIApplication sharedApplication] openURL:url];
    }else {
        [LCProgressHUD showMessage:@"您的设备未安装微信APP"];
    }
}

+ (void)shareExcel:(NSString *)localPath fileName:(NSString *)fileName {
    //文件数据
    WXFileObject *fileObj = [WXFileObject object];
    fileObj.fileData = [NSData dataWithContentsOfFile:localPath];
    //多媒体消息
    fileObj.fileExtension = @"xlsx";
    WXMediaMessage *wxMediaMessage = [WXMediaMessage message];
    wxMediaMessage.title = fileName;
    wxMediaMessage.description = @"描述";
    wxMediaMessage.messageExt = @"xlsx";
    wxMediaMessage.mediaObject = fileObj;
    //发送消息
    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
    req.message = wxMediaMessage;
    req.bText = NO;
    req.scene = WXSceneSession;
    [WXApi sendReq:req completion:^(BOOL success) {
        
    }];
}

@end

//
//  WeChatUtil.h
//  manage
//
//  Created by by.huang on 2019/4/28.
//  Copyright © 2019 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WXApi.h"
NS_ASSUME_NONNULL_BEGIN

@interface WeChatUtil : NSObject

+(void)getWeChatCode:(UIViewController *)controller delegate:(id)delegate;
+(void)doWechatPay:(id)data result:(void (^)(Boolean))result;
+(NSString *)isWechatSupport;
//分享图片到朋友圈
+(void)shareWechatImage:(UIImage *)image;
//分享小程序到微信
+(void)shareWechatMiniApp:(NSString *)urlStr image:(UIImage *)image title:(NSString *)title;
+(void)openWechatMiniApp:(NSString *)url;

///WXSceneSession = 0,聊天界面 ;      WXSceneTimeline = 1,朋友圈 ;      WXSceneFavorite = 2,收藏;      WXSceneSpecifiedSession = 3, 指定联系人
+ (void)shareWechatWithImage:(UIImage *)image title:(NSString *)title type:(int)scene;
+ (void)openWechat;

+ (void)shareExcel:(NSString *)localPath fileName:(NSString *)fileName;

@end

NS_ASSUME_NONNULL_END

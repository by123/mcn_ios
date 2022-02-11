//
//  ThreePartyMacro.h
//  framework
//
//  Created by 黄成实 on 2018/4/17.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h> 

#pragma mark 定义三方库appid,appkey....

#define UMENG_APPKEY @"5b9a297ff43e4859ba00001c"
#define CHANNELCODE  @"00001"

#define BUGLY_APPID @"9933939175"

#ifdef DEBUG
//测试和演示环境
#define WECHAT_APPID @"wx2dbea1a0cd578b84"
//#define MINIAPP_ENV WXMiniProgramTypeTest
#define MINIAPP_ENV WXMiniProgramTypePreview
#else
//正式环境
#define WECHAT_APPID @"wxb098a4d4f8c52178"
#define MINIAPP_ENV WXMiniProgramTypeRelease
#endif

//小程序分享
#ifdef DEBUG
#define MINIAPP_ID @"gh_e4fd93d8660d"
#else
#define MINIAPP_ID @"gh_02ced9c6cff3"

#endif


#define TECENT_MAP_KEY @"PRHBZ-4VLKV-LEKP3-UV6PV-JH7Q7-7NFMJ"
#define UMENG_KEY @"5f50d5069134272740385a40"
#define MAP_KEY @"1d324a95591597510af77e5c500d4c37"

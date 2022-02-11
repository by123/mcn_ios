//
//  STPUtil.h
//  gogo
//
//  Created by by.huang on 2017/10/21.
//  Copyright © 2017年 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface STPUtil : NSObject

//比例宽
+(CGFloat)getActualWidth : (CGFloat)width;

//比例高
+(CGFloat)getActualHeight : (CGFloat)height;

//APP版本
+(double)getAppVersion;

//手机号是否有效
+(Boolean)isPhoneNumValid:(NSString *)phoneNum;

//验证码是否有效
+(Boolean)isVerifyCodeValid:(NSString *)verifyCode;

//身份证号码是否有效
+(Boolean)isIdNumberValid:(NSString *)idNum;

//车牌号是否有效
+(Boolean)isCarNumberValid:(NSString *)carNum;

//计算字符串宽度
+(CGSize)textSize:(NSString *)text maxWidth:(CGFloat)maxWidth font:(CGFloat)font;

//通过身份证号获取生日
+(NSString *)getBirthdayFromIdNum:(NSString *)idNum;

//通过身份证号获取性别
+(NSString *)getGenderfromIdNum:(NSString *)numberStr;

//11位电话号码隐藏
+(NSString *)getSecretPhoneNum:(NSString *)phoneNum;

//是否是放大视图
+(Boolean)isZoomUI;

//获取二维码参数
+(NSMutableDictionary *)getScanCodeParams:(NSString *)codeStr;

//判断是否纯数字
+ (BOOL)isNumberByRegularExpressionWith:(NSString *)str;

//判断是否为小数
+ (BOOL)isDecimal:(NSString *)str;

//银行卡分隔
+ (NSString *)generateCreId:(NSString *)creId;

//double精度问题解决
+(double)doubleDecimal:(double)param;


@end

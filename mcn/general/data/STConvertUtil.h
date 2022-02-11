//
//  STConvertUtil.h
//  framework
//
//  Created by 黄成实 on 2018/4/26.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface STConvertUtil : NSObject

//data转string
+(NSString *)dataToString:(NSData *)data;

//string转data
+(NSData *)stringToData:(NSString *)str;

//base编码
+(NSString *)base64Encode:(NSString *)str;

//base64解码
+(NSString *)base64Decode:(NSString *)str;

//json转NSDictionary或者NSMutableArray
+ (id )jsonToDic:(NSString *)jsonStr;

//NSDictionary转json
+ (NSString*)dicToJson:(id)dic;

//NSMutableArray转json
+(NSString *)arrayToJson:(NSMutableArray *)array;

+(UIImage *)imageResize :(UIImage*)img andResizeTo:(CGSize)newSize;

@end

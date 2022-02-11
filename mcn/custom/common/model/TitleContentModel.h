//
//  TitleContentModel.h
//  framework
//
//  Created by 黄成实 on 2018/5/16.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TitleContentModel : NSObject

@property(copy, nonatomic)NSString *title;
@property(copy, nonatomic)NSString *content;
@property(assign, nonatomic)Boolean isSelect;
@property(assign, nonatomic)Boolean isSwitch;
@property(assign, nonatomic)Boolean hidden;
@property(copy, nonatomic)NSString *extra;
@property(copy, nonatomic)NSString *extra2;
@property(copy, nonatomic)NSString *tips;
@property(strong, nonatomic)NSMutableArray *images;


+(TitleContentModel *)buildModel:(NSString *)title content:(NSString *)content;

+(TitleContentModel *)buildModel:(NSString *)title content:(NSString *)content extra:(NSString *)extra;

+(TitleContentModel *)buildModel:(NSString *)title content:(NSString *)content extra:(NSString *)extra extra2:(NSString *)extra2;

+(TitleContentModel *)buildModel:(NSString *)title content:(NSString *)content extra:(NSString *)extra hidden:(Boolean)hidden;


+(TitleContentModel *)buildModel:(NSString *)title content:(NSString *)content isSelect:(Boolean)isSelect;

+(TitleContentModel *)buildModel:(NSString *)title content:(NSString *)content isSwitch:(Boolean)isSwitch;

+(TitleContentModel *)buildModel:(NSString *)title images:(NSMutableArray *)images;

+(TitleContentModel *)buildModel:(NSString *)title content:(NSString *)content tips:(NSString *)tips extra:(NSString *)extra;


@end

//
//  ColorMacro.h
//  framework
//
//  Created by 黄成实 on 2018/4/17.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "STColorUtil.h"



//主色，辅色，取消色，错误色
#define c01 [STColorUtil colorWithHexString:@"#353648"]
#define c02 [STColorUtil colorWithHexString:@"#757685"]
#define c03 [STColorUtil colorWithHexString:@"#DEDEDE"]
#define c04 [STColorUtil colorWithHexString:@"#FD5750"]
//用于次要提示文案的配色
#define c05 [STColorUtil colorWithHexString:@"#BDBDBD"]
#define c06 [STColorUtil colorWithHexString:@"#76ADF0"]

#define c07 [STColorUtil colorWithHexString:@"#FF4040"]
#define c08 [STColorUtil colorWithHexString:@"#FFCE00"]
#define c09 [STColorUtil colorWithHexString:@"#25262e" alpha:0.8f]
//用于主要文案、正文标题、模块标题、主要icon（例如列表页的下拉收起）配色
#define c10 [STColorUtil colorWithHexString:@"#353648"]
//用于次要文案、说明性文案、tab未选中状态、表单页面标题、操作button（例如添加、删除）、表单、列表跳转icon等配色
#define c11 [STColorUtil colorWithHexString:@"#757685"]
//用于链接跳转文案配色
#define c12 [STColorUtil colorWithHexString:@"#007AFF"]
//用于警示、错误提示内容的配色
#define c13  [STColorUtil colorWithHexString:@"#F85429"]
//详情卡片颜色
#define c14  [STColorUtil colorWithHexString:@"#474FE7"]

//红色背景
#define c15 [STColorUtil colorWithHexString:@"#FF8680"]

#define c16 [STColorUtil colorWithHexString:@"#FE3135"]
#define c16_p [STColorUtil colorWithHexString:@"#FE3140"]
#define c16_d [STColorUtil colorWithHexString:@"#FFDCDC"]
#define c17 [STColorUtil colorWithHexString:@"#F0F0F0"]
#define c18 [STColorUtil colorWithHexString:@"#F7F7F7"]
#define c19 [STColorUtil colorWithHexString:@"#F4F4F6"]
#define c20 [STColorUtil colorWithHexString:@"#FD5750"]

#define c21 [STColorUtil colorWithHexString:@"#353648"]
#define c22 [STColorUtil colorWithHexString:@"#FFCE00"]
#define c23 [STColorUtil colorWithHexString:@"#FFF9D1"]
#define c24 [STColorUtil colorWithHexString:@"#E7E7E7"]

#define c25 [STColorUtil colorWithHexString:@"#81BBFF"]
#define c26 [STColorUtil colorWithHexString:@"#89A5E6"]
#define c27 [STColorUtil colorWithHexString:@"#F3F3F3"]
#define c28 [STColorUtil colorWithHexString:@"#003EFF"]

#define c29 [STColorUtil colorWithHexString:@"#72B5FF"]

///春节配色
#define c30 [STColorUtil colorWithHexString:@"#FDA180"]
#define c30_g [STColorUtil colorWithHexString:@"#FE7F57"]

#define c31 [STColorUtil colorWithHexString:@"#FF9B9C"]
#define c31_g [STColorUtil colorWithHexString:@"#FEAAAA"]

#define c32 [STColorUtil colorWithHexString:@"#FF8281"]
#define c32_g [STColorUtil colorWithHexString:@"#FF9494"]

#define c33 [STColorUtil colorWithHexString:@"#FFF9F4"]
#define c34 [STColorUtil colorWithHexString:@"#171C53"]
#define c35 [STColorUtil colorWithHexString:@"#7E6127"]
#define c36 [STColorUtil colorWithHexString:@"#00B671"]
#define c37 [STColorUtil colorWithHexString:@"#DEC188"]


#define c38 [STColorUtil colorWithHexString:@"#4C6383"]
#define c39 [STColorUtil colorWithHexString:@"#18102D"]
#define c40 [STColorUtil colorWithHexString:@"#181920" alpha:0.7f]
#define c41 [STColorUtil colorWithHexString:@"#FF7073"]
#define c42 [STColorUtil colorWithHexString:@"#3078FF"]
#define c43 [STColorUtil colorWithHexString:@"#4E4F6A"]
#define c44 [STColorUtil colorWithHexString:@"#0037ff"]
#define c45 [STColorUtil colorWithHexString:@"#00B671"]



//用于APP底色配色
#define cbg    [STColorUtil colorWithHexString:@"#FCFCFC"]
#define cbg2   [STColorUtil colorWithHexString:@"#F7F7F7"]
#define cwhite [STColorUtil colorWithHexString:@"#ffffff"]
#define cblack [STColorUtil colorWithHexString:@"#000000"]
#define cclear [STColorUtil colorWithHexString:@"#00000000"]
#define cline  [STColorUtil colorWithHexString:@"#D8D8D8"]
#define ctips [STColorUtil colorWithHexString:@"#BDBDBD"]


#define c_btn_txt_normal  cwhite
#define c_btn_txt_highlight cwhite

#define cwarn [UIColor colorWithRed:0xFF/255.0 green:0x54/255.0 blue:0x54/255.0 alpha:1.0]

#define FONT_MIDDLE  @"PingFangSC-Medium"
#define FONT_REGULAR @"PingFangSC-Regular"
#define FONT_SEMIBOLD @"PingFangSC-Semibold"

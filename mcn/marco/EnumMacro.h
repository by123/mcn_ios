//
//  EnumMacro.h
//  framework
//
//  Created by by.huang on 2018/5/23.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <Foundation/Foundation.h>
#define PAGE_SIZE 10

//皮肤选择
typedef NS_ENUM(NSInteger, SKinType){
    SkinType_Yellow = 0,
    SkinType_Red
};


typedef NS_ENUM(NSInteger, TitlStyle){
    TitlStyle_Semibold = 0,
    TitlStyle_Regular
};

//
typedef NS_ENUM(int, RoleType){
    RoleType_Plat = 1,
    RoleType_Mcn = 2,             //mcn机构
    RoleType_Celebrity = 3,  //网红
    RoleType_Merchant = 4       //商户
};


typedef NS_ENUM (NSInteger, MsgType){
    MsgType_Receive = 0,
    MsgType_Invite
};

typedef NS_ENUM (NSInteger, PreviewImageType){
    PreviewImageType_Identify = 0,
    PreviewImageType_BusinessLicense,
    PreviewImageType_Photo,
    PreviewImageType_Detail
};

typedef NS_ENUM (NSInteger, IdentifyType){
    IdentifyType_Front = 0,
    IdentifyType_Back ,
    IdentifyType_Other
};

typedef NS_ENUM(NSInteger, ShelvesType){
    ShelvesType_Undercarriage = 0,//下架
    ShelvesType_Grouding = 1, //上架
    ShelvesType_Examine = 2 //审核中
};


typedef NS_ENUM(NSInteger,AddressType){
    AddressType_Add = 0,
    AddressType_Select
};

typedef NS_ENUM(NSInteger, AddAddressType){
    AddAddressType_Add = 0,
    AddAddressType_Edit
};

//是否已认证，0未认证，1已认证，2等待审核，3审核不通过
typedef NS_ENUM(NSInteger, AuthenticateState){
    AuthenticateState_Default = 0,
    AuthenticateState_Success ,
    AuthenticateState_Wait ,
    AuthenticateState_Reject
};


//int PUBLIC_BANK = 0;// 银行卡为对公，对公庄户必须要有支行信息
//int PERSONAL_BANK = 1;// 银行卡对私，
//int PUBLIC_ALIPAY = 2;// 企业支付宝
//int PERSONAL_ALIPAY = 3;// 个人支付宝
typedef NS_ENUM(NSInteger, BankType){
    BankType_Bank_Public = 0,
    BankType_Bank_Personal = 1,
    BankType_Alipay_Public = 2,
    BankType_Alipay_Personal = 3
};


//项目状态：1已发起(待发货)，2待确认，3已合作，4已取消(主播取消)，5已关闭(供货商未响应)
typedef NS_ENUM(NSInteger, PartnerType){
    PartnerType_All = 0,
    PartnerType_WaitSend = 1, //待发货
    PartnerType_WaitConfirm = 2,//待确认
    PartnerType_Cooperative = 3,//已合作
    PartnerType_Cancel = 4,   //已取消
    PartnerType_Close = 5   //已关闭
};

//4邀请通知  5是物流助手
typedef NS_ENUM(NSInteger, MessageType){
    MessageType_Invite = 4,
    MessageType_Express = 5,
    MessageType_Agree = 6
};



//1 导购订单 2;自然购买 3;提现
typedef NS_ENUM(NSInteger,ProfitType){
    ProfitType_GuideBuy = 1,
    ProfitType_NatureBuy = 2,
    ProfitType_Withdraw = 3
};


typedef NS_ENUM(NSInteger, MoneyType){
    MoneyType_SUPPLIER_IN = 10,//供货商销售收入
    MoneyType_SUPPLIER_IN_ALL = 11, //供应商自然收入
    MoneyType_MCN_FIRST_BONUS = 20,//MCN首单分成
    MoneyType_MCN_REPEAT_BONUS = 21,//MCN复购分成
    MoneyType_MCN_SALES_BONUS = 22,//MCN销售分成
    MoneyType_ANCHOR_FIRST_BONUS = 30,//主播首单分成
    MoneyType_ANCHOR_REPEAT_BONUS = 31,//主播复购分成
    MoneyType_ANCHOR_SALES_BONUS = 32,//主播销售分成
    MoneyType_PLAT_IN = 40,//平台提成
    /**
     * --------------- 以上是收入 ---------------
     * --------------- 以下是支出 ---------------
     */
    MoneyType_SUPPLIER_OUT_MCN = 50,//供货商MCN分成支出
    MoneyType_SUPPLIER_OUT_PLAT = 51,//供货商平台分成支出
    MoneyType_MCN_OUT_ANCHOR_FIRST = 60,//MCN主播首单分成支出
    MoneyType_MCN_OUT_ANCHOR_REPEAT = 61,//MCN复购支出
    MoneyType_MCN_OUT_ANCHOR_SALE = 62//MCN主播销售分成支出
};


typedef NS_ENUM(NSInteger, StaticticsType){
    StaticticsType_Sell = 1,
    StaticticsType_Income = 2
};

typedef NS_ENUM(NSInteger, StaticticsItemType){
    StaticticsItemType_Cooperate = 0, //合作
    StaticticsItemType_Channel = 1, //渠道
    StaticticsItemType_Product = 2, //产品
    StaticticsItemType_Celebrity = 3, //主播

};

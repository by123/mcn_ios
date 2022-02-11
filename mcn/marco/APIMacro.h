//
//  APIMacro.h
//  framework
//
//  Created by 黄成实 on 2018/4/17
//  Copyright © 2018年 黄成实. All rights reserved.
//



#import <Foundation/Foundation.h>

#pragma mark 定义API相关


#ifdef DEBUG
//测试环境
#define ROOT_URL @"http://www.agyfdsff16.com/app"
//演示环境
#define ROOT_URL @"http://www.agyfdsff16.com/app"
#else
//线上环境
#define ROOT_URL @"https://ahemp.hempo2o.com/app"
#endif



#define XW_PAGESIZE 10
#define XW_LARGE_PAGESIZE 20

//登录
#define URL_LOGIN [ROOT_URL stringByAppendingString:@"/guest/login"]
//发送验证码
#define URL_SEND_VERIFYCODE [ROOT_URL stringByAppendingString:@"/guest/sendLoginCode"]
//验证码登录
#define URL_VERIFYCODE_LOGIN  [ROOT_URL stringByAppendingString:@"/guest/login/byCode"]
//重置密码-获取验证码
#define URL_GET_VERIFYCODE [ROOT_URL stringByAppendingString:@"/guest/requestResetPassword"]
//重置密码-校验验证码
#define URL_CHECK_VERIFYCODE [ROOT_URL stringByAppendingString:@"/guest/checkResetPasswordCode"]
//重置密码
#define URL_RESET_PASSWORD [ROOT_URL stringByAppendingString:@"/guest/resetPassword"]
//获取接收通知的手机号
#define URL_RESET_GETNOTIFYPHONE [ROOT_URL stringByAppendingString:@"/member/pos/getPosPhones"]
//设置接收通知的手机号
#define URL_RESET_SETNOTIFYPHONE [ROOT_URL stringByAppendingString:@"/member/pos/addContactPhone"]
//token登录
#define URL_LOGIN_BY_TOKEN  [ROOT_URL stringByAppendingString:@"/guest/login/byToken"]
//登出
#define URL_LOGOUT  [ROOT_URL stringByAppendingString:@"/guest/logout"]
//修改密码
#define URL_CHANGEPWD [ROOT_URL stringByAppendingString:@"/member/user/modifyPassword"]

//新增地址
#define URL_ADDRESS_ADD [ROOT_URL stringByAppendingString:@"/member/address/add"]
//删除地址
#define URL_ADDRESS_DEL [ROOT_URL stringByAppendingString:@"/member/address/del"]
//分页查询地址
#define URL_ADDRESS_QUERY [ROOT_URL stringByAppendingString:@"/member/address/list"]
//修改地址
#define URL_ADDRESS_UPDATE [ROOT_URL stringByAppendingString:@"/member/address/mod"]
//修改默认地址
#define URL_ADDRESS_DEFAULT_UPDATE [ROOT_URL stringByAppendingString:@"/member/address/mod/default"]
//地址详情查询
#define URL_ADDRESS_DETAIL [ROOT_URL stringByAppendingString:@"/member/address/view"]
//获取默认地址
#define URL_GET_ADDRESS_DEFAULT [ROOT_URL stringByAppendingString:@"/member/address/getDefaultAddr"]



//查询所有下级
#define URL_ORDER_ALL_SUBLIST [ROOT_URL stringByAppendingString:@"/member/mch/getAllSubList"]


//友盟消息绑定
#define URL_MESSAGE_BIND [ROOT_URL stringByAppendingString:@"/umeng/addDeviceInfo"]
//消息列表
#define URL_MESSAGE_LIST [ROOT_URL stringByAppendingString:@"/umeng/message/list"]
//消息详情
#define URL_MESSAGE_DETAIL [ROOT_URL stringByAppendingString:@"/umeng/message/view"]
//消息已读
#define URL_MESSAGE_READ [ROOT_URL stringByAppendingString:@"/umeng/message/read"]
//消息删除
#define URL_MESSAGE_DEL [ROOT_URL stringByAppendingString:@"/umeng/message/del"]


//新增银行卡
#define URL_BANK_ADD [ROOT_URL stringByAppendingString:@"/member/bank/add"]
//身份认证
#define URL_BANK_AUTHENTICATION [ROOT_URL stringByAppendingString:@"/member/bank/authentication"]
//银行卡删除
#define URL_BANK_DEL [ROOT_URL stringByAppendingString:@"/member/bank/del"]
//银行卡列表
#define URL_BANK_LIST [ROOT_URL stringByAppendingString:@"/member/bank/list"]
//修改银行卡
#define URL_BANK_MOD [ROOT_URL stringByAppendingString:@"/member/bank/updateBank"]
//银行卡详情
#define URL_BANK_DETAIL [ROOT_URL stringByAppendingString:@"/member/bank/view"]
//上传文件（私有）
#define URL_UPLOAD_FILE [ROOT_URL stringByAppendingString:@"/file/uploadPriFile"]
//获取文件请求url（私有）
#define URL_GET_FILE [ROOT_URL stringByAppendingString:@"/file/getPriOssUrl"]

//上传文件（共有）
#define URL_UPLOAD_FILE_PUBLIC [ROOT_URL stringByAppendingString:@"/file/uploadPubFile"]
//获取文件请求url(公有)
#define URL_GET_FILE_PUBLIC [ROOT_URL stringByAppendingString:@"/file/getPubOssUrl"]

//定时自动关闭合作
#define URL_DELIVERY_CLOSE [ROOT_URL stringByAppendingString:@"/cooperation/delivery/close"]
//合作项目发货
#define URL_DELIVERY_SUBMIT [ROOT_URL stringByAppendingString:@"/cooperation/delivery/submit"]


//确认合作
#define URL_PROJECT_ACT [ROOT_URL stringByAppendingString:@"/cooperation/project/ack"]
//取消合作
#define URL_PROJECT_CANCEL [ROOT_URL stringByAppendingString:@"/cooperation/project/cancel"]
//物流信息-待发货状态时没有
#define URL_PROJECT_DELIVERY [ROOT_URL stringByAppendingString:@"/cooperation/project/delivery"]
//合作进度流水
#define URL_PROJECT_OPERATIONS [ROOT_URL stringByAppendingString:@"/cooperation/project/operations"]
//合作列表
#define URL_PROJECT_LIST [ROOT_URL stringByAppendingString:@"/cooperation/project/page"]
//提交合作
#define URL_PROJECT_SUBMIT [ROOT_URL stringByAppendingString:@"/cooperation/project/submit"]
//合作详情
#define URL_PROJECT_DETAIL [ROOT_URL stringByAppendingString:@"/cooperation/project/view"]
//机构查询主播列表
#define URL_MCN_CELEBRITY_LIST [ROOT_URL stringByAppendingString:@"/member/mch/getAnchorPage"]

//查询所有商品类别(ok)
#define URL_GOODS_CATEGORY [ROOT_URL stringByAppendingString:@"/goods/goodsClass/list"]

//资质认证
#define URL_MCH_AUTHENTICATE [ROOT_URL stringByAppendingString:@"/member/mch/authenticate"]
//机构移除主播
#define URL_MCH_REMOVE_CELEBRITY [ROOT_URL stringByAppendingString:@"/member/mch/delMchAnchor"]
//获取资质认证信息
#define URL_MCH_AUTHENTICATE_DETAIL [ROOT_URL stringByAppendingString:@"/member/mch/getAuthenticateData"]
//获取个人名片
#define URL_MCH_MY_CARD [ROOT_URL stringByAppendingString:@"/member/mch/getMchUserVo"]
//获取资质认证信息
#define URL_MCH_AUTHENTICATE_INFO [ROOT_URL stringByAppendingString:@"/member/mch/getMchUserVoWithAuthenticateData"]
//获取我的资质认证信息
#define URL_MCH_MY_AUTHENTICATE [ROOT_URL stringByAppendingString:@"/member/mch/getMyAuthenticateData"]
//编辑个人名片
#define URL_MCH_CARD_MOD [ROOT_URL stringByAppendingString:@"/member/mch/modMchUserVo"]
//修改手机号
#define URL_UPDATE_MOBILE [ROOT_URL stringByAppendingString:@"/member/mch/modMchUserMobile"]

//添加邀请主播或者主播主动申请，inviteType判断
#define URL_MCHINVITE_ADD [ROOT_URL stringByAppendingString:@"/member/mchInvite/addMchInvite"]
//主播操作是否同意
#define URL_MCHINVITE_CELEBRITY_AGREE  [ROOT_URL stringByAppendingString:@"/member/mchInvite/anchorOp"]
//mcn移除邀请
#define URL_MCHINVITE_REMOVE  [ROOT_URL stringByAppendingString:@"/member/mchInvite/delMchInvite"]
//获取主播列表
#define URL_MCH_CELEBRITY_LIST  [ROOT_URL stringByAppendingString:@"/member/mch/getMyAnchorPage"]
//获取主播邀请列表
#define URL_MCHINVITE_CELEBRITY_LIST  [ROOT_URL stringByAppendingString:@"/member/mchInvite/getAnchorApplyPage"]
//主播查看申请或者被邀请mch列表，inviteType 2申请 1邀请
#define URL_MCHINVITE_MY_CELEBRITY_LIST  [ROOT_URL stringByAppendingString:@"/member/mchInvite/getMchInvitePage"]
//机构操作审批
#define URL_MCHINVITE_MCN_VERIFY  [ROOT_URL stringByAppendingString:@"/member/mchInvite/mchOp"]
//机构获取主播列表
#define URL_CELEBRITY_LIST [ROOT_URL stringByAppendingString:@"/member/mch/getMchPage"]

//增加sku数量/加入购物车（ok）
#define URL_SHOPCART_ADD  [ROOT_URL stringByAppendingString:@"/goods/shoppingCart/add"]
//批量删除sku
#define URL_SHOPCART_BATCH_REMOVE  [ROOT_URL stringByAppendingString:@"/goods/shoppingCart/batch/remove"]
//购物车列表-按供应商分组（OK）
#define URL_SHOPCART_LIST  [ROOT_URL stringByAppendingString:@"/goods/shoppingCart/list"]
//减少sku数量
#define URL_SHOPCART_REDUCE  [ROOT_URL stringByAppendingString:@"/goods/shoppingCart/reduce"]
//删除sku
#define URL_SHOPCART_REMOVE  [ROOT_URL stringByAppendingString:@"/goods/shoppingCart/remove"]


//产品上传
#define URL_GOODS_ADD  [ROOT_URL stringByAppendingString:@"/goods/sku/add"]
//首页商品查询(ok)
#define URL_GOODS_HOME_LIST  [ROOT_URL stringByAppendingString:@"/goods/sku/homePage"]
//货架列表
#define URL_GOODS_LIST  [ROOT_URL stringByAppendingString:@"/goods/sku/list"]
//产品编辑
#define URL_GOODS_MOD  [ROOT_URL stringByAppendingString:@"/goods/sku/mod"]
//商品下架
#define URL_GOODS_OFFSHELF  [ROOT_URL stringByAppendingString:@"/goods/sku/offShelf"]
//商品上架
#define URL_GOODS_ONSHELF  [ROOT_URL stringByAppendingString:@"/goods/sku/onShelf"]
//商品详情
#define URL_GOODS_DETAIL  [ROOT_URL stringByAppendingString:@"/goods/sku/view"]


//获取资金详情
#define URL_BALANCE [ROOT_URL stringByAppendingString:@"/money/balance/getBalanceByMchId"]
//收支明细列表
#define URL_CAPITAL_LIST [ROOT_URL stringByAppendingString:@"/money/detailFlowing/getDetailFlowing"]
//收支明细详情
#define URL_CAPITAL_DETAIL [ROOT_URL stringByAppendingString:@"/money/detailFlowing/getDetail"]

//合作（渠道）统计, 1销售 2收入
#define URL_STATISTICS_COOPRETA [ROOT_URL stringByAppendingString:@"/money/detailFlowing/getCooperationStatistic"]

//主播统计, 1销售 2收入
#define URL_STATISTICS_CELEBRITY [ROOT_URL stringByAppendingString:@"/money/detailFlowing/getAnchorStatistic"]

//产品统计, 1销售 2收入
#define URL_STATISTICS_PRODUCT [ROOT_URL stringByAppendingString:@"/money/detailFlowing/getSkuStatistic"]

//查询提现总金额
#define URL_WITHDRAW_COUNT   [ROOT_URL stringByAppendingString:@"/withdraw/count"]
//获取提现相关配置,0余额
#define URL_WITHDRAW_CONFIG   [ROOT_URL stringByAppendingString:@"/withdraw/getWithdrawConfig"]
//获取提现的相关配置-包括提示,0余额
#define URL_WITHDRAW_CONFIG_TIPS   [ROOT_URL stringByAppendingString:@"/withdraw/getWithdrawHindConfig"]
//获取余额提现相关数据
#define URL_WITHDRAW_INFO   [ROOT_URL stringByAppendingString:@"/withdraw/getWithdrawInfo/balance"]
//查询提现列表
#define URL_WITHDRAW_LIST   [ROOT_URL stringByAppendingString:@"/withdraw/list"]
//查询提现详情
#define URL_WITHDRAW_DETAIL   [ROOT_URL stringByAppendingString:@"/withdraw/view"]
//余额提现
#define URL_WITHDRAW_BALANCE   [ROOT_URL stringByAppendingString:@"/withdraw/withdraw/balance"]


//修改手机号-发送验证码
#define URL_UPDATEPHONE_SENDCODE [ROOT_URL stringByAppendingString:@"/member/sms/sendSmsCode"]
//修改手机号-验证验证码
#define URL_UPDATEPHONE_VERIFYCODE [ROOT_URL stringByAppendingString:@"/member/sms/checkSmsCode"]

//软件更新
#define URL_CHECKUPDATE [ROOT_URL stringByAppendingString:@"/guest/getSoftwareUpdateVersion"]
//获取配置
#define URL_SPECIAL_SETTING [ROOT_URL stringByAppendingString:@"/member/specialCfg/getSpecialCfgByKey"]


#define URL_BANK @"http://xhdianapp.oss-cn-beijing.aliyuncs.com/bankCode.json"
#define URL_CITY @"http://xhdianapp.oss-cn-beijing.aliyuncs.com/cityCode.json"

#pragma mark - 网络请求码

#define STATU_SUCCESS @"0"
#define STATU_INVALID @"9"
#define STATU_SERVER_EROOR 502
#define STATU_NOT_EXIST @"110017"

#define URL_SETTING [ROOT_URL stringByAppendingString:@"/appleCheckState"]



#pragma mark - 配置表
#define CONFIG_INDUSTY @"industry_list"
#define CONFIG_PARTNER_TYPE @"partner_type"

//配置跳转
#define CONFIG_DIALOG @"app_pop_up_notice_config"
#define CONFIG_PAGE_SHOPADDRESS @"ShopAddressPage"

//app_pop_up_notice_config 

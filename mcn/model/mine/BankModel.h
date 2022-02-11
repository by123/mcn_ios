//
//  BankModel.h
//  mcn
//
//  Created by by.huang on 2020/9/3.
//  Copyright © 2020 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BankModel : NSObject

@property(copy, nonatomic)NSString *bid;
//支付宝（个人姓名或公司名）或银行账户名
@property(copy, nonatomic)NSString *accountName;
//支付宝账户或银行卡号
@property(copy, nonatomic)NSString *bankId;
@property(copy, nonatomic)NSString *bankBranch;
//银行编号
@property(copy, nonatomic)NSString *bankCode;
@property(copy, nonatomic)NSString *bankName;
@property(copy, nonatomic)NSString *creid;
//int PUBLIC_BANK = 0;// 银行卡为对公，对公庄户必须要有支行信息
//int PERSONAL_BANK = 1;// 银行卡对私，
//int PUBLIC_ALIPAY = 2;// 企业支付宝
//int PERSONAL_ALIPAY = 3;// 个人支付宝
@property(assign, nonatomic)int isPublic;

@end

NS_ASSUME_NONNULL_END

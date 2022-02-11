//
//  CapitalModel.h
//  mcn
//
//  Created by by.huang on 2020/8/30.
//  Copyright © 2020 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@interface CapitalRespondModel : NSObject

@property(strong, nonatomic)id mchBalanceRespVo;
@property(strong, nonatomic)id disDetailMchRespVo;

@end

@interface CapitalModel : NSObject


//账户余额
@property(assign, nonatomic)double actualCanWithdrawNum;
//可提现金额
@property(assign, nonatomic)double canWithdrawNum;
//冻结
@property(assign, nonatomic)double freezeMoney;

//总收入
@property(assign, nonatomic)double totalIncome;
//合作收入
@property(assign, nonatomic)double cooperationIncome;
//自然收入
@property(assign, nonatomic)double natureIncome;

//总销售
@property(assign, nonatomic)double totalSell;
//合作销售
@property(assign, nonatomic)double cooperationSell;
//自然销售
@property(assign, nonatomic)double natureSell;

//总收入列表
@property(assign, nonatomic)double totalIncome2;
//总支出列表
@property(assign, nonatomic)double totalPay;

@end

NS_ASSUME_NONNULL_END

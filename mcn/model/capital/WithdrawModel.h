//
//  WithdrawModel.h
//  mcn
//
//  Created by by.huang on 2020/9/10.
//  Copyright © 2020 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WithdrawModel : NSObject

@property(copy, nonatomic)NSString *withdrawId;
@property(copy, nonatomic)NSString *bankId;
//实际到账
@property(assign, nonatomic)double withdrawMoney;
//税费
@property(assign, nonatomic)double taxMoney;
//手续费
@property(assign, nonatomic)double auxiliaryExpenses;
//提现总金额
@property(assign, nonatomic)double totalMoney;
@property(assign, nonatomic)int withdrawState;
@property(copy, nonatomic)NSString *createTime;
@property(copy, nonatomic)NSString *payDate;


+(NSString *)getWithdrawState:(int)withdrawState;

@end

@interface WithdrawTipsModel : NSObject

@property(strong, nonatomic)id bank;
@property(assign, nonatomic)double max;
@property(assign, nonatomic)double min;
@property(strong, nonatomic)NSMutableArray *bankHint;
@property(assign, nonatomic)double fee;

@end

NS_ASSUME_NONNULL_END

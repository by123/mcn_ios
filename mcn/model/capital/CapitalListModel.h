//
//  CapitalListModel.h
//  mcn
//
//  Created by by.huang on 2020/9/9.
//  Copyright © 2020 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CapitalListModel : NSObject

@property(copy, nonatomic)NSString *listId;

@property(copy, nonatomic)NSString *attribute;
@property(copy, nonatomic)NSString *spuName;
//0:正收益，1:退款产生的负收益 提现为1负
@property(assign, nonatomic)int direction;
// 金额
@property(assign, nonatomic)double profit;
//
//@property(copy, nonatomic)NSString *spuId;
//@property(copy, nonatomic)NSString *skuId;
//@property(copy, nonatomic)NSString *mchName;
//@property(copy, nonatomic)NSString *mchId;
//@property(copy, nonatomic)NSString *cooperationId;
//@property(copy, nonatomic)NSString *cooperationMchName;
//@property(copy, nonatomic)NSString *detailJson;


//1 导购订单 2;自然购买 3;提现
@property(assign, nonatomic)ProfitType profitType;

//1,2

//订单号
@property(copy, nonatomic)NSString *orderId;
//订单来源
@property(copy, nonatomic)NSString *orderOrigin;
//下单时间
@property(copy, nonatomic)NSString *orderTime;


//3
//银行
@property(copy, nonatomic)NSString *bankId;





@end

NS_ASSUME_NONNULL_END

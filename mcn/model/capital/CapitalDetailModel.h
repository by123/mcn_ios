//
//  CapitalDetailModel.h
//  mcn
//
//  Created by by.huang on 2020/9/10.
//  Copyright © 2020 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CapitalDetailModel : NSObject

@property(copy, nonatomic)NSString *orderId;
@property(copy, nonatomic)NSString *cooperationId;
@property(copy, nonatomic)NSString *attribute;
@property(copy, nonatomic)NSString *spuName;
@property(assign, nonatomic)double actualPrice;
@property(assign, nonatomic)double profit;
@property(assign, nonatomic)int direction;
@property(copy, nonatomic)NSString *cooperationMchName;
@property(assign, nonatomic)ProfitType profitType;
@property(copy, nonatomic)NSString *orderOrigin;
@property(copy, nonatomic)NSString *orderTime;
@property(copy, nonatomic)NSString *createTime;
@property(copy, nonatomic)NSString *detailJson;



+(double)getMoney:(MoneyType)type detailJson:(NSString *)detailJson;

@end

NS_ASSUME_NONNULL_END

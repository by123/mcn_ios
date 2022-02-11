//
//  WithdrawModel.m
//  mcn
//
//  Created by by.huang on 2020/9/10.
//  Copyright © 2020 by.huang. All rights reserved.
//

#import "WithdrawModel.h"

@implementation WithdrawModel

+(NSString *)getWithdrawState:(int)withdrawState{
    switch (withdrawState) {
        case 0:
            return @"审核通过";
        case 1:
            return @"提现中";
        case 2:
            return @"提现成功";
        case 3:
            return @"提现失败";
        case 4:
            return @"需要人工确认";
        case -1:
            return @"待审核";
        case -2:
            return @"挂起";
        case -3:
            return @"审核不通过";
        default:
            break;
    }
    return @"提现中";
}
@end


@implementation WithdrawTipsModel

-(double)max{
    return [[_bank objectForKey:@"max"] doubleValue];
}

-(double)min{
    return [[_bank objectForKey:@"min"] doubleValue];
}

@end

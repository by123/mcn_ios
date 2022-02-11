//
//  CollapsibleModel.m
//  TreasureChest
//
//  Created by xiao ming on 2019/12/19.
//  Copyright © 2019 xiao ming. All rights reserved.
//

#import "CollapsibleModel.h"
#import "AccountManager.h"
#import "STNetUtil.h"

@implementation CollapsibleModel

- (instancetype)init {
    if(self == [super init]){
        _subs = [NSMutableArray arrayWithCapacity:0];
    }
    return self;
}

- (NSString *)getShowName {
    //mchtype 3 取 posname 否则取mchname;
    NSString *name = self.mchType == 3 ? self.posName : self.mchName;
    return name;
}

/**
 mchType：1~代理，2~零售，3~直营
 */
- (BOOL)isCanUnfold
{
    return self.mchType == 1 || self.mchType == -1;
}

@end

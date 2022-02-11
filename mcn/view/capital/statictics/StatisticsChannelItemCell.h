//
//  StatisticsChannelItemCell.h
//  mcn
//
//  Created by by.huang on 2020/9/11.
//  Copyright © 2020 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StatisticsCooperateModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface StatisticsChannelItemCell : UITableViewCell

-(void)updateData:(CooperateSkuModel *)model;
+(NSString *)identify;
@end

NS_ASSUME_NONNULL_END

//
//  PartnerMcnDetailViewCell.h
//  mcn
//
//  Created by by.huang on 2020/9/8.
//  Copyright © 2020 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PartnerDetailModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PartnerMcnDetailViewCell : UITableViewCell

@property(strong, nonatomic)UIButton *celebrityBtn;

-(void)updateData:(ProductModel *)model;
+(NSString *)identify;

@end

NS_ASSUME_NONNULL_END

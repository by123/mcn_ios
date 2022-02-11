//
//  AddressViewCell.h
//  mcn
//
//  Created by by.huang on 2020/8/30.
//  Copyright © 2020 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AddressInfoModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface AddressViewCell : UITableViewCell

@property(strong, nonatomic)UIButton *deleteBtn;
@property(strong, nonatomic)UIButton *editBtn;


-(void)updateData:(AddressInfoModel *)model type:(AddressType)type;
+(NSString *)identify;

@end

NS_ASSUME_NONNULL_END

//
//  DeliveryModel.h
//  mcn
//
//  Created by by.huang on 2020/9/7.
//  Copyright © 2020 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DeliveryModel : NSObject

@property(copy, nonatomic)NSString *addressId;
@property(copy, nonatomic)NSString *expressCompanyName;
@property(copy, nonatomic)NSString *expressNumber;
@property(assign, nonatomic)int expressCompanyId;
@property(copy, nonatomic)NSString *cooperationId;


@end

NS_ASSUME_NONNULL_END

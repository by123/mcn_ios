//
//  DeliveryPage.h
//  by
//
//  Created by by.huang on block.
//  Copyright © 2018 by.huang. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "AddressInfoModel.h"

@interface DeliveryPage : BaseViewController

+(void)show:(BaseViewController *)controller model:(AddressInfoModel *)addressModel;

@end


//
//  AddressPage.h
//  by
//
//  Created by by.huang on block.
//  Copyright © 2018 by.huang. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface AddressPage : BaseViewController

+(void)show:(BaseViewController *)controller type:(AddressType)type addressId:(NSString *)addressId;

@end


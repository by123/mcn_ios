//
//  BusinessPage.h
//  by
//
//  Created by by.huang on block.
//  Copyright © 2018 by.huang. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface BusinessPage : BaseViewController

+(void)show:(BaseViewController *)controller mchId:(NSString *)mchId isEdit:(Boolean)isEdit;

@end


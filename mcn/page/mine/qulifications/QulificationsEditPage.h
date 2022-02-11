//
//  QulificationsEditPage.h
//  by
//
//  Created by by.huang on block.
//  Copyright © 2018 by.huang. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "QulificationsModel.h"

@interface QulificationsEditPage : BaseViewController

+(void)show:(BaseViewController *)controller roleType:(RoleType)roleType model:(QulificationsModel *)model isEdit:(Boolean)isEdit;

@end


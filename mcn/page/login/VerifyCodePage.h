//
//  VerifyCodePage.h
//  by
//
//  Created by by.huang on block.
//  Copyright © 2018 by.huang. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface VerifyCodePage : BaseViewController

+(void)show:(BaseViewController *)controller phoneNum:(NSString *)phoneNum updatePhone:(Boolean)updatePhone;

@end


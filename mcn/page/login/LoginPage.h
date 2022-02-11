//
//  LoginPage.h
//  by
//
//  Created by by.huang on block.
//  Copyright © 2018 by.huang. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface LoginPage : BaseViewController


+(void)show:(BaseViewController *)controller;
+(void)back:(BaseViewController *)controller content:(NSString *)content;

@end


//
//  CelebrityDetailPage.h
//  by
//
//  Created by by.huang on block.
//  Copyright © 2018 by.huang. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface CelebrityDetailPage : BaseViewController

+(void)show:(BaseViewController *)controller mchId:(NSString *)mchId type:(int)type operateState:(int)operateState celebrityId:(NSString *)celebrityId;

@end


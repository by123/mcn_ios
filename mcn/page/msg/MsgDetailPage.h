//
//  MsgDetailPage.h
//  by
//
//  Created by by.huang on block.
//  Copyright © 2018 by.huang. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface MsgDetailPage : BaseViewController

@property(copy, nonatomic)NSString *msgId;


+(void)show:(BaseViewController *)controller msgId:(NSString *)msgId;

@end


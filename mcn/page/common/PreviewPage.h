//
//  PreviewPage.h
//  by
//
//  Created by by.huang on block.
//  Copyright © 2018 by.huang. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "PreviewModel.h"

@interface PreviewPage : BaseViewController

+(void)show:(BaseViewController *)controller datas:(NSMutableArray *)datas previewType:(PreviewImageType)previewType;

@end


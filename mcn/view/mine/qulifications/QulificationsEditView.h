//
//  QulificationsEditView.h
//  manage
//
//  Created by by.huang on 2018/11/14.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QulificationsEditViewModel.h"


@interface QulificationsEditView : UIView

-(instancetype)initWithViewModel:(QulificationsEditViewModel *)viewModel;
-(void)updateView;
-(void)updateViewIdentify;
-(void)updateViewBusinessLicense;

@end


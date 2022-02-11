//
//  SettingView.h
//  manage
//
//  Created by by.huang on 2018/11/14.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SettingViewModel.h"


@interface SettingView : UIView

-(instancetype)initWithViewModel:(SettingViewModel *)viewModel;
-(void)updateView;

@end


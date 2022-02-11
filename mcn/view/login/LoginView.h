//
//  LoginView.h
//  manage
//
//  Created by by.huang on 2018/11/14.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginViewModel.h"


@interface LoginView : UIView

-(instancetype)initWithViewModel:(LoginViewModel *)viewModel;
-(void)updateTips:(NSString *)tips;

@end


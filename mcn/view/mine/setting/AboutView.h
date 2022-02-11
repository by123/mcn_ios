//
//  AboutView.h
//  manage
//
//  Created by by.huang on 2018/11/14.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AboutViewModel.h"


@interface AboutView : UIView

-(instancetype)initWithViewModel:(AboutViewModel *)viewModel;
-(void)updateView;

@end


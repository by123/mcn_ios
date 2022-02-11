//
//  FirstLoginView.h
//  manage
//
//  Created by by.huang on 2018/11/14.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FirstLoginViewModel.h"


@interface FirstLoginView : UIView

-(instancetype)initWithViewModel:(FirstLoginViewModel *)viewModel;
-(void)updateView;

@end


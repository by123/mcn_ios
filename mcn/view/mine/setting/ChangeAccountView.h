//
//  ChangeAccountView.h
//  manage
//
//  Created by by.huang on 2018/11/14.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChangeAccountViewModel.h"


@interface ChangeAccountView : UIView

-(instancetype)initWithViewModel:(ChangeAccountViewModel *)viewModel;
-(void)updateView;

@end


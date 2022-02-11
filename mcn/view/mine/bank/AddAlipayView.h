//
//  AddAlipayView.h
//  manage
//
//  Created by by.huang on 2018/11/14.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddAlipayViewModel.h"


@interface AddAlipayView : UIView

-(instancetype)initWithViewModel:(AddAlipayViewModel *)viewModel;
-(void)updateView;

@end


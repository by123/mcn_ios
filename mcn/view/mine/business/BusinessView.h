//
//  BusinessView.h
//  manage
//
//  Created by by.huang on 2018/11/14.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BusinessViewModel.h"


@interface BusinessView : UIView

-(instancetype)initWithViewModel:(BusinessViewModel *)viewModel;
-(void)updateView;

@end


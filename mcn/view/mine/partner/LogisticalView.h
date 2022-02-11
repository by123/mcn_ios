//
//  LogisticalView.h
//  manage
//
//  Created by by.huang on 2018/11/14.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LogisticalViewModel.h"


@interface LogisticalView : UIView

-(instancetype)initWithViewModel:(LogisticalViewModel *)viewModel;
-(void)updateView;

@end


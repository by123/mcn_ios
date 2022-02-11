//
//  QulificationsView.h
//  manage
//
//  Created by by.huang on 2018/11/14.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QulificationsViewModel.h"


@interface QulificationsView : UIView

-(instancetype)initWithViewModel:(QulificationsViewModel *)viewModel;
-(void)updateView;

@end


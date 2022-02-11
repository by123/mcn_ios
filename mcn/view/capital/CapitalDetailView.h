//
//  CapitalDetailView.h
//  manage
//
//  Created by by.huang on 2018/11/14.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CapitalDetailViewModel.h"


@interface CapitalDetailView : UIView

-(instancetype)initWithViewModel:(CapitalDetailViewModel *)viewModel;
-(void)updateView;

@end


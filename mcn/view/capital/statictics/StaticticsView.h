//
//  StaticticsView.h
//  manage
//
//  Created by by.huang on 2018/11/14.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StaticticsViewModel.h"


@interface StaticticsView : UIView

-(instancetype)initWithViewModel:(StaticticsViewModel *)viewModel;
-(void)updateView;

@end


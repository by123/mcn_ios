//
//  CelebrityDetailView.h
//  manage
//
//  Created by by.huang on 2018/11/14.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CelebrityDetailViewModel.h"


@interface CelebrityDetailView : UIView

-(instancetype)initWithViewModel:(CelebrityDetailViewModel *)viewModel;
-(void)updateView;


@end


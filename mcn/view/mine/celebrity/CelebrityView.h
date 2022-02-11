//
//  CelebrityView.h
//  manage
//
//  Created by by.huang on 2018/11/14.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CelebrityViewModel.h"


@interface CelebrityView : UIView

-(instancetype)initWithViewModel:(CelebrityViewModel *)viewModel;
-(void)updateView;

@end


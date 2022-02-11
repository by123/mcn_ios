//
//  CooperationView.h
//  manage
//
//  Created by by.huang on 2018/11/14.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CooperationViewModel.h"
#import "CelebrityParamModel.h"

@interface CooperationView : UIView

-(instancetype)initWithViewModel:(CooperationViewModel *)viewModel;
-(void)updateView;
-(void)updateCelebrity:(CelebrityParamModel *)model;

@end


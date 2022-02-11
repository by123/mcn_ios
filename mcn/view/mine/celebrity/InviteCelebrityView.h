//
//  InviteCelebrityView.h
//  manage
//
//  Created by by.huang on 2018/11/14.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InviteCelebrityViewModel.h"


@interface InviteCelebrityView : UIView

-(instancetype)initWithViewModel:(InviteCelebrityViewModel *)viewModel;
-(void)updateView;

@end


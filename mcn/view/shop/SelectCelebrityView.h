//
//  SelectCelebrityView.h
//  manage
//
//  Created by by.huang on 2018/11/14.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SelectCelebrityViewModel.h"


@interface SelectCelebrityView : UIView

-(instancetype)initWithViewModel:(SelectCelebrityViewModel *)viewModel;
-(void)updateView;

@end


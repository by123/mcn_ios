//
//  PartnerCelebrityView.h
//  manage
//
//  Created by by.huang on 2018/11/14.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PartnerCelebrityViewModel.h"


@interface PartnerCelebrityView : UIView

-(instancetype)initWithViewModel:(PartnerCelebrityViewModel *)viewModel;
-(void)updateView;

@end


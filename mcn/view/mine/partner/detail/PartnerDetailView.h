//
//  PartnerDetailView.h
//  manage
//
//  Created by by.huang on 2018/11/14.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PartnerDetailViewModel.h"


@interface PartnerDetailView : UIView

-(instancetype)initWithViewModel:(PartnerDetailViewModel *)viewModel;
-(void)updateView;

@end


//
//  PartnerView.h
//  manage
//
//  Created by by.huang on 2018/11/14.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PartnerViewModel.h"


@interface PartnerView : UIView

-(instancetype)initWithViewModel:(PartnerViewModel *)viewModel;
-(void)updateView;
-(void)reloadView;

@end


//
//  PartnerMcnView.h
//  manage
//
//  Created by by.huang on 2018/11/14.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PartnerMcnViewModel.h"


@interface PartnerMcnView : UIView

-(instancetype)initWithViewModel:(PartnerMcnViewModel *)viewModel;
-(void)updateView;

@end


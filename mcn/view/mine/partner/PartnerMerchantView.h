//
//  PartnerMerchantView.h
//  manage
//
//  Created by by.huang on 2018/11/14.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PartnerMerchantViewModel.h"


@interface PartnerMerchantView : UIView

-(instancetype)initWithViewModel:(PartnerMerchantViewModel *)viewModel;
-(void)updateView;

@end


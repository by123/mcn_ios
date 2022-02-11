//
//  DeliveryView.h
//  manage
//
//  Created by by.huang on 2018/11/14.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DeliveryViewModel.h"

@interface DeliveryView : UIView

-(instancetype)initWithViewModel:(DeliveryViewModel *)viewModel;
-(void)updateView;
-(void)updateExpressView;

@end


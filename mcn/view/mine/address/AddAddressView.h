//
//  AddAddressView.h
//  manage
//
//  Created by by.huang on 2018/11/14.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddAddressViewModel.h"

@interface AddAddressView : UIView

-(instancetype)initWithViewModel:(AddAddressViewModel *)viewModel;
-(void)updateView;

@end


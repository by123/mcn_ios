//
//  AddressView.h
//  manage
//
//  Created by by.huang on 2018/11/14.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddressViewModel.h"


@interface AddressView : UIView

-(instancetype)initWithViewModel:(AddressViewModel *)viewModel;
-(void)updateView;
-(void)onRequestNoDatas:(Boolean)isFirst;
@end


//
//  AddPublickBankView.h
//  manage
//
//  Created by by.huang on 2018/11/14.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddPublickBankViewModel.h"


@interface AddPublickBankView : UIView

-(instancetype)initWithViewModel:(AddPublickBankViewModel *)viewModel;
-(void)updateView;

@end


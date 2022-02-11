//
//  AddBankView.h
//  manage
//
//  Created by by.huang on 2018/11/14.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddBankViewModel.h"


@interface AddBankView : UIView

-(instancetype)initWithViewModel:(AddBankViewModel *)viewModel;
-(void)updateView;

@end


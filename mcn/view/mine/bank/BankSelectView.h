//
//  BankSelectView.h
//  manage
//
//  Created by by.huang on 2018/11/14.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BankSelectViewModel.h"


@interface BankSelectView : UIView

-(instancetype)initWithViewModel:(BankSelectViewModel *)viewModel;
-(void)updateView;

@end


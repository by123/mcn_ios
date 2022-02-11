//
//  BankView.h
//  manage
//
//  Created by by.huang on 2018/11/14.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BankViewModel.h"


@interface BankView : UIView

-(instancetype)initWithViewModel:(BankViewModel *)viewModel;
-(void)updateView;

@end


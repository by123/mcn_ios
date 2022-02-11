//
//  UpdatePhoneView.h
//  manage
//
//  Created by by.huang on 2018/11/14.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UpdatePhoneViewModel.h"


@interface UpdatePhoneView : UIView

-(instancetype)initWithViewModel:(UpdatePhoneViewModel *)viewModel;
-(void)updateView;

@end


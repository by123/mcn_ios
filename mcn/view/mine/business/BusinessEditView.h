//
//  BusinessEditView.h
//  manage
//
//  Created by by.huang on 2018/11/14.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BusinessEditViewModel.h"


@interface BusinessEditView : UIView

-(instancetype)initWithViewModel:(BusinessEditViewModel *)viewModel;
-(void)updateView;
-(void)updateHeadImage:(NSString *)headUrl;
-(void)updatePhone;

@end


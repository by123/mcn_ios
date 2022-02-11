//
//  ChangePwdView.h
//  cigarette
//
//  Created by xiao ming on 2019/12/16.
//  Copyright © 2019 by.huang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChangePwdViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ChangePwdView : UIView
-(instancetype)initWithViewModel:(ChangePwdViewModel *)viewModel;
-(void)updateView;
@end

NS_ASSUME_NONNULL_END

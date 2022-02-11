//
//  MsgView.h
//  mcn
//
//  Created by by.huang on 2020/8/18.
//  Copyright © 2020 by.huang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MsgView : UIView

-(instancetype)initWithViewModel:(MainViewModel *)mainVM;
-(void)refreshNew;

@end

NS_ASSUME_NONNULL_END

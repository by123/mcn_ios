//
//  ShelvesView.h
//  mcn
//
//  Created by by.huang on 2020/8/20.
//  Copyright © 2020 by.huang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ShelvesView : UIView

-(instancetype)initWithViewModel:(MainViewModel *)mainVM;
-(void)positionTab:(ShelvesType)shelvesType;

@end

NS_ASSUME_NONNULL_END

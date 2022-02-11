//
//  HomeView.h
//  mcn
//
//  Created by by.huang on 2020/8/18.
//  Copyright © 2020 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MainViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HomeView : UIView

-(instancetype)initWithViewModel:(MainViewModel *)mainVM;

@end

NS_ASSUME_NONNULL_END

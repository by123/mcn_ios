//
//  HomeSearchView.h
//  manage
//
//  Created by by.huang on 2018/11/14.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeSearchViewModel.h"


@interface HomeSearchView : UIView

-(instancetype)initWithViewModel:(HomeSearchViewModel *)viewModel;
-(void)updateView;
-(void)onRequestNoDatas:(Boolean)isFirst;

@end


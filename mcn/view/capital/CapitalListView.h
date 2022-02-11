//
//  CapitalListView.h
//  mcn
//
//  Created by by.huang on 2020/8/19.
//  Copyright © 2020 by.huang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CaptialView.h"
#import "CapitalModel.h"
#import "MainViewModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CapitalListView : UIView

-(instancetype)initWithType:(int)type height:(CGFloat)height view:(CaptialView *)rootView mainVm:(MainViewModel *)mainVm;
-(void)refreshNew;
-(void)uploadMore;
-(CGFloat)getListViewHeight;
-(void)updateTotal:(CapitalModel *)model;

@end

NS_ASSUME_NONNULL_END

//
//  TabScrollView.h
//  TreasureChest
//
//  Created by xiao ming on 2019/12/20.
//  Copyright © 2019 xiao ming. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TabTitleScrollView.h"

NS_ASSUME_NONNULL_BEGIN

@protocol TabScrollViewDelegate<NSObject>

- (void)selectedContentView:(id)view selectedIndex:(NSInteger)index;

@end

@interface TabScrollView : UIView

@property(weak, nonatomic)id<TabScrollViewDelegate> delegate;
@property(strong, nonatomic)TabTitleScrollView *titleScrollView;
@property(strong, nonatomic)UIScrollView *contentScrollView;

@property(nonatomic, assign)CGFloat titleHeight;
@property(assign, nonatomic)CGFloat contentOffsetY;

- (instancetype)initWithFrame:(CGRect)frame contents:(NSArray *)views titles:(NSArray *)titles contentOffsetY:(CGFloat)contentOffsetY;
- (instancetype)initWithFrame:(CGRect)frame contents:(NSArray *)views titles:(NSArray *)titles;
- (id)getSelectedView;
+ (CGFloat)getTitleTabHeight;

@end

NS_ASSUME_NONNULL_END

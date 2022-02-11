//
//  MutableFormsView.h
//  cigarette
//
//  Created by xiao ming on 2019/12/28.
//  Copyright © 2019 by.huang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FormsView.h"

NS_ASSUME_NONNULL_BEGIN
@protocol MutableFormsViewDelegate <NSObject>

-(void)onFormViewRightBtnClick;

@end

@interface MutableFormsView : UIView

@property(strong, nonatomic)FormsView *topFormsView;
@property(strong, nonatomic)FormsView *formsView;
@property(assign, nonatomic, readonly)CGFloat formsHeight;//从这个属性获取高度
@property(weak, nonatomic)id delegate;

- (instancetype)initWithFrame:(CGRect)frame topCount:(NSInteger)topCount contentCount:(NSInteger)contentCount;

- (void)refreshPosition;

@end

NS_ASSUME_NONNULL_END

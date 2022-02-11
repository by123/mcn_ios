//
//  FormsView.h
//  TreasureChest
//
//  Created by xiao ming on 2019/12/5.
//  Copyright © 2019 xiao ming. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@interface FormsView : UIView

@property(strong, nonatomic)NSArray <NSString *> *leftTitles;
@property(strong, nonatomic)NSArray <NSString *> *rightTitles;

@property(strong, nonatomic)UIFont *leftLabelsFont;
@property(strong, nonatomic)UIFont *rightLabelsFont;

@property(strong, nonatomic)UIColor *leftLabelsColor;
@property(strong, nonatomic)UIColor *rightLabelsColor;

@property(assign, nonatomic)BOOL isTopLineHidden;
@property(assign, nonatomic)BOOL isBottomLineHidden;

///获取本控件高度
@property(assign, nonatomic, readonly)CGFloat formsHeight;

@property(assign, nonatomic)CGFloat leftLabelWidth;
@property(assign, nonatomic)CGFloat spaceHeight;
@property(strong, nonatomic)UIButton *rightBtn;

@property(copy, nonatomic)NSString *rightImageRes;

///这里感觉想要改成width
- (instancetype)initWithFrame:(CGRect)frame count:(NSInteger)count;

/**
 一级表单样式的固定样式：这里写成函数，简化写法。
 特点：颜色较深（左c10，右c10，右侧加粗）。（默认：左c11，右c10，不加粗。默认样式只要初始化这个类就好）
 */
- (void)showHighlightStyle;

///当做topForm，左右都是c10并且加粗。
- (void)showTopHighlightStyle;

+ (CGFloat)getFormsHeightWithTitles:(NSArray *)titles viewWidth:(CGFloat)viewWidth;


@end

NS_ASSUME_NONNULL_END

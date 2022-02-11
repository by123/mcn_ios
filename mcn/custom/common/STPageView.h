//
//  STPageView.h
//  manage
//
//  Created by by.huang on 2018/11/14.
//  Copyright © 2018 by.huang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol STPageViewDelegate <NSObject>

-(void)onPageViewSelect:(NSInteger)position view:(id)view;

@end

@interface STPageView : UIView

@property(weak, nonatomic)id<STPageViewDelegate> delegate;
@property(strong, nonatomic)UIView *topView;
@property(strong, nonatomic)UIView *lineView;
@property(strong, nonatomic)UIColor *selectedColor;
@property(strong, nonatomic)UIColor *normalColor;

-(instancetype)initWithFrame:(CGRect)frame views:(NSMutableArray *)views titles:(NSArray *)titles;
-(instancetype)initWithFrame:(CGRect)frame views:(NSMutableArray *)views titles:(NSArray *)titles perLine:(CGFloat)perLine;
-(instancetype)initWithFrame:(CGRect)frame views:(NSMutableArray *)views titles:(NSArray *)titles perLine:(CGFloat)perLine perWidth:(CGFloat)perWidth;
-(void)setCurrentTab:(NSInteger)tab;
-(void)changeFrame:(CGFloat)height offsetY:(CGFloat)offsetY;
-(void)fastenTopView:(CGFloat)top;
-(id)getCurrentView;
-(void)updateTitles:(NSMutableArray *)titles views:(NSMutableArray *)views;
-(void)showShadow;


@end


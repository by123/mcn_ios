//
//  STNavigationView.h
//  framework
//
//  Created by 黄成实 on 2018/5/10.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol STNavigationViewDelegate

-(void)OnBackBtnClicked;
-(void)onRightBtnClicked;

@end

@interface STNavigationView : UIView

@property(strong,nonatomic)UIButton *backBtn;
@property(weak, nonatomic)id delegate;

-(instancetype)initWithTitle:(NSString *)title needBack:(Boolean)needBack;

-(instancetype)initWithTitle:(NSString *)title needBack:(Boolean)needBack rightBtn:(NSString *)rightStr;

-(instancetype)initWithTitle:(NSString *)title needBack:(Boolean)needBack rightBtn:(NSString *)rightStr rightColor:(UIColor *)rightColor;

-(instancetype)initWithTitle:(NSString *)title needBack:(Boolean)needBack leftimage:(UIImage *)leftImage;

-(void)setTitle:(NSString *)title;
-(void)setTitleColor:(UIColor *)color;
-(void)setRightTitle:(NSString *)title;


@end

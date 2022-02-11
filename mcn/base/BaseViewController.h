//
//  BaseViewController.h
//  framework
//
//  Created by 黄成实 on 2018/4/17.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "STNavigationView.h"

@interface BaseViewController : UIViewController

@property(strong, nonatomic)STNavigationView *navigationView;
@property(strong,nonatomic)UIView *noDataView;
@property(strong,nonatomic)UIViewController *rootViewController;

//隐藏导航栏
-(void)hideNavigationBar : (Boolean) hidden;

//设置状态栏背景色
-(void)setStatuBarBackgroud : (UIColor *)color style:(UIStatusBarStyle)statuBarStyle;

//隐藏状态栏
-(void)hiddenStatuBar;

//push viewcontroller
-(void)pushPage : (BaseViewController *)targetPage;

-(void)backLastPage;

-(void)showSTNavigationBar:(NSString *)title needback:(Boolean)needback;

-(void)showSTNavigationBar:(NSString *)title titleColor:(UIColor *)titleColor leftImage:(UIImage *)leftImage leftblock:(void (^)(void))click;

-(void)showSTNavigationBar:(NSString *)title needback:(Boolean)needback backgroudColor:(UIColor *)backgroudColor;

-(void)showSTNavigationBar:(NSString *)title needback:(Boolean)needback rightBtn:(NSString *)rightStr block:(void (^)(void))click;

-(void)showSTNavigationBar:(NSString *)title needback:(Boolean)needback rightBtn:(NSString *)rightStr rightColor:(UIColor *)color block:(void (^)(void))click;

-(void)showSTNavigationBar:(NSString *)title leftImage:(UIImage *)leftImage;

-(void)changeSTNavigationBarRightText:(NSString *)rightStr;

-(void)setTranslateStatuBar;
-(void)cancelTranslateStatuBar;

-(void)showNoDataView:(Boolean)isShow;
-(void)showNoDataView:(Boolean)isShow height:(CGFloat)height;

@end

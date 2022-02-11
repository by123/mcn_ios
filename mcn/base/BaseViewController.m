//
//  BaseViewController.m
//  framework
//
//  Created by 黄成实 on 2018/4/17.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "BaseViewController.h"
#import "STObserverManager.h"

@interface BaseViewController ()<STNavigationViewDelegate>

@property(copy,nonatomic)void(^onRightBtnClick)(void);
@property(copy,nonatomic)void(^onLeftBtnClick)(void);

@property(strong, nonatomic)UIView *statusBar;
//@property(assign, nonatomic)Boolean isCanUseSideBack;

@end

@implementation BaseViewController


-(void)viewDidLoad{
    [super viewDidLoad];
    _rootViewController = self;
    [self hideNavigationBar:YES];
    self.view.backgroundColor = cwhite;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self setTranslateStatuBar];
    [STLog print:@"当前页面" content:NSStringFromClass([self class])];
    
    _noDataView = [[UIView alloc]initWithFrame:CGRectMake(0, StatuNavHeight, ScreenWidth, ContentHeight)];
    _noDataView.backgroundColor = cwhite;
    _noDataView.hidden = YES;
    [self.view addSubview:_noDataView];
    
    UIImageView *noDataImageView = [[UIImageView alloc]initWithFrame:CGRectMake((ScreenWidth - STWidth(100))/2, STHeight(200), STWidth(100), STWidth(100))];
    noDataImageView.image = [UIImage imageNamed:IMAGE_NO_DATA];
    noDataImageView.contentMode = UIViewContentModeScaleAspectFill;
    [_noDataView addSubview:noDataImageView];
    
    UILabel *noDataLabel = [[UILabel alloc]initWithFontFamily:[UIFont fontWithName:FONT_REGULAR size:STFont(18)] text:@"暂无数据" textAlignment:NSTextAlignmentCenter textColor:c10 backgroundColor:nil multiLine:NO];
    noDataLabel.frame = CGRectMake(0, STHeight(215) + STWidth(100) , ScreenWidth, STHeight(30));
    [_noDataView addSubview:noDataLabel];
    
    if (@available(iOS 13.0, *)) {
        _statusBar = [[UIView alloc]initWithFrame:[UIApplication sharedApplication].keyWindow.windowScene.statusBarManager.statusBarFrame];
    }
    
}

-(void)showNoDataView:(Boolean)isShow{
    _noDataView.hidden = !isShow;
    [self.view bringSubviewToFront:_noDataView];
}

-(void)showNoDataView:(Boolean)isShow height:(CGFloat)height{
    _noDataView.hidden = !isShow;
    _noDataView.frame = CGRectMake(0, height, ScreenWidth, ContentHeight);
    [self.view bringSubviewToFront:_noDataView];
}

-(void)hideNavigationBar : (Boolean) hidden{
    self.navigationController.navigationBarHidden = hidden;
}


-(void)setStatuBarBackgroud : (UIColor *)color style:(UIStatusBarStyle)statuBarStyle{
    if (@available(iOS 13.0, *)) {
        UIView *statusBar = [[UIView alloc]initWithFrame:[UIApplication sharedApplication].keyWindow.windowScene.statusBarManager.statusBarFrame] ;
        statusBar.backgroundColor = color;
        statusBar.tag = 999;
        [[UIApplication sharedApplication].keyWindow addSubview:statusBar];
        
    }else{
        UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
        if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
            statusBar.backgroundColor = color;
        }
    }
}


-(void)hiddenStatuBar{
    if (@available(iOS 13.0, *)) {
        for(UIView *view in [UIApplication sharedApplication].keyWindow.subviews){
            if(view.tag == 999){
                [view removeFromSuperview];
            }
        }
    }
}

-(void)pushPage:(BaseViewController *)targetPage{
    [self.navigationController pushViewController:targetPage animated:YES];
}

-(void)backLastPage{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)showSTNavigationBar:(NSString *)title needback:(Boolean)needback{
    _navigationView = [[STNavigationView alloc]initWithTitle:title needBack:needback];
    _navigationView.delegate = self;
    [self.view addSubview:_navigationView];
}

-(void)showSTNavigationBar:(NSString *)title needback:(Boolean)needback backgroudColor:(UIColor *)backgroudColor{
    _navigationView = [[STNavigationView alloc]initWithTitle:title needBack:needback];
    _navigationView.delegate = self;
    _navigationView.backgroundColor = backgroudColor;
    [self.view addSubview:_navigationView];
}

-(void)showSTNavigationBar:(NSString *)title needback:(Boolean)needback rightBtn:(NSString *)rightStr block:(void (^)(void))click{
    _onRightBtnClick = click;
    _navigationView = [[STNavigationView alloc]initWithTitle:title needBack:needback rightBtn:rightStr];
    _navigationView.delegate = self;
    [self.view addSubview:_navigationView];
}

-(void)showSTNavigationBar:(NSString *)title needback:(Boolean)needback rightBtn:(NSString *)rightStr rightColor:(UIColor *)color block:(void (^)(void))click{
    _onRightBtnClick = click;
    _navigationView = [[STNavigationView alloc]initWithTitle:title needBack:needback rightBtn:rightStr rightColor:color];
    _navigationView.delegate = self;
    [self.view addSubview:_navigationView];
}


-(void)showSTNavigationBar:(NSString *)title leftImage:(UIImage *)leftImage{
    _navigationView = [[STNavigationView alloc]initWithTitle:title needBack:YES leftimage:leftImage];
    _navigationView.delegate = self;
    [self.view addSubview:_navigationView];
}

-(void)changeSTNavigationBarRightText:(NSString *)rightStr{
    [_navigationView setRightTitle:rightStr];
}

-(void)OnBackBtnClicked{
    [self backLastPage];
}

-(void)onRightBtnClicked{
    _onRightBtnClick();
}


-(void)showSTNavigationBar:(NSString *)title titleColor:(UIColor *)titleColor leftImage:(UIImage *)leftImage leftblock:(void (^)(void))click{
    _navigationView = [[STNavigationView alloc]initWithTitle:title needBack:YES leftimage:leftImage];
    _navigationView.delegate = self;
    [_navigationView setTitleColor:titleColor];
    [self.view addSubview:_navigationView];
}

//设置状态栏全透明
-(void)setTranslateStatuBar{    
    //设置导航栏背景图片为一个空的image，这样就透明了
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    //去掉透明后导航栏下边的黑边
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
}

//取消状态栏全透明
-(void)cancelTranslateStatuBar{
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
}


//解决页面未加载出来，系统右滑返回接收不到事件
//-(void)viewDidAppear:(BOOL)animated{
//    [super viewDidAppear:animated];
//    [self startSideBack];
//}

//-(void)viewDidDisappear:(BOOL)animated{
//    [super viewDidDisappear:animated];
//    [self cancelSideBack];
//}


//关闭ios右滑返回

//-(void)cancelSideBack {
//    //    [STLog print:@"关闭手势"];
//    self.isCanUseSideBack = NO;
//    if([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
//        self.navigationController.interactivePopGestureRecognizer.delegate=(id)self;
//    }
//}
//
////开启ios右滑返回
//
//-(void)startSideBack {
//    //    [STLog print:@"开启手势"];
//    self.isCanUseSideBack=YES;
//    if([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
//        self.navigationController.interactivePopGestureRecognizer.delegate = nil;
//    }
//}
//
//-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer*)gestureRecognizer {
//    return self.isCanUseSideBack;
//}
@end

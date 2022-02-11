//
//  STWindowUtil.m
//  cigarette
//
//  Created by by.huang on 2019/11/18.
//  Copyright © 2019 by.huang. All rights reserved.
//

#import "STWindowUtil.h"

@implementation STWindowUtil


+(void)clearAllAndOpenNewPage:(UIViewController *)page{
      UIWindow * window = [[UIApplication sharedApplication].delegate window];
      BaseNavigationController *navigationController = [[BaseNavigationController alloc]initWithRootViewController:page];
      window.rootViewController = navigationController;
}


+(void)addWindowView:(UIView *)view{
    UIWindow * window = [[UIApplication sharedApplication].delegate window];
    [window addSubview:view];
}

+(void)removeWindowView:(UIView *)view{
    if(view){
        [view removeFromSuperview];
    }
}

+(UIViewController *)getCurrentVC{
    UIViewController *result = nil;
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal) {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows) {
            if (tmpWin.windowLevel == UIWindowLevelNormal) {
                window = tmpWin;
                break;
            }
        }
    }
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    if ([nextResponder isKindOfClass:[UIViewController class]]) {
        result = nextResponder;
    } else {
        result = window.rootViewController;
    }
    return result;
}

//改良版
+ (UIViewController *)currentController {
    UIViewController *result = nil;
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    //app默认windowLevel是UIWindowLevelNormal，如果不是，找到它
    if (window.windowLevel != UIWindowLevelNormal) {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows) {
            if (tmpWin.windowLevel == UIWindowLevelNormal) {
                window = tmpWin;
                break;
            }
        }
    }
    id nextResponder = nil;
    UIViewController *appRootVC = window.rootViewController;
    //1、通过present弹出VC，appRootVC.presentedViewController不为nil
    if (appRootVC.presentedViewController) {
        nextResponder = appRootVC.presentedViewController;
    }else{
        //2、通过navigationcontroller弹出VC
//        NSLog(@"subviews == %@",[window subviews]);
        UIView *frontView = [[window subviews] objectAtIndex:0];
        nextResponder = [frontView nextResponder];
    }
    //1、tabBarController
    if ([nextResponder isKindOfClass:[UITabBarController class]]){
        UITabBarController * tabbar = (UITabBarController *)nextResponder;
        UINavigationController * nav = (UINavigationController *)tabbar.viewControllers[tabbar.selectedIndex];
        //或者 UINavigationController * nav = tabbar.selectedViewController;
        result = nav.childViewControllers.lastObject;
    }else if ([nextResponder isKindOfClass:[UINavigationController class]]){
        //2、navigationController
        UIViewController * nav = (UIViewController *)nextResponder;
        result = nav.childViewControllers.lastObject;
    }else if ([nextResponder isKindOfClass:[UIWindow class]]) {//这个判断是因为此项目弹出登录方式导致
        result = [(UIWindow *)nextResponder rootViewController];
        if ([result isKindOfClass:[UINavigationController class]]) {
            result = result.childViewControllers.lastObject;
        }
    }else{//3、viewControler
        result = nextResponder;
    }
    return result;
}

+ (void)popViewControllerStack:(NSUInteger)count {
    UINavigationController *navigationController = [STWindowUtil currentController].navigationController;
    NSArray *viewControllers = navigationController.viewControllers;
    if (count <= 1) {
        [navigationController popViewControllerAnimated:true];
    }else if (count < viewControllers.count) {
        [navigationController popToViewController:[viewControllers objectAtIndex:(viewControllers.count - count - 1)] animated:true];
    }else {
        [navigationController popToRootViewControllerAnimated:true];
    }
}

+(UIViewController *)getController:(UINavigationController *)navigationVC getClass:(Class)getClass{
    NSMutableArray *controllers = [[NSMutableArray alloc]initWithArray:navigationVC.viewControllers];
      for (UIViewController *controller in controllers) {
          if ([controller isKindOfClass:getClass]) {
              return controller;
          }
      }
    return nil;
}

+(void)removeController:(UINavigationController *)navigationVC removeClass:(Class)removeClass{
    NSMutableArray *controllers = [[NSMutableArray alloc]initWithArray:navigationVC.viewControllers];
    for (UIViewController *controller in controllers) {
        if ([controller isKindOfClass:removeClass]) {
            [controllers removeObject:controller];
            break;
        }
    }
    navigationVC.viewControllers = controllers;
}
@end

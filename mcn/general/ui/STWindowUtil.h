//
//  STWindowUtil.h
//  cigarette
//
//  Created by by.huang on 2019/11/18.
//  Copyright © 2019 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface STWindowUtil : NSObject

//清除所有，并且打开新的页面
+(void)clearAllAndOpenNewPage:(UIViewController *)page;

//添加一个window层的view
+(void)addWindowView:(UIView *)view;

+(void)removeWindowView:(UIView *)view;

//获取当前VC
+(UIViewController *)getCurrentVC;
+ (UIViewController *)currentController;
//获取指定VC
+ (UIViewController *)getController:(UINavigationController *)navigationVC getClass:(Class)getClass;


+ (void)popViewControllerStack:(NSUInteger)count;

+(void)removeController:(UINavigationController *)navigationVC removeClass:(Class)removeClass;
@end

NS_ASSUME_NONNULL_END

//
//  AppDelegate.h
//  mcn
//
//  Created by by.huang on 2020/8/14.
//  Copyright © 2020 by.huang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) AppDelegate *app;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;
-(void)doWeChatLogin:(UIViewController *)controller;



@end


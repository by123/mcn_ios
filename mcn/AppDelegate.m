//
//  AppDelegate.m
//  cigarette
//
//  Created by by.huang on 2019/8/20.
//  Copyright © 2019 by.huang. All rights reserved.
//

//
//  AppDelegate.m
//  bus
//
//  Created by by.huang on 2018/9/13.
//  Copyright © 2018年 by.huang. All rights reserved.
//

#import "AppDelegate.h"
#import "MainPage.h"
#import "STObserverManager.h"
#import "STUpdateUtil.h"
#import "AFNetworkActivityIndicatorManager.h"
#import "STNetUtil.h"
#import "LoginPage.h"
#import "AccountManager.h"
#import "STAlertUtil.h"
#import "STNetUtil.h"
#import <Bugly/Bugly.h>
#import "STUserDefaults.h"
#import "STUpdateUtil.h"
#import <Photos/Photos.h>
#import "WXApi.h"
#import "WeChatUtil.h"
#import "ConfigModel.h"
#import "STObserverManager.h"
#import "UmengManage.h"
#import "MapManage.h"

//代理商登录
//m201911080047414

//零售商登录
//账号：m201911290069510

//平台业务员
//18800008888

//业务员
//18888886666

//直营店长
//18899996666

@interface AppDelegate ()<WXApiDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    _app = self;
    //获取配置
    //    [self getSetting];
    //页面初始化
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
    id controller;
    if([[AccountManager sharedAccountManager]isLogin]){
        controller = [[MainPage alloc]init];
    }else{
        controller = [[LoginPage alloc]init];
    }
    BaseNavigationController *navigationController = [[BaseNavigationController alloc]initWithRootViewController:controller];
    self.window.rootViewController = navigationController;
    [self.window makeKeyAndVisible];
    //观察者初始化
    [[STObserverManager sharedSTObserverManager]setup];
    //网络初始化
    [self initNet];
    //获取配置
    //    [self getConfig];
    //检测更新
    [STUpdateUtil checkUpdate:^(NSString *appname, NSString *url, double version) {

    } useSystem:NO];
    //BUG收集
    [Bugly startWithAppId:BUGLY_APPID];
    //微信初始化
//    [WXApi registerApp:WECHAT_APPID universalLink:@"https://www.icisoo.com/"];
    //友盟推送
    [[UmengManage sharedUmengManage] init:launchOptions];
    [[MapManage sharedMapManage] initMap];
    return YES;
}



-(void)doWeChatLogin:(UIViewController *)controller{
    [WeChatUtil getWeChatCode:controller delegate:self];
}

-(void)initNet{
    NSURLCache *URLCache = [[NSURLCache alloc] initWithMemoryCapacity:4 * 1024 * 1024 diskCapacity:20 * 1024 * 1024 diskPath:nil];
    [NSURLCache setSharedURLCache:URLCache];
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
    
    [STNetUtil startListenNetWork];
}


//-(void)getConfig{
//    [STNetUtil getConfig:CONFIG_ALL success:^(NSString *result) {
//        NSMutableArray *datas= [ConfigModel mj_objectArrayWithKeyValuesArray:result];
//        if(!IS_NS_COLLECTION_EMPTY(datas)){
//            for(ConfigModel *model in datas){
//                [STUserDefaults saveKeyValue:model.key value:model.value];
//            }
//        }
//    }];
//}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}


#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer  API_AVAILABLE(ios(10.0)){
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (_persistentContainer == nil) {
            if (@available(iOS 10.0, *)) {
                //                _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"bus"];
            } else {
                // Fallback on earlier versions
            }
            if (@available(iOS 10.0, *)) {
                [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                    if (error != nil) {
                        // Replace this implementation with code to handle the error appropriately.
                        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                        
                        /*
                         Typical reasons for an error here include:
                         * The parent directory does not exist, cannot be created, or disallows writing.
                         * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                         * The device is out of space.
                         * The store could not be migrated to the current model version.
                         Check the error message to determine what the actual problem was.
                         */
                        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                        abort();
                    }
                }];
            } else {
                // Fallback on earlier versions
            }
        }
    }
    
    return _persistentContainer;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}


-(void)getSetting{
    UserModel *model = [[AccountManager sharedAccountManager] getUserModel];
    if([[STConvertUtil base64Decode:MSG_TEST_ID] isEqualToString:model.mchId] || [[STConvertUtil base64Decode:MSG_TEST_ID] isEqualToString:model.userId]){
        [STUserDefaults saveKeyValue:UD_SETTING value:LIMIT_CLOSE];
    }else{
        [STUserDefaults saveKeyValue:UD_SETTING value:LIMIT_OPEN];
    }
}

-(BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options{
    return  [WXApi handleOpenURL:url delegate:self];
}


-(BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void (^)(NSArray<id<UIUserActivityRestoring>> * _Nullable))restorationHandler{
    return [WXApi handleOpenUniversalLink:userActivity delegate:self];
}


-(void)onReq:(BaseReq *)req{
    
}

-(void)onResp:(BaseResp *)resp{
    //小程序返回拉起app
    if ([resp isKindOfClass:[WXLaunchMiniProgramResp class]]){
        NSLog(@"123");
    }
    else if ([resp isKindOfClass:[PayResp class]]){
        PayResp *response = (PayResp*)resp;
        switch (response.errCode) {
            case 0:
                [[STObserverManager sharedSTObserverManager] sendMessage:NOTIFY_WECHAT_SUCCESS msg:nil];
                break;
            case -1:
                [LCProgressHUD showMessage:@"支付异常，请重试"];
                break;
            case -2:
                [LCProgressHUD showMessage:@"支付取消"];
                break;
            case -3:
                [LCProgressHUD showMessage:@"发送失败"];
                break;
            case -4:
                [LCProgressHUD showMessage:@"授权失败"];
                break;
            case -5:
                [LCProgressHUD showMessage:@"微信不支持"];
                break;
        }
    }
    else if([resp isKindOfClass:[SendAuthResp class]]) {
        SendAuthResp* authResp = (SendAuthResp*)resp;
        //        /* Prevent Cross Site Request Forgery */
        //        if (![authResp.state isEqualToString:self.authState]) {
        //           //拒绝
        //            return;
        //        }
        //
        switch (resp.errCode) {
            case WXSuccess:
                [[STObserverManager sharedSTObserverManager] sendMessage:NOTIFY_WECHAT_CODE msg:authResp.code];
                //成功
                [STLog print:@"授权成功"];
                break;
            case WXErrCodeAuthDeny:
                //拒绝
                [STLog print:@"授权拒绝"];
                break;
            case WXErrCodeUserCancel:
                //取消
                [STLog print:@"授权取消"];
            default:
                break;
        }
    }
}


/**************获取deviceToken**************/

-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    if (![deviceToken isKindOfClass:[NSData class]]) return;
    const unsigned *tokenBytes = [deviceToken bytes];
    NSString *hexToken = [NSString stringWithFormat:@"%08x%08x%08x%08x%08x%08x%08x%08x",
                          ntohl(tokenBytes[0]), ntohl(tokenBytes[1]), ntohl(tokenBytes[2]),
                          ntohl(tokenBytes[3]), ntohl(tokenBytes[4]), ntohl(tokenBytes[5]),
                          ntohl(tokenBytes[6]), ntohl(tokenBytes[7])];
    [STUserDefaults saveKeyValue:UD_DEVICE_TOKEN value:hexToken];
    NSLog(@"deviceToken:%@",hexToken);
}

- (void)application:(UIApplication*)application didFailToRegisterForRemoteNotificationsWithError:(NSError*)error {
    [STLog print:@"获取失败"];
}

/**************获取deviceToken**************/

@end

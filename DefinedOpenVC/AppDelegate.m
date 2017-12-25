//
//  AppDelegate.m
//  DefinedOpenVC
//
//  Created by MyLee on 2017/12/21.
//  Copyright © 2017年 yuekaihua. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import "NSString+PJR.h"
#import "PINCache.h"
#import "MYLPageJumpHepler.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    MainViewController *rootVc = [[MainViewController alloc] init];
    UINavigationController *rootNavigation = [[UINavigationController alloc] initWithRootViewController:rootVc];
    //设置leftBarButtonItem后无法滑动返回，这里开启iOS7的滑动返回效果
    if ([rootNavigation respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        rootNavigation.interactivePopGestureRecognizer.delegate = nil;
    }
    self.window.rootViewController = rootNavigation;
    [self.window makeKeyAndVisible];
    return YES;
}


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
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    if (url == nil) {
        return YES;
    }
    
    return [self handleOpenURL:url];
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options
{
    if (url == nil) {
        return YES;
    }
    
    return [self handleOpenURL:url];
}

- (BOOL)handleOpenURL:(NSURL *)url
{
    NSString  *urlstr = url.absoluteString;
    if ([urlstr hasPrefix:@"yuekaihua"]) {
        //外部调起
        NSString *formatUrl = [urlstr stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSArray *defineArray = [formatUrl componentsSeparatedByString:@"params="];
        if (defineArray.count > 1) {
            NSString *paramJson = defineArray[1];
            paramJson = [paramJson changeJsonStringToTrueJsonString];//将单引换成双引
            NSDictionary *params = [paramJson dictionaryWithJsonString];//转化为Dictionary
            [self outsiteJump:params];
        }
    }
    
    return YES;
}

- (void)outsiteJump:(NSDictionary *)params
{
    id currVc = [self curViewController];//当前屏幕viewcontroller
    if (currVc) {
        if ([currVc isKindOfClass:[ViewController class]]) {
            ViewController *currentVc = (ViewController *)currVc;
            MYLPageJumpHepler *pageJump = [[MYLPageJumpHepler alloc] initWithParent:currentVc];
            [pageJump clientDefineAction:params];
        }else{
            //不做处理
        }
    }else{
        //当app没有运行时，先保存数据，在主页面再跳转
        [[PINCache sharedCache] setObject:params forKey:@"OutSideJumpExtData"];
    }
}

/**获取当前屏幕显示的viewcontroller**/
- (UIViewController *)curViewController {
    UIViewController *resultVC;
    resultVC = [self _topViewController:[[UIApplication sharedApplication].keyWindow rootViewController]];
    while (resultVC.presentedViewController) {
        resultVC = [self _topViewController:resultVC.presentedViewController];
    }
    return resultVC;
}

- (UIViewController *)_topViewController:(UIViewController *)vc {
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [self _topViewController:[(UINavigationController *)vc topViewController]];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [self _topViewController:[(UITabBarController *)vc selectedViewController]];
    } else {
        return vc;
    }
    return nil;
}

@end

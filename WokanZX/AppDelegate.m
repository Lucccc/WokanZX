//
//  AppDelegate.m
//  WokanZX
//
//  Created by Lucccc on 16/9/5.
//  Copyright © 2016年 Lucccc. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeViewController.h"
#import "LeftMenuViewController.h"
#import "LaunchViewController.h"
#import "IQKeyboardManager.h"






@interface AppDelegate ()

@end

@implementation AppDelegate



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //禁止自动锁屏
    [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
    //键盘自适应iqkeyboard
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.shouldResignOnTouchOutside = YES;
    manager.shouldToolbarUsesTextFieldTintColor = YES;
    manager.enableAutoToolbar = NO;
    
    
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    LaunchViewController *lacVC = [[LaunchViewController alloc]init];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:lacVC];
    navigationController.navigationBar.hidden = YES;
    self.window.rootViewController = navigationController;
    
    
//    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:[[HomeViewController alloc] init]];
//    LeftMenuViewController *leftMenuViewController = [[LeftMenuViewController alloc] init];
//  
//    
//    RESideMenu *sideMenuViewController = [[RESideMenu alloc] initWithContentViewController:navigationController leftMenuViewController:leftMenuViewController rightMenuViewController:nil];
//    sideMenuViewController.backgroundImage = [UIImage imageNamed:@"Stars"];
//    sideMenuViewController.menuPreferredStatusBarStyle = 1; // UIStatusBarStyleLightContent
//    
//    sideMenuViewController.delegate = self;
//    //sideMenuViewController.tempViewController = rightMenuViewController;
//    //sideMenuViewController.tempViewController = nil;
//    self.window.rootViewController = sideMenuViewController;
//    
//    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    //添加leancloud
    // 如果使用美国站点，请加上下面这行代码：
    // [AVOSCloud setServiceRegion:AVServiceRegionUS];
    
    // 如果使用美国站点，请加上下面这行代码：
    // [AVOSCloud setServiceRegion:AVServiceRegionUS];
    
    [AVOSCloud setApplicationId:@"M5XeNvWuya7bRFiwtnjMhJ2o-gzGzoHsz" clientKey:@"CqeiuxOtnsgKtabHCxvrIbbc"];




  
        return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     [[UIApplication sharedApplication] setIdleTimerDisabled:NO];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end

//
//  AppDelegate.m
//  Tool For OC
//
//  Created by 曹老师 on 2018/4/17.
//  Copyright © 2018年 曹老师. All rights reserved.
//

#import "AppDelegate.h"
#import "MainController.h"
#import "LeftController.h"
#import "RightController.h"
#import "BaseNavigationController.h"
#import "MMDrawerController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    BaseNavigationController *left = [[BaseNavigationController alloc] initWithRootViewController:[[LeftController alloc] init]];
    BaseNavigationController *center = [[BaseNavigationController alloc] initWithRootViewController:[[MainController alloc] init]];
    BaseNavigationController *right = [[BaseNavigationController alloc] initWithRootViewController:[[RightController alloc] init]];
    
    _mainController = [[MMDrawerController alloc] initWithCenterViewController:center
                                                      leftDrawerViewController:left
                                                     rightDrawerViewController:right];
    _mainController.maximumLeftDrawerWidth = 100;
    _mainController.maximumRightDrawerWidth = 100;
    _mainController.openDrawerGestureModeMask = MMOpenDrawerGestureModeAll;
    _mainController.closeDrawerGestureModeMask = MMOpenDrawerGestureModeAll;
    self.window.rootViewController = _mainController;
    
    
    
    
    
    
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


@end

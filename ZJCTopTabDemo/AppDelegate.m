//
//  AppDelegate.m
//  ZJCTopTabDemo
//
//  Created by zhangjiacheng on 16/5/27.
//  Copyright © 2016年 zhangjiacheng. All rights reserved.
//

#import "AppDelegate.h"
#import "ZJCTopTabTempDemoCtrlViewController.h"
#import "ZJCTabName_View_Data.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    ZJCTabName_View_Data *tabName_View_Data1 = [[ZJCTabName_View_Data alloc] init];
    tabName_View_Data1.tabItemName = @"The Tab 1";
    tabName_View_Data1.tabItemView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    ZJCTabName_View_Data *tabName_View_Data2 = [[ZJCTabName_View_Data alloc] init];
    tabName_View_Data2.tabItemName =  @"The Tab 2";
    tabName_View_Data2.tabItemView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    ZJCTabName_View_Data *tabName_View_Data3 = [[ZJCTabName_View_Data alloc] init];
    tabName_View_Data3.tabItemName =  @"The Tab 3";
    tabName_View_Data3.tabItemView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    ZJCTabName_View_Data *tabName_View_Data4 = [[ZJCTabName_View_Data alloc] init];
    tabName_View_Data4.tabItemName =  @"T4";
    tabName_View_Data4.tabItemView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    ZJCTabName_View_Data *tabName_View_Data5 = [[ZJCTabName_View_Data alloc] init];
    tabName_View_Data5.tabItemName =  @"The Tab 5";
    tabName_View_Data5.tabItemView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    ZJCTabName_View_Data *tabName_View_Data6 = [[ZJCTabName_View_Data alloc] init];
    tabName_View_Data6.tabItemName =  @"The Tab 6";
    tabName_View_Data6.tabItemView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    ZJCTabName_View_Data *tabName_View_Data7 = [[ZJCTabName_View_Data alloc] init];
    tabName_View_Data7.tabItemName =  @"The Tab 7";
    tabName_View_Data7.tabItemView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[[ZJCTopTabTempDemoCtrlViewController alloc] initWithNameViewDataArray:@[tabName_View_Data1,tabName_View_Data2,tabName_View_Data3,tabName_View_Data4,tabName_View_Data5, tabName_View_Data6, tabName_View_Data7]]];
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end

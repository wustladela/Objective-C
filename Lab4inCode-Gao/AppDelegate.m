//
//  AppDelegate.m
//  Lab4inCode-Gao
//
//  Created by Adela on 7/7/14.
//  Copyright (c) 2014 Adela Xinyuan Gao. All rights reserved.
//

#import "AppDelegate.h"
#import "FirstViewController.h"
#import "ThirdViewController.h"
#import "myTableViewController.h"


@implementation AppDelegate
@synthesize window;
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    //myTable = [[SecondViewController alloc]initWithStyle:UITableViewStylePlain];
    //[window addSubview:myTable.view];
    FirstViewController *myFirst = [[FirstViewController alloc]initWithNibName:@"FirstViewController" bundle:nil];
    ThirdViewController *myThird = [[ThirdViewController alloc]initWithNibName:@"ThirdViewController" bundle:nil];
    
    
    UINavigationController *myNav = [[UINavigationController alloc]initWithRootViewController:myThird];
    
    UITabBarController *myTabVC = [[UITabBarController alloc]init];
    myTableVC = [[myTableViewController alloc]initWithStyle:UITableViewStylePlain];
    
    myFirst.tabBarItem.title=@"First~";
    myFirst.tabBarItem.image=[UIImage imageNamed:@"airplane.png"];
    myTableVC.tabBarItem.title=@"Second~";
    myTableVC.tabBarItem.image=[UIImage imageNamed:@"antique-vase.png"];
    myNav.tabBarItem.image=[UIImage imageNamed:@"camera.png"];
    myNav.tabBarItem.title=@"Here!";
    myTabVC.viewControllers=[NSArray arrayWithObjects:myFirst,myTableVC,myNav, nil];
    self.window.rootViewController=myTabVC;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end

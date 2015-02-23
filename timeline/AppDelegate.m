//
//  AppDelegate.m
//  timeline
//
//  Created by Adela on 7/19/14.
//  Copyright (c) 2014 Adela Xinyuan Gao. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import <Parse/Parse.h>
#import "ThirdViewController.h"
@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    [Parse setApplicationId:@"z3neptOYHOC2MIo1FR3dPbIVFtPCHkK9oFpUb9gV"
                  clientKey:@"oEEN1aGWraPkfSKkV4FC4nFb5nTTA6I83ahItNId"];

    [PFFacebookUtils initializeFacebook];
    
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    UINavigationController *myNav =[[UINavigationController alloc] init];
    
    FirstViewController *firstVC = [[FirstViewController alloc]initWithNibName:@"FirstViewController" bundle:nil];
    [myNav pushViewController:firstVC  animated:NO];
    
    SecondViewController *secondVC = [[SecondViewController alloc]initWithNibName:@"SecondViewController" bundle:nil];
    ThirdViewController *thirdVC = [[ThirdViewController alloc]initWithNibName:@"ThirdViewController" bundle:nil];
    //UINavigationController *myNav = [[UINavigationController alloc]initWithRootViewController:firstVC];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *VC = [storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
    //ViewController *VC = [[ViewController alloc]initWithNibName:@"Main.storyboard" bundle:nil];
    UITabBarController *tabBarVC = [[UITabBarController alloc]init];
    firstVC.tabBarItem.title=@"first";
    secondVC.tabBarItem.title=@"second";
    VC.tabBarItem.title=@"timeline";
    myNav.tabBarItem.title=@"Analysis";
    //thirdVC.tabBarItem.title=@"score";
   
    tabBarVC.viewControllers = [NSArray arrayWithObjects:myNav, VC, nil];
    self.window.rootViewController=tabBarVC;
    self.window.backgroundColor=[UIColor whiteColor];
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
    [FBAppCall handleDidBecomeActiveWithSession:[PFFacebookUtils session]];
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    return [FBAppCall handleOpenURL:url
                  sourceApplication:sourceApplication
                        withSession:[PFFacebookUtils session]];
}


@end

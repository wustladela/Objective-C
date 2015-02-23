//
//  AppDelegate.h
//  Lab4inCode-Gao
//
//  Created by Adela on 7/7/14.
//  Copyright (c) 2014 Adela Xinyuan Gao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "myTableViewController.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate> {
    UIWindow *window;
    myTableViewController *myTableVC;
}

@property (strong, nonatomic) UIWindow *window;

@end

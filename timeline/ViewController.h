//
//  ViewController.h
//  timeline
//
//  Created by Adela on 7/19/14.
//  Copyright (c) 2014 Adela Xinyuan Gao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>

@interface ViewController : UIViewController <
UITableViewDataSource, UITableViewDelegate> {
    int wordCount;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UISlider *mySlider;
@property (strong, nonatomic) IBOutlet UIButton *myButton;
@property (strong, nonatomic) IBOutlet UIWebView *myWeb;
@end

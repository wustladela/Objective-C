//
//  SecondViewController.m
//  timeline
//
//  Created by Adela on 7/19/14.
//  Copyright (c) 2014 Adela Xinyuan Gao. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController
@synthesize displayCount;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSNumber *temp = [[NSUserDefaults standardUserDefaults] objectForKey:@"wordCount"];
    
    displayCount.text=[NSString stringWithFormat:@"%d",(temp.intValue)];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

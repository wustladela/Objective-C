//
//  ThirdViewController.m
//  timeline
//
//  Created by Adela on 7/22/14.
//  Copyright (c) 2014 Adela Xinyuan Gao. All rights reserved.
//

#import "ThirdViewController.h"
#import <Parse/Parse.h>
@interface ThirdViewController ()
@property (weak, nonatomic) NSNumber *score;
@property (weak, nonatomic) NSString *username;
@property (weak, nonatomic) NSDate *date;
@end

@implementation ThirdViewController
//@synthesize window;
@synthesize textField;


- (IBAction)insert:(id)sender {
    
    
    
    
//    NSNumber *userScore = [[NSNumber alloc]init];
//    userScore = [NSNumber numberWithInteger:0];
    //PFQuery *queryUserData = [PFQuery queryWithClassName:@"userData"];
    //PFObject *userData = [queryUserData getObjectInBackgroundWithId:@"Np0xUlxIqp" block:^(PFObject *userData, NSError *error){
        //NSLog(@"%@", userData);
//    }];
//    //[query getObjectInBackgroundWithId:@"xWMyZ4YEGZ" block:^(PFObject *gameScore, NSError *error)
//    
//    NSNumber *tempNumber = (NSNumber *) [userData objectForKey:@"score"];//parse the data! make sure the target is not just a pointer or anything
//    self.score = [NSNumber numberWithInteger:tempNumber.integerValue];
//    self.date = (NSDate *) [userData objectForKey:@"date"];
//    self.username = (NSString *) [userData objectForKey:@"username"];
//    NSLog(@"%@, %@, %@",self.username, self.score, self.date);
//
//    textField.text = [NSString stringWithFormat:@"%@, %@, %@",self.username, self.score, self.date];
//    
//
}


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
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

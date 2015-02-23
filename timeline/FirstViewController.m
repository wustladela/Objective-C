//
//  FirstViewController.m
//  timeline
//
//  Created by Adela on 7/19/14.
//  Copyright (c) 2014 Adela Xinyuan Gao. All rights reserved.
//

#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ViewController.h"
@interface FirstViewController ()

@end

@implementation FirstViewController
@synthesize input;
- (IBAction)buttonPressed:(id)sender{
    SecondViewController *scoreView = [[SecondViewController alloc]initWithNibName:@"SecondViewController" bundle:nil];
    
    NSLog(@"The text is %@",self.input.text);
    
    //[self.navigationController pushViewController:scoreView animated:YES];
    NSString *userInput = [[NSString alloc]initWithString:input.text];
    //NSUserDefaults *input = [[NSUserDefaults standardUserDefaults]]
    [[NSUserDefaults standardUserDefaults]  setObject:userInput   forKey:@"userInput"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self.navigationController pushViewController:scoreView animated:YES];
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (IBAction)frequencyPressed:(id)sender {
    NSString *userNameStored = [[NSUserDefaults standardUserDefaults] objectForKey:@"user_name"];
//@"userWords=%@&user_name=%@"
    NSString *noteDataString = [NSString stringWithFormat:@"user_name=%@", userNameStored];
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
    NSString *url = [NSString stringWithFormat:@"http://ec2-54-183-122-44.us-west-1.compute.amazonaws.com/~gaoadela/436final/seeWordCloud.html"];
    //IMPORTANT NOTICE
    //mongodb does not work for saving and retrieving data; add pieces of strings together and use "loadHTML from String"does not work;
    //-----so I use Mysql here;
    //tried adding the filtered array (filtered all non-alphabetical characters) and send them through URL to another php page did not work----URL too long
    //so I tried to have one button directly loading a web page showing word cloud - failed
    //REASON:
    //the php page keeps displaying "status": "nothing" which means there is no user timeline from the database found
    //however, when I use the seeWordCloud.html, it takes username input and can display user timeline from mysql database successfully
    //therefore, there must be a problem with passing post variables from iOS to php
    //however, I cannot detect any errors in this process. the username variable here is exactly correct;
    //the mysql database is exactly working because seeWordCloud.html works
    //Conclusion: so far the only method that works is, I have to open another page and let user input their names...
    //I thought about using php and passing variable through URL but that did not work either
    //so, of all those methods I've tried to have Word Cloud, I have to use this one for now
    
    //please scroll down and throughout the screen to see the entire Word Cloud. Enjoy!
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setHTTPBody:[noteDataString dataUsingEncoding:NSUTF8StringEncoding]];
    NSURLSessionDataTask * dataTask =[defaultSession dataTaskWithRequest:urlRequest completionHandler:^(NSData *dataRaw, NSURLResponse *header, NSError *error) {
        NSDictionary *json = [NSJSONSerialization
                              JSONObjectWithData:dataRaw
                              options:kNilOptions error:&error];
        NSString *status = json[@"status"];
        NSData *dataURL = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
        NSString *strResult = [[NSString alloc]initWithData:dataURL encoding:NSUTF8StringEncoding];
        NSLog(@"RESULT OF displaying DATA: %@", status);
        NSLog(@"Local error: %@",[error localizedDescription]);
        UIApplication *mySafari = [UIApplication sharedApplication];
        NSURL *myURL = [[NSURL alloc]initWithString:url];
        [mySafari openURL:myURL];
    
    }];
    
    [dataTask resume];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

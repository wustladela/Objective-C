//
//  ThirdViewController.m
//  Lab4inCode-Gao
//
//  Created by Adela on 7/7/14.
//  Copyright (c) 2014 Adela Xinyuan Gao. All rights reserved.
//

#import "ThirdViewController.h"
#import "FourthViewController.h"
@interface ThirdViewController ()

@end

@implementation ThirdViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(IBAction)buttonPressed:(id)sender {
    NSLog(@"In here");
    FourthViewController *pushScreen = [[FourthViewController alloc]initWithNibName:@"FourthViewController" bundle:nil];
    
    [self.navigationController pushViewController:pushScreen animated:YES];
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=@"Here!";
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

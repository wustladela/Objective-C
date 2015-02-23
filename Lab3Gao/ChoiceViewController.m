//
//  ChoiceViewController.m
//  Lab3Gao
//
//  Created by Adela on 7/2/14.
//  Copyright (c) 2014 WUSTL. All rights reserved.
//

#import "ChoiceViewController.h"
#import "ViewController.h"

@interface ChoiceViewController ()

@end

@implementation ChoiceViewController

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Make sure your segue name in storyboard is the same as this line
    if ([[segue identifier] isEqualToString:@"playerDetail"])
    {
        // Get reference to the destination view controller
        ViewController *vc = [segue destinationViewController];
        //the tag of the button selected
        NSInteger tagIndex = [(UIButton *)sender tag];
        [vc setSelectedButton:tagIndex];
        NSLog(@"tagIndex = %d", tagIndex);
        
    }
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
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

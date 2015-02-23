//
//  ViewController.m
//  timeline
//
//  Created by Adela on 7/19/14.
//  Copyright (c) 2014 Adela Xinyuan Gao. All rights reserved. For the part displaying user timeline, see below:
//  Copyright (c) http://www.youtube.com/watch?v=DMm5t4APGMM Vea Software.
//

#import "ViewController.h"
#import <Accounts/Accounts.h>
#import <Social/Social.h>
#import <Parse/Parse.h>

@interface ViewController ()
@property (strong, nonatomic) NSArray *array;
@property (strong, nonatomic) NSMutableDictionary *storedTimeline;
@property (strong, nonatomic) NSMutableString *temp;
@property (strong, nonatomic) NSMutableArray *keyWords;
@property (strong, nonatomic) NSMutableArray *tweetTime;
@property (strong, nonatomic) NSString *screenName;
@property (strong, nonatomic) NSMutableArray *user;
@property (strong, nonatomic) NSMutableArray *tweets;
@property (strong, nonatomic) NSMutableDictionary *analysis;
@property (strong, nonatomic) NSArray *splitContainer;
@property (strong, nonatomic) NSMutableString *sendData;
@property (strong, nonatomic) NSMutableString *userKeyword;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tweets = [[NSMutableArray alloc]init];
    self.analysis = [[NSMutableDictionary alloc]init];
    self.splitContainer = [[NSArray alloc]init];
    self.analysis= [[NSMutableDictionary alloc]init];
    self.sendData  =[[NSMutableString alloc]init];
    self.userKeyword = [[NSMutableString alloc]init];
    [self twitterTimeline];
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark Table View Data Source Methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.array.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    NSDictionary *tweet = _array[indexPath.row];
    cell.textLabel.text = tweet[@"text"];
    
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)twitterTimeline {
    
    //  self.array = [[NSMutableArray alloc]init];
    wordCount = 0;
   // NSNumber *wordCount = [NSNumber numberWithInt:0];
//NSMutableArray *tweets = [[NSMutableArray alloc]init];
    NSString *stored = [[NSUserDefaults standardUserDefaults] objectForKey:@"userInput"];
    self.userKeyword = [[NSString alloc]initWithString:stored];
    self.keyWords = [NSMutableArray arrayWithObject:self.userKeyword];
    ACAccountStore *account = [[ACAccountStore alloc]init];
    ACAccountType *accountType = [account accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];//twitter account
   
    [account requestAccessToAccountsWithType:accountType options:nil completion:^(BOOL granted, NSError *error) {

//        Here you go: twitterAccout.username should return the actual username
        if (granted==YES) {
            NSArray *arrayOfAccounts = [account accountsWithAccountType:accountType];
            if ([arrayOfAccounts count]>0) {
               ACAccount *twitterAccount = [arrayOfAccounts firstObject]; //first account
                //ACAccount *fbAccount = [arrayOfAccounts firstObject];
                NSURL *requestAPI = [NSURL URLWithString:@"https://api.twitter.com/1.1/statuses/user_timeline.json"];
                NSLog(@"username: %@",twitterAccount.username);
                self.screenName=twitterAccount.username;
                [[NSUserDefaults standardUserDefaults]  setObject:[NSString stringWithString:self.screenName]   forKey:@"user_name"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
                [parameters setObject:@"30" forKey:@"count"];//how many json objects we need
                [parameters setObject:@"1" forKey:@"include_entities"];//get objects
                SLRequest *posts = [SLRequest requestForServiceType:SLServiceTypeTwitter requestMethod:SLRequestMethodGET URL:requestAPI parameters:parameters];
                posts.account=twitterAccount;
                //if there is response we do..; if error then do *error
                [posts performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
                    
                    self.array=[NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:&error];
                    self.storedTimeline=[NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:&error];
                    if ([self.array count]!=0) {
                        //run this after this method finishes
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [self.tableView reloadData];
                           //NSLog(@"%@", self.array);
                            for (int i=0; i<[self.array count]; i++) {
                                self.temp = [[self.array objectAtIndex:i] objectForKey:@"text"];
                                
                                self.tweetTime = [[self.array objectAtIndex:i] objectForKey:@"created_at"];
//
                                //NSLog(@"created at: %@", self.tweetTime);
                                //tweets only:
                                [self.tweets addObject:self.temp];
                                //NSLog(@"self.tweets inside method: %@", self.tweets);
//NSString *filtered = [[tempString componentsSeparatedByCharactersInSet:[[NSCharacterSet letterCharacterSet] invertedSet]]componentsJoinedByString:@" "];
                       [[self.temp componentsSeparatedByCharactersInSet:[[NSCharacterSet letterCharacterSet] invertedSet]]componentsJoinedByString:@" "];
                                if ([self.temp rangeOfString:self.userKeyword].location!=NSNotFound) {
                                    //NSLog(@"found a tweet containing keyword: %@", self.temp);
                                    wordCount++;
                                    
                                    NSLog(@"wordcount: %d", wordCount);
                                }

                            }
                            NSLog(@"all tweets: %@", self.tweets);
                            //NSLog(@"self.temp: %@", self.temp);
                            [self calcScore: wordCount  thisLabel:twitterAccount.username];
                        [self frequencyAnalysis];
                        });
                        
                    }
                    
                }];
                
                
            }
            
        }
        else {
            NSLog(@"%@", [error localizedDescription]);
        }
    }];
    
    
}
-(void)frequencyAnalysis {
    BOOL exists = NO;
    //NSLog(@"self.tweets----: %@", self.tweets);
    NSString *tempString = [self.tweets componentsJoinedByString:@" "];
    //NSLog(@"temp string: ~~~~%@", tempString);
    NSString *filtered = [[tempString componentsSeparatedByCharactersInSet:[[NSCharacterSet letterCharacterSet] invertedSet]]componentsJoinedByString:@" "];
    self.splitContainer=[filtered componentsSeparatedByString:@" "];
    
    //NSString *finishFilter = [[self.splitContainer componentsSeparatedByCharactersInSet:[[NSCharacterSet letterCharacterSet] invertedSet]] componentsJoinedByString:@""];
    //NSMutableString *finishFilter = [[NSMutableString alloc]init];
        NSLog(@"container: %@", self.splitContainer);
    NSNumber *frequency = [[NSNumber alloc]initWithInt:0];
    for (int i=0; i<[self.splitContainer count]; i++){
        if ([self.analysis objectForKey:self.splitContainer[i]]){
            exists=YES;
        }
        if ((!exists)&&[self.splitContainer[i] length]>3){
            [self.analysis setObject:frequency forKey:self.splitContainer[i]];
        }
        if ((exists)&&[self.splitContainer[i] length]>3){
            
            
           NSNumber *temp = [self.analysis objectForKey:self.splitContainer[i]];
            NSLog(@"The nsnumber is %@",temp);
            int tempInt = temp.intValue;
            tempInt++;
            
            NSNumber *newValue = [NSNumber numberWithInt:tempInt];
            [self.analysis setObject:newValue forKey:self.splitContainer[i]];
        }
    }
    NSLog(@"analysis: %@",self.analysis);
    // convert
    //NSData *analysis_json = [NSJSONSerialization dataWithJSONObject:self.analysis options:0 error:nil];
    NSMutableString *loopKey = [[NSMutableString alloc]init];
    
    for (id key in self.analysis) {
        //id value = [self.analysis objectForKey:key];
        //int valueNum = value;
        loopKey=key;
        loopKey = [NSMutableString stringWithFormat:@"%@ ",loopKey];
        NSNumber *num = [self.analysis objectForKey:key];
        int theValue = [num intValue];
        //NSLog(@"key: %@, value: %d", loopKey, theValue);
        for (int i=0; i<theValue; i++){
            [self.sendData appendString:loopKey];
        }
    }
        NSLog(@"sendData:%@", self.sendData);
    
    
    //[self openWeb];
    
}

-(void)openWeb {
//    NSString *piece1 = [[NSString alloc]initWithString:@"<!DOCTYPE html>
//                        <meta charset="utf-8">
//                        <body>
//                        <script src="/Users/adela/Downloads/d3-cloud-master/lib/d3/d3.js"></script>
//                        <script src="/Users/adela/Downloads/d3-cloud-master/d3.layout.cloud.js"></script>
//                        <script>
//                        var fill = d3.scale.category20();
//                        
//                        d3.layout.cloud().size([300, 300])
//                        .words([
//                        "];
//    NSString *piece1 = [[NSString alloc]initWithString:@"<!DOCTYPE html><meta charset=\”utf-8\”>
//<body>
//                        <script src=\”http://ec2-54-183-122-44.us-west-1.compute.amazonaws.com/~gaoadela/d3-cloud-master/lib/d3/d3.js\”></script>
//                        <script src=\”http://ec2-54-183-122-44.us-west-1.compute.amazonaws.com/~gaoadela/d3-cloud-master/d3.layout.cloud.js\”></script>
//                        <script>
//                        var fill = d3.scale.category20();
//                        
//                        d3.layout.cloud().size([300, 300])
//                        .words([
//"];
    
    
    
    
    
    NSString *noteDataString = [NSString stringWithFormat:@"userWords=%@&user_name=%@", self.sendData, @"testINPUT"];
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];

    NSString *url = [NSString stringWithFormat:@"http://ec2-54-183-122-44.us-west-1.compute.amazonaws.com/~gaoadela/436final/insertTimeline.php"];
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
    NSLog(@"RESULT OF INSERTING DATA: %@", strResult);
    UIApplication *mySafari = [UIApplication sharedApplication];
    NSURL *myURL = [[NSURL alloc]initWithString:url];
    [mySafari openURL:myURL];
//        if([status isEqual:@"1"]){
//            NSLog(@"insert data success!!!");
//            
//        } else {
//            //Error
//            NSLog(@"insert data error");
//        }
    }];
    
    [dataTask resume];

}
//BELOW is an experimental method;
//it works, but the context of score is unclear since we don't have a comprehensive word bank for evaluation
//so I slightly modified the UI and let it display the word count instead
-(void)calcScore: (int)wordcount thisLabel:(NSString *)screenname{
    //NSLog(@"%@", self.screenName);
    //NSNumber *score = [NSNumber numberWithInt:850-wordCount];
    //NSLog(@"calc score: %@",score);
//    NSDate *now = [NSDate date];
//    PFObject *userData = [PFObject objectWithClassName:@"userData"];
//    userData[@"username"]=screenname;
//    //userData[@"score"]=score;
//    userData[@"date"]=now;
//    [userData saveInBackground];
//    PFQuery *queryUserData = [PFQuery queryWithClassName:@"userData"];
//    
    int score;
    score = 850 - (wordCount * 5);
    NSLog(@"Your score is %d", score);
    [[NSUserDefaults standardUserDefaults]  setObject:[NSNumber numberWithInt:wordCount]   forKey:@"wordCount"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    if (score > 800){
        NSLog(@"You have an excellent score!");
        UILabel *headingLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 240, 500, 30)];
        UILabel *scoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 240, 500, 80)];
        [self.view addSubview:headingLabel];
        [self.view addSubview:scoreLabel];
        NSString *tempString = [NSString stringWithFormat:@"You have a score of %d.",score];
        //headingLabel.text = tempString;
        //scoreLabel.text = @"That is an excellent score!";
        self.mySlider.value = 1.0;
    }
    
    else if(score <= 800 & score > 700)
    {
        NSLog(@"You have a great score!");
        UILabel *headingLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 240, 500, 30)];
        UILabel *scoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 240, 500, 80)];
        [self.view addSubview:headingLabel];
        [self.view addSubview:scoreLabel];
        NSString *tempString = [NSString stringWithFormat:@"You have a score of %d.",score];
        scoreLabel.text = @"That is a great excellent score!";
        headingLabel.text = tempString;
        
        self.mySlider.value = .8;
    }
    else if( score <= 700 & score > 600)
    {
        NSLog(@"You have a good score!");
        UILabel *headingLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 240, 500, 30)];
        UILabel *scoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 240, 500, 80)];
        [self.view addSubview:headingLabel];
        [self.view addSubview:scoreLabel];
        NSString *tempString = [NSString stringWithFormat:@"You have a score of %d.",score];
        scoreLabel.text = @"That is a good score!";
        headingLabel.text = tempString;
        
        self.mySlider.value = .7;
    }
    else if(score <= 600 & score > 500 ){
        NSLog(@"You have an OK score!");
        UILabel *headingLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 240, 500, 30)];
        UILabel *scoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 240, 500, 80)];
        [self.view addSubview:headingLabel];
        [self.view addSubview:scoreLabel];
        NSString *tempString = [NSString stringWithFormat:@"You have a score of %d.",score];
        headingLabel.text = tempString;
        scoreLabel.text = @"That is an OK score!";
        self.mySlider.value = .5;
    }
    else if ( score <= 500 & score > 400){
        NSLog(@"You have a fair score!");
        UILabel *headingLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 240, 500, 30)];
        UILabel *scoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 240, 500, 80)];
        [self.view addSubview:headingLabel];
        [self.view addSubview:scoreLabel];
        NSString *tempString = [NSString stringWithFormat:@"You have a score of %d.",score];
        headingLabel.text = tempString;
        scoreLabel.text = @"That is a fair score!";
        self.mySlider.value = .3;
    }
    else if (score <= 400){
        NSLog(@"You have a poor score!");
        UILabel *headingLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 240, 500, 30)];
        UILabel *scoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 240, 500, 80)];
        [self.view addSubview:scoreLabel];
        [self.view addSubview:headingLabel];
        NSString *tempString = [NSString stringWithFormat:@"You have a score of %d.",score];
        headingLabel.text = tempString;
        scoreLabel.text = @"That is a poor score!";
        self.mySlider.value = .1;
    }
    
    
    
//    PFObject *data = [queryUserData getObjectInBackgroundWithId:@"Np0xUlxIqp" block:^(PFObject *userData, NSError *error)]};
//    
//    NSString *objectId = [userData objectId];
//    NSLog(@"OBJECT id:%@", objectId);
    
    
}
@end

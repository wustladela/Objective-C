//
//  myTableViewController.h
//  Lab4inCode-Gao
//
//  Created by Adela on 7/8/14.
//  Copyright (c) 2014 Adela Xinyuan Gao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface myTableViewController : UITableViewController {
    NSMutableArray *names;
    
}
@property(nonatomic,retain)NSMutableArray *names;
@property(nonatomic,retain)NSArray *names2;
- (void) loadDatabase;

@end

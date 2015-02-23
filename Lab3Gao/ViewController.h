//
//  ViewController.h
//  Lab3Gao
//
//  Created by Adela on 6/23/14.
//  Copyright (c) 2014 WUSTL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController {
    
    __weak IBOutlet UIButton *AIButton;
    __weak IBOutlet UIButton *HumanStartButton;
    int board[5][5];
    int playerNum;
    __weak IBOutlet UIButton *button01;
    __weak IBOutlet UIButton *button02;
    __weak IBOutlet UIButton *button03;
    __weak IBOutlet UIButton *button04;
    __weak IBOutlet UIButton *button05;
    __weak IBOutlet UIButton *button06;
    __weak IBOutlet UIButton *button07;
    __weak IBOutlet UIButton *button08;
    __weak IBOutlet UIButton *button09;
    __weak IBOutlet UILabel *pressedTimes;
    __weak IBOutlet UIButton *restartButton;
}
@property (nonatomic) NSInteger selectedButton;
@end

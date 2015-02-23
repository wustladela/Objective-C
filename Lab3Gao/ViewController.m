    //
    //  ViewController.m
    //  Lab3Gao
    //
    //  Created by Adela on 6/23/14.
    //  Copyright (c) 2014 WUSTL. All rights reserved.
    //

    #import "ViewController.h"
#import "ChoiceViewController.h"
//NEED TO FIX: MOVE FIRST OR SECOND? add an alert!!!
//ADD COMPUTER MOVE ACCORDING TO THE SCREEN
    @interface ViewController ()
    @property (nonatomic) int count;
    @property (nonatomic) int criticalCol;
    @property (nonatomic) int criticalRow;
    @property (nonatomic) int order;
@property (nonatomic) int tie;
    @end

    @implementation ViewController
@synthesize selectedButton;

//- See more at: http://getsetgames.com/2009/12/02/iphonedev-advent-tip-2-how-to-show-an-alert-with-uialertview/#sthash.VF3MLS5b.dpuf

//General rule: self.count=0 for x; self.count = 1 for o. x is first, o is second, and always.
    - (IBAction)button01Pressed:(id)sender {
        
        if (self.count%2==0) {
            [sender setTitle:@"x" forState:UIControlStateNormal];
        pressedTimes.text = [NSString stringWithFormat:@"%@", @"It's player o's turn."];
            if (sender==button01) {
                board[0][0]=1;
            }
            if (sender==button02) {
                board[0][1]=1;
            }
            if (sender==button03) {
                board[0][2]=1;
            }
            if (sender==button04) {
                board[1][0]=1;
            }
            if (sender==button05) {
                board[1][1]=1;
            }
            if (sender==button06) {
                board[1][2]=1;
            }
            if (sender==button07) {
                board[2][0]=1;
            }
            if (sender==button08) {
                board[2][1]=1;
            }
            if (sender==button09) {
                board[2][2]=1;
            }
            [self winning];
            for(int i=0; i<5; i++) {
                for (int j=0; j<5; j++) {
            //        NSLog(@"board: @%d at row %d col %d",board[i][j],i,j);
                }
            }
            //self.count++;
            NSLog(@"self.count after x = %d", self.count);
        }

        if (self.count%2==1 && playerNum==2) {
            [sender setTitle:@"o" forState:UIControlStateNormal];
            pressedTimes.text=[NSString stringWithFormat:@"%@", @"It's player x's turn."];
            if (sender==button01) {
                board[0][0]=-1;
            }
            if (sender==button02) {
                board[0][1]=-1;
            }
            if (sender==button03) {
                board[0][2]=-1;
            }
            if (sender==button04) {
                board[1][0]=-1;
            }
            if (sender==button05) {
                board[1][1]=-1;
            }
            if (sender==button06) {
                board[1][2]=-1;
            }
            if (sender==button07) {
                board[2][0]=-1;
            }
            if (sender==button08) {
                board[2][1]=-1;
            }
            if (sender==button09) {
                board[2][2]=-1;
            }
            [self winning];
            
            for(int i=0; i<5; i++) {
                for (int j=0; j<5; j++) {
            //        NSLog(@"@board: %d",board[i][j]);
                }
            }
            NSLog(@"self.count after o = %d", self.count);
            //pressedTimes.text = [NSString stringWithFormat:@"%@", @"It's player o's turn."];
        }
        self.count++;
        if (self.count%2==1 && playerNum==1) [self SillyComputerMove]; //odd number for computer move!
        }

    -(void)updateButtonText {
        for (int i=0; i<3;i++) {
            for (int j=0; j<3; j++) {
                if (board[i][j]==1 || board[i][j]==-1) {
                    if (board[0][0]==1) [button01 setTitle:@"x" forState:UIControlStateNormal];
                    if (board[0][0]==-1) [button01 setTitle:@"o" forState:UIControlStateNormal];
                    if (board[0][1]==1) [button02 setTitle:@"x" forState:UIControlStateNormal];
                    if (board[0][1]==-1) [button02 setTitle:@"o" forState:UIControlStateNormal];
                    if (board[0][2]==1) [button03 setTitle:@"x" forState:UIControlStateNormal];
                    if (board[0][2]==-1) [button03 setTitle:@"o" forState:UIControlStateNormal];
                    if (board[1][0]==1) [button04 setTitle:@"x" forState:UIControlStateNormal];
                    if (board[1][0]==-1) [button04 setTitle:@"o" forState:UIControlStateNormal];
                    if (board[1][1]==1) [button05 setTitle:@"x" forState:UIControlStateNormal];
                    if (board[1][1]==-1) [button05 setTitle:@"o" forState:UIControlStateNormal];
                    if (board[1][2]==1) [button06 setTitle:@"x" forState:UIControlStateNormal];
                    if (board[1][2]==-1) [button06 setTitle:@"o" forState:UIControlStateNormal];
                    if (board[2][0]==1) [button07 setTitle:@"x" forState:UIControlStateNormal];
                    if (board[2][0]==-1) [button07 setTitle:@"o" forState:UIControlStateNormal];
                    if (board[2][1]==1) [button08 setTitle:@"x" forState:UIControlStateNormal];
                    if (board[2][1]==-1) [button08 setTitle:@"o" forState:UIControlStateNormal];
                    if (board[2][2]==1) [button09 setTitle:@"x" forState:UIControlStateNormal];
                    if (board[2][2]==-1) [button09 setTitle:@"o" forState:UIControlStateNormal];
                }
            }
        }
        }
    /*-(void)ComputerMove {
        BOOL madeMove = false;
        [self checkCriticalStep];//PROBLEM DETECTED! 4 [SELF CHECKcriticalstep] here, so check 4 times!
       //WHY IS THIS RUNNED TWICE????
        NSLog(@"checked critical! The value of checkedCriticalStep is: %hhd", [self checkCriticalStep]);//why checking critical again?
        //BOOL notCritical = ![self checkCriticalStep];
        if ([self checkCriticalStep]==true) [self makeCriticalMove];
        else if ([self checkCriticalStep]==false) {
            NSLog(@"not critical!");
            for (int i=0; i<3; i++) {
                if (madeMove) break;
                for (int j=0; j<3; j++) {
                    if(madeMove) break;
                    if (board[i][j]==0) {
                        if (self.count%2==1) board[i][j]=-1;//careful!change 1 etc to a variable to follow who moved first
                            else board[i][j]=1;
                        [self updateButtonText];
                        self.count++;
                        madeMove=true;
                        NSLog(@"%@", @"Made normal move");
                        //break;
                        
                    }
                    
                }
            }
        }
        //if ([self checkCriticalStep]) madeMove=true;
        
    }
    */
    -(void)checkBoard {//for winning and critical step
        board[0][3] = board[0][0]+board[0][1]+board[0][2];
        board[1][3] = board[1][0]+board[1][1]+board[1][2];
        board[2][3] = board[2][0]+board[2][1]+board[2][2];
        board[3][0] = board[0][0]+board[1][0]+board[2][0];
        board[3][1] = board[0][1]+board[1][1]+board[2][1];
        board[3][2] = board[0][2]+board[1][2]+board[2][2];
        board[3][3] = board[0][0]+board[1][1]+board[2][2];
        board[4][4] = board[2][0]+board[1][1]+board[0][2];
    }
    - (void)winning {
        self.tie=1;
        BOOL showedAlert = false;
        [self checkBoard];
        for (int i=0; i<5; i++) {
            for (int j=0; j<5; j++) {
                if (board[i][j]==3) {
                    if (showedAlert==true)break;
                    pressedTimes.text=[NSString stringWithFormat:@"%@", @"Player x has won!"];
                    UIAlertView *restart = [[UIAlertView alloc]initWithTitle:@"Player x won!" message:@"Game over! Click restart to restart a game." delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
                    restart.tag=1;
                    [restart show];
                    showedAlert=true;
                }
                if (board[i][j]==-3) {
                    if (showedAlert==true)break;
                    pressedTimes.text=[NSString stringWithFormat:@"%@", @"Player o has won!"];
                    UIAlertView *restart = [[UIAlertView alloc]initWithTitle:@"Player o won!" message:@"Game over! Click restart to restart a game." delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
                    restart.tag=1;
                    [restart show];
                    showedAlert=true;
                }
            }
        }
        //check tie
        for (int ii=0; ii<3; ii++) {
            for (int jj=0; jj<3; jj++) {
                self.tie=self.tie*board[ii][jj];
                NSLog(@"self.tie: %d", self.tie);
            }
        }
        if(self.tie!=0) {
            NSLog(@"Tie!!");
            //if (showedAlert==true)break;
            UIAlertView *restart = [[UIAlertView alloc]initWithTitle:@"Tied" message:@"Game over! Tied. Click restart to restart a game." delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
            restart.tag=1;
            [restart show];
            showedAlert=true;
            pressedTimes.text=@"Click restart on the left.";
        }
      }
    -(void)SillyComputerMove {
        BOOL madeMove = false;
        BOOL criticalMoveMade = false;
        BOOL canSaveCritical = false;
        NSLog(@"%@", @"checking critical...");//THIS STATEMENT was RUNNING TWICE IN ONE MOVE, so I have to fix it this way: by having a very very long method to avoid any kind of if([self checkCritical]) because Everytime i have an if statement, the method inside the statement is run again!!
        BOOL isCritical = false;
        BOOL checked = false;
        [self checkBoard];
        for (int a=0; a<5; a++) {
            for (int b=0; b<5; b++){
                if (checked) break;
                int tempVal = board[a][b];
                
                NSLog(@"Now looking at %d for row %d and col %d ",tempVal,a,b);
                if (board[a][b]>1 || board[a][b]<-1) {
                    isCritical=true;
                    NSLog(@"is critical = true!");
                    self.criticalRow=a;
                    self.criticalCol=b;
                    NSLog(@"%d, %d", self.criticalRow, self.criticalCol);
                }
            }
        }
        if (isCritical) {
            int criticalNum=0;
            //find the empty cell of the array and make the computer move
            //scenario 1: the vertical columns have critical situation; human player is about to win
            if (self.criticalRow==3&&self.criticalCol<3) {
                criticalNum=self.criticalCol;
                for (int i=0; i<3; i++) {
                    if (madeMove) break;
                    if (board[i][criticalNum]==0) {
                        canSaveCritical=true;
                        if (canSaveCritical) {
                            board[i][criticalNum]=(self.count%2)*(-1);
                            NSLog(@"Critical move coordinates: %d, %d", i, criticalNum);
                            [self updateButtonText];
                            self.count++;
                            madeMove = true;
                            criticalMoveMade=true;
                            [self winning];
                        }
   
                    }
                    
                    
                }
            }
            //scenario 2: horizontal columns are critical. Human player is about to win.
            if (self.criticalCol==3&&self.criticalRow<3){
                criticalNum=self.criticalRow;
                for (int i=0; i<3; i++) {
                    if (madeMove) break;
                    if (board[criticalNum][i]==0) {
                        canSaveCritical=true;
                        if (canSaveCritical) {
                        board[criticalNum][i]=(self.count%2)*(-1);
                        NSLog(@"Critical move coordinates: %d, %d", criticalNum, i);
                        [self updateButtonText];
                        self.count++;
                        madeMove = true;
                        criticalMoveMade=true;
                            [self winning];
                        }
                    }
                    
                }

            }
            //scenario 3: the left diagonal 3 cells are critical
            if (self.criticalRow==self.criticalCol&&self.criticalRow==3) {
            criticalNum=self.criticalRow;
                for (int i=0; i<3; i++) {
                    if (madeMove) break;
                    if (board[i][i]==0) {
                        canSaveCritical=true;
                        if (canSaveCritical) {
                        board[i][i]=(self.count%2)*(-1);
                        NSLog(@"Critical move coordinates: %d, %d", i, i);
                        [self updateButtonText];
                        self.count++;
                        madeMove = true;
                        criticalMoveMade=true;
                            [self winning];
                        }
                    }
                    
                }

            }
            //scenario 4: the right diagonal three cells are critical
            if (self.criticalRow==4) {
                criticalNum=self.criticalRow;
                for (int i=0; i<3; i++) {
                    if (madeMove) break;
                    if (board[2-i][i]==0) {
                        canSaveCritical=true;
                        if (canSaveCritical) {
                        board[2-i][i]=(self.count%2)*(-1);
                        NSLog(@"Critical move coordinates: %d, %d", 2-i, i);
                        [self updateButtonText];
                        self.count++;
                        madeMove = true;
                        criticalMoveMade=true;
                            [self winning];
                        }
                    }
                 
                }
            }
            
        }
  
        
        else if (!isCritical || (isCritical&&(!canSaveCritical))) {
        NSLog(@"not critical!");
            //NSMutableArray *availableCells = [NSMutableArray arrayWithCapacity:9];
        for (int i=0; i<3; i++) {
            if (madeMove) break;
            for (int j=0; j<3; j++) {
                if(madeMove) break;
                if (board[i][j]==0) {
                    board[i][j]=-(self.count%2);
                    NSLog(@"normal move location: %d, %d", i, j);
                    NSLog(@"%d", board[i][j]);
                    [self updateButtonText];
                    self.count++;
                    madeMove=true;
                    [self winning];
                    NSLog(@"%@ %d", @"Made normal move, self.count:", self.count);

                }
    }

        }
            
        }
        
        //NSLog(@"%@", @"No Critical Move needed.");
    }
    /*


    -(BOOL)checkCriticalStep {
        NSLog(@"%@", @"checking critical...");//THIS STATEMENT IS RUNNING TWICE IN ONE MOVE???
        BOOL isCritical = false;
        BOOL checked = false;
        [self checkBoard];
        for (int a=0; a<5; a++) {
            for (int b=0; b<5; b++){
                if (checked) break;
                int tempVal = board[a][b];
                
                NSLog(@"Now looking at %d for row %d and col %d ",tempVal,a,b);
                if (board[a][b]>1 || board[a][b]<-1) {
                    isCritical=true;
                    NSLog(@"is critical = true!");
                    self.criticalRow=a;
                    self.criticalCol=b;
                    NSLog(@"%d, %d", self.criticalRow, self.criticalCol);
                    return isCritical;
                }
            }
        }
        return isCritical;
        
    }

    -(void)makeCriticalMove {
        BOOL madeMove = false;
        BOOL criticalMoveMade = false;
                for (int j=0; j<3; j++) {
                if (board[self.criticalRow-1][j]==0 && self.count%2==1) {
                    board[self.criticalRow-1][j]=-1;
                    NSLog(@"Critical move coordinates: %d, %d", self.criticalRow, j);
                    [self updateButtonText];
                    self.count++;
                    madeMove = true;
                    criticalMoveMade=true;
                    NSLog(@"critical step moved! criticalMoveMade = %hhd", criticalMoveMade);
                    
                }
                else if (board[self.criticalRow-1][j]==0 && self.count%2==0) {
                    board[self.criticalRow-1][j]=1;
                    NSLog(@"Critical move coordinates: %d, %d", self.criticalRow, j);
                    [self updateButtonText];
                    self.count++;
                    madeMove = true;
                    criticalMoveMade=true;
                    NSLog(@"critical step moved! criticalMove = %hhd", criticalMoveMade);
                }
                }

        
        NSLog(@"%@", @"No Critical Move needed.");
    }

    */
    /*-(BOOL)checkCriticalStep {
        [self checkBoard];
        BOOL isCritical = false;
        NSLog(@"@I'm mad! isCritical = %hhd", isCritical);
        BOOL madeMove = false;
        BOOL criticalMoveMade = false;
        BOOL checked = false;
        int criticalRow=0;
        int criticalCol=0;
        NSLog(@"@really mad? critical move made = %hhd", criticalMoveMade);
        NSLog(@"%@", @"checking critical...");//THIS STATEMENT IS RUNNING TWICE IN ONE MOVE???

        for (int a=0; a<5; a++) {
            for (int b=0; b<5; b++){
                if (checked) break;
                int tempVal = board[a][b];
                NSLog(@"Now looking at %d for row %d and col %d ",tempVal,a,b);
                if (board[a][b]>1 || board[a][b]<-1) {
                    isCritical=true;
                    NSLog(@"is critical = true!");
                    criticalRow=a;
                    criticalCol=b;
                    NSLog(@"%d, %d", criticalRow, criticalCol);
                    if (isCritical) {
                        for (int j=0; j<3; j++) {
                            if (board[criticalRow-1][j]==0 && self.count%2==1) {
                                board[criticalRow-1][j]=-1;
                                NSLog(@"Critical move coordinates: %d, %d", criticalRow, j);
                                [self updateButtonText];
                                self.count++;
                                madeMove = true;
                                criticalMoveMade=true;
                                NSLog(@"critical step moved! criticalMoveMade = %hhd", criticalMoveMade);
                                return criticalMoveMade;
                            }
                            else if (board[criticalRow-1][j]==0 && self.count%2==0) {
                                board[criticalRow-1][j]=1;
                                NSLog(@"Critical move coordinates: %d, %d", criticalRow, j);
                                [self updateButtonText];
                                self.count++;
                                madeMove = true;
                                criticalMoveMade=true;
                                NSLog(@"critical step moved! criticalMove = %hhd", criticalMoveMade);
                                return criticalMoveMade;
                            }
                        }
                    }
                    
                }
                NSLog(@"%@, %hhd", @"not look like critical..., the value of criticalMoveMade:", criticalMoveMade);
            }
        }
        NSLog(@"%@, %hhd", @"not look like critical..., outest }: the value of criticalMoveMade:", criticalMoveMade);
        checked=true;
        return criticalMoveMade;
    }
    */
    - (void)viewDidLoad
    {
        [super viewDidLoad];
        UIBarButtonItem *customBarButton = [[UIBarButtonItem alloc]initWithTitle:@"Restart" style:UIBarButtonItemStyleBordered target:self action:@selector(back)];
        self.navigationItem.leftBarButtonItem = customBarButton;
        playerNum = selectedButton;
        NSLog(@"%@%d", @"playernum = ", playerNum);
        if (playerNum==1){
            UIAlertView *chooseOrder = [[UIAlertView alloc]initWithTitle:@"Choose play order" message:@"Do you want to go first?" delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No", nil];
            chooseOrder.tag=0;
            [chooseOrder show];
      
        }
        
        // Do any additional setup after loading the view, typically from a nib.
    }
- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}
-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    //u need to change 0 to other value(,1,2,3) if u have more buttons.then u can check which button was pressed.
    if (alertView.tag==0) {
        if (buttonIndex == 0) { //user wants to go first in 1 player mode
            self.order=0;
        }
        if (buttonIndex == 1) {
            self.order=1;
        }
        NSLog(@"self order is: %d", self.order);
        if (playerNum==1 && self.order==0) NSLog(@"1 player, go first");
        if (playerNum==1 && self.order==1) {
            self.count=1;
            NSLog(@"1 player wants to go second, self.count: %d", self.count);
            [self SillyComputerMove];
        }
    }
    if (alertView.tag==1) {
        
    }
    
    
}


    - (void)didReceiveMemoryWarning
    {
        [super didReceiveMemoryWarning];
        // Dispose of any resources that can be recreated.
    }

    @end

//
//  PlayingCardGameViewController.m
//  Matchismo
//
//  Created by Henry on 17/12/14.
//  Copyright (c) 2014 Henry. All rights reserved.
//

#import "PlayingCardGameViewController.h"
#import "PlayingCardDeck.h"

@interface PlayingCardGameViewController ()
@property (weak, nonatomic) IBOutlet UISegmentedControl *gameModeSegmentedControl;

@end

@implementation PlayingCardGameViewController


- (Deck *) createDeck {
	return [[PlayingCardDeck alloc] init];
}
- (IBAction)changeGameMode:(UISegmentedControl *)sender {
	if (self.gameModeSegmentedControl.selectedSegmentIndex == 0) {
		self.game.numberOfCardToMatch = 2;
	} else {
		self.game.numberOfCardToMatch = 3;
	}
	
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

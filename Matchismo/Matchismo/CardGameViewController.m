//
//  ViewController.m
//  Matchismo
//
//  Created by Henry on 15/12/14.
//  Copyright (c) 2014 Henry. All rights reserved.
//

#import "CardGameViewController.h"
#import "CardMatchingGame.h"
#import "PlayingCardDeck.h"

@interface CardGameViewController ()
/*
@property (strong, nonatomic) Deck *deck;
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) int flipCount;
 */

@property (strong, nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) NSMutableArray *gameHistory;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *gameModeSegmentedControl;
@property (weak, nonatomic) IBOutlet UILabel *lastStatusLabel;
@property (weak, nonatomic) IBOutlet UISlider *gameHistorySlider;
@end

@implementation CardGameViewController

- (CardMatchingGame *)game{
	if (!_game) {
		_game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count] usingDeck:[self createDeck]];
		[self changeGameMode:self.gameModeSegmentedControl];
		self.gameHistory = nil;
	}
	return _game;
}

- (NSMutableArray *)gameHistory {
	if (!_gameHistory) {
		_gameHistory = [[NSMutableArray alloc] init];
	}
	return _gameHistory;
}

- (Deck *)createDeck {
	return [[PlayingCardDeck alloc] init];
}


- (IBAction)changeGameMode:(UISegmentedControl *)sender {
	if (self.gameModeSegmentedControl.selectedSegmentIndex == 0) {
		self.game.numberOfCardToMatch = 2;
	} else {
		self.game.numberOfCardToMatch = 3;
	}
	
}


/*
- (Deck *)deck {
	if (!_deck) {
		_deck = [self createDeck];
	}
	return _deck;
}

- (void)setFlipCount:(int)flipCount {
	_flipCount = flipCount;
	self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
	NSLog(@"flipCount = %d", self.flipCount);
}
 */
- (IBAction)touchCardButton:(UIButton *)sender {
	NSUInteger chosenButtonIndex = [self.cardButtons indexOfObject:sender];
	[self.game chooseCardAtIndex:chosenButtonIndex];
	[self updateUI];
	/*
	if ([sender.currentTitle length]) {
		[sender setBackgroundImage:[UIImage imageNamed:@"cardback"]
						  forState:UIControlStateNormal];
		[sender setTitle:@"" forState:UIControlStateNormal];
		self.flipCount++;
	} else {
		Card *card = [self.deck drawRandomCard];
		if (card) {
			[sender setBackgroundImage:[UIImage imageNamed:@"cardfront"]
							  forState:UIControlStateNormal];
			[sender setTitle:card.contents forState:UIControlStateNormal];
			self.flipCount++;
			
		}
	}
	 */
}
- (IBAction)touchNewGameButton:(UIButton *)sender {
	self.game = nil;
	[self updateUI];
}

- (void)updateUI {
	for (UIButton *cardButton in self.cardButtons) {
		NSUInteger cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
		Card *card = [self.game cardAtIndex:cardButtonIndex];
		[cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
		[cardButton setBackgroundImage:[self imageForCard:card] forState:UIControlStateNormal];
		cardButton.enabled = !card.isMatched;
	}
	self.scoreLabel.text = [NSString stringWithFormat:@"Score : %ld", (long)self.game.score];
	self.gameModeSegmentedControl.enabled = self.game.gameStarted ? NO : YES;
	//Update Status
	NSString *lastStatus = @"";
	if (self.game && self.game.gameStarted && self.game.lastChosenCards) {
		NSMutableArray *chosenCardsArray = [[NSMutableArray alloc] init];
		for (Card *card in self.game.lastChosenCards) {
			[chosenCardsArray addObject:card.contents];
		}
		lastStatus = [chosenCardsArray componentsJoinedByString:@" "];
		if (self.game.lastScore > 0) {
			lastStatus = [NSString stringWithFormat:@"Matched %@ for %ld points", lastStatus, (long)self.game.lastScore];
		} else if (self.game.lastScore < 0) {
			lastStatus = [NSString stringWithFormat:@"%@ don’t match! %ld point penalty!", lastStatus, 0 - (long)self.game.lastScore];
		}
		
	} else {
		lastStatus= @"";
	}
	if (lastStatus.length && ![lastStatus isEqualToString:[self.gameHistory lastObject]]) {
		[self.gameHistory addObject:lastStatus];
		self.gameHistorySlider.maximumValue = self.gameHistory.count - 1;
		[self.gameHistorySlider setValue:self.gameHistorySlider.maximumValue animated:YES];

	}
	self.lastStatusLabel.alpha = 1;
	self.lastStatusLabel.text  = lastStatus;
}

- (IBAction)slideGameHistorySlider:(UISlider *)sender {
	int sliderValue = (int)lroundf(sender.value);
	[self.gameHistorySlider setValue:sliderValue animated:NO];
	self.lastStatusLabel.alpha =  (sliderValue == (int)self.gameHistorySlider.maximumValue ) ? 1 : 0.5;
	self.lastStatusLabel.text = self.gameHistory[sliderValue];
}

- (NSString *)titleForCard:(Card *)card {
	return card.isChosen ? card.contents : @"";
}

- (UIImage *)imageForCard:(Card *)card {
	return card.isChosen ? [UIImage imageNamed:@"cardfront"] : [UIImage imageNamed:@"cardback"];
}


- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	self.lastStatusLabel.text = @"";
	self.gameHistorySlider.maximumValue = self.gameHistory.count;
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

@end

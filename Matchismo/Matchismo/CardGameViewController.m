//
//  ViewController.m
//  Matchismo
//
//  Created by Henry on 15/12/14.
//  Copyright (c) 2014 Henry. All rights reserved.
//

#import "CardGameViewController.h"
#import "CardMatchingGame.h"
#import "HistoryViewController.h"

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
@property (weak, nonatomic) IBOutlet UILabel *lastStatusLabel;
//@property (weak, nonatomic) IBOutlet UISegmentedControl *gameModeSegmentedControl;
//@property (weak, nonatomic) IBOutlet UISlider *gameHistorySlider;
@end

@implementation CardGameViewController

#pragma mark - Setters and Getters 

- (CardMatchingGame *)game{
	if (!_game) {
		_game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
												  usingDeck:[self createDeck]
									  matchingNumberOfCards:[self numberOfCardsToMatch]];
//		[self changeGameMode:self.gameModeSegmentedControl];
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

#pragma mark - Abstract Methods
- (Deck *)createDeck {
	return nil;
}

- (NSUInteger)numberOfCardsToMatch {
	return 0;
}

/*
- (IBAction)changeGameMode:(UISegmentedControl *)sender {
	if (self.gameModeSegmentedControl.selectedSegmentIndex == 0) {
		self.game.numberOfCardToMatch = 2;
	} else {
		self.game.numberOfCardToMatch = 3;
	}
	
}
*/

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

#pragma mark - Actions
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


#pragma mark - UI Related
- (void)updateUI {
	for (UIButton *cardButton in self.cardButtons) {
		NSUInteger cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
		Card *card = [self.game cardAtIndex:cardButtonIndex];
		[cardButton setAttributedTitle:[self cardFaceTitleForCard:card] forState:UIControlStateNormal];
		[cardButton setBackgroundImage:[self imageForCard:card] forState:UIControlStateNormal];
		cardButton.enabled = !card.isMatched;
	}
	self.scoreLabel.text = [NSString stringWithFormat:@"Score : %ld", (long)self.game.score];
//	self.gameModeSegmentedControl.enabled = self.game.gameStarted ? NO : YES;
	//Update Status
	NSAttributedString* lastStatus = [self lastStatusForChosenCards:self.game.lastChosenCards withScore:self.game.lastScore];
	
	if (lastStatus.length && ![lastStatus isEqualToAttributedString:[self.gameHistory lastObject]]) {
		[self.gameHistory addObject:lastStatus];
	//	self.gameHistorySlider.maximumValue = self.gameHistory.count - 1;
	//	[self.gameHistorySlider setValue:self.gameHistorySlider.maximumValue animated:YES];

	}
	self.lastStatusLabel.alpha = 1;
	self.lastStatusLabel.attributedText = lastStatus;
}

-(NSAttributedString *)lastStatusForChosenCards:(NSArray *)lastChosenCards withScore:(NSInteger)lastScore {
	NSMutableAttributedString *cardsAttributedString = [[NSMutableAttributedString alloc] init];
	if (lastChosenCards) {
		if (lastChosenCards.count > 0) {

			for (int i = 0; i<lastChosenCards.count; i++) {
				Card *card = lastChosenCards[i];
				[cardsAttributedString appendAttributedString:[self attributedTitleForCard:card]];
				if (i != lastChosenCards.count -1) {
					[cardsAttributedString appendAttributedString:[[NSAttributedString alloc] initWithString:@" "]];
				}
			}
			if (lastScore > 0) {
				[cardsAttributedString appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@" matched for %ld points", (long)lastScore]]];
			} else if (lastScore < 0) {
				[cardsAttributedString appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@" don't match! %ld points penalty!", 0 - (long)lastScore]]];
			}
		} else {
			cardsAttributedString = [[NSMutableAttributedString alloc] initWithString:@"Ready"];
		}
		
	} else {
		cardsAttributedString = [[NSMutableAttributedString alloc] initWithString:@""];
	}
	return [cardsAttributedString copy];
}
/*
- (IBAction)slideGameHistorySlider:(UISlider *)sender {
	int sliderValue = (int)lroundf(sender.value);
	[self.gameHistorySlider setValue:sliderValue animated:NO];
	self.lastStatusLabel.alpha =  (sliderValue == (int)self.gameHistorySlider.maximumValue ) ? 1 : 0.5;
	//self.lastStatusLabel.text = self.gameHistory[sliderValue];
}
*/
- (NSAttributedString *)cardFaceTitleForCard:(Card *)card {
	return  card.isChosen ? [[NSAttributedString alloc] initWithString:card.contents] : [[NSAttributedString alloc] initWithString:@""] ;
}

- (NSAttributedString *)attributedTitleForCard:(Card *)card {
	return [[NSAttributedString alloc] initWithString:card.contents];
}


- (UIImage *)imageForCard:(Card *)card {
	return card.isChosen ? [UIImage imageNamed:@"cardfront"] : [UIImage imageNamed:@"cardback"];
}


#pragma mark - Callbacks

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	UIViewController *historyVC = [segue destinationViewController];
	if ([historyVC isKindOfClass:[HistoryViewController class]]) {
		HistoryViewController *historyViewController = (HistoryViewController *) historyVC;
		historyViewController.history = self.gameHistory;
	}
	// Get the new view controller using [segue destinationViewController].
	// Pass the selected object to the new view controller.
}

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
//	self.lastStatusLabel.text = @"";
//	self.gameHistorySlider.maximumValue = self.gameHistory.count;
	[self updateUI];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

@end

//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Henry on 15/12/14.
//  Copyright (c) 2014 Henry. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()
@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, readwrite) BOOL gameStarted;
@property (nonatomic, strong) NSMutableArray *cards; //of Cards
@property (nonatomic, readwrite) NSInteger lastScore;
@property (nonatomic, readwrite, strong) NSArray *lastChosenCards;
@end

@implementation CardMatchingGame

- (NSMutableArray *) cards {
	if (!_cards) {
		_cards = [[NSMutableArray alloc] init];
	}
	return _cards;
}

- (NSUInteger) numberOfCardToMatch {
	if (_numberOfCardToMatch < 2) {
		_numberOfCardToMatch = 2;
	}
	return _numberOfCardToMatch;
}

- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck {
	self = [super init]; //super designated initializer
	if (self) {
		self.gameStarted = NO;
		self.lastChosenCards = nil;
		self.lastScore = 0;
		for (int i = 0; i<count; i++) {
			Card *card = [deck drawRandomCard];
			if (card) {
				[self.cards addObject:card];
			} else {
				self = nil;
				break;
			}
		}
	}
	return self;
}

- (Card *)cardAtIndex:(NSUInteger)index {
	return (index < [self.cards count]) ? self.cards[index] : nil;
}

static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;

- (void)chooseCardAtIndex:(NSUInteger)index {
	Card *card = [self cardAtIndex:index];
	self.gameStarted = YES;
	self.lastScore = 0;
	if (!card.isMatched) {
		if (card.isChosen) {
			card.chosen = NO;  //close card
			NSMutableArray *currentChosenCards = [self.lastChosenCards mutableCopy];
			[currentChosenCards removeObject:card];
			self.lastChosenCards = [currentChosenCards copy];
			
		} else {
			NSMutableArray *otherCards = [[NSMutableArray alloc] init];
			//match against other cards
			for (Card *otherCard in self.cards) {
				if (otherCard.isChosen && !otherCard.isMatched) {
					[otherCards addObject:otherCard];
				}
			}
			
			if (otherCards.count == self.numberOfCardToMatch -1) {
				int matchScore = [card match:otherCards];
				if (matchScore) {
					self.lastScore =  matchScore * MATCH_BONUS;
					self.score += self.lastScore;
					card.matched = YES;
					for (Card *otherCard in otherCards) {
						otherCard.matched = YES;
						
					}
				} else {
					self.lastScore -= MISMATCH_PENALTY;
					self.score += self.lastScore;
					for (Card *otherCard in otherCards) {
						otherCard.chosen = NO;
					}
				}
				
				
			}
			self.lastChosenCards = [otherCards arrayByAddingObject:card];
			self.score -= COST_TO_CHOOSE;
			card.chosen = YES;
		}
		
	}
}




@end
